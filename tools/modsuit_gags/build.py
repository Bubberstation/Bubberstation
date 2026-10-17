"""
Builds the MODsuit GAGS assets from the original MODsuit sprites.

  python tools/modsuit_gags/build.py              rebuild every skin
  python tools/modsuit_gags/build.py loader ninja rebuild only these skins

Writes, for each skin:
  modular_zubbers/icons/mob/clothing/modsuit/gags/<skin>.dmi
  modular_zubbers/code/datums/greyscale/json_configs/modsuit/<skin>_<role>.json
and always rewrites modular_zubbers/code/modules/mod/gags/mod_gags_skins.dm.

Run check.py afterwards. It must report 0 mismatched pixels.
"""
import json
import math
import os
import sys

import numpy as np
from PIL import Image
from PIL.PngImagePlugin import PngInfo

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gags_math import REPO, hls, meta_blocks  # noqa: E402
from rules import LAYOUT, ROLE, dmi, make, states_for  # noqa: E402

ICON_DIR = "modular_zubbers/icons/mob/clothing/modsuit/gags/"
JSON_DIR = "modular_zubbers/code/datums/greyscale/json_configs/modsuit/"
DM_FILE = "modular_zubbers/code/modules/mod/gags/mod_gags_skins.dm"
MANIFEST = os.path.join(os.path.dirname(os.path.abspath(__file__)), "manifest.json")

# Display names in the GAGS config list, when the skin name alone reads badly
NICE = {"praetorian": "Praetorian", "debug": "Bluespace", "advanced": "Advanced", "magnate": "Magnate",
        "safeguard": "Safeguard", "responsory": "Responsory", "lustwish": "LustWish"}

# Skins that spawn in other colors than stock: channel -> how the channel should LOOK.
# The build converts it to the GAGS input color, which is brighter, since GAGS multiplies it into the shading.
DEFAULT_LOOKS = {"engineering": {"shell": "#d88f2c"}}


def hexs(c):
    return "#%02x%02x%02x" % tuple(int(v) for v in c)


def lum(c):
    return 0.299 * c[0] + 0.587 * c[1] + 0.114 * c[2]


def look_to_input(skin, channel, hex_color):
    """GAGS input color that makes this channel's middle shade look like hex_color"""
    pool = dict(skin.pools[channel])
    colors = [c for c in pool if hls(c)[1] > 0.08] or list(pool)
    colors = sorted(colors, key=lum)
    weights = np.cumsum([pool[c] for c in colors])
    weights = weights / weights[-1]
    tone = np.array(colors[int(np.searchsorted(weights, 0.5))], float)
    target = np.array([int(hex_color[i:i + 2], 16) for i in (1, 3, 5)], float)
    out = target * (lum(skin.defaults[channel]) / max(lum(tone), 1))
    if out.max() > 255:
        out *= 255 / out.max()
    return np.round(out).astype(int)


def write_dmi(path, states):
    """states: [(name, metadata lines, [frames])]"""
    total = sum(len(frames) for _, _, frames in states)
    cols = max(1, math.ceil(math.sqrt(total)))
    rows = math.ceil(total / cols)
    sheet = np.zeros((rows * 32, cols * 32, 4), np.uint8)
    desc = "# BEGIN DMI\nversion = 4.0\n\twidth = 32\n\theight = 32\n"
    i = 0
    for name, meta, frames in states:
        desc += f'state = "{name}"\n{meta}\n'
        for frame in frames:
            y, x = divmod(i, cols)
            sheet[y * 32:(y + 1) * 32, x * 32:(x + 1) * 32] = frame.astype(np.uint8)
            i += 1
    desc += "# END DMI\n"
    info = PngInfo()
    info.add_text("Description", desc, zip=True)  # zTXt, like BYOND writes
    os.makedirs(os.path.dirname(path), exist_ok=True)
    Image.fromarray(sheet, "RGBA").save(path, format="PNG", pnginfo=info, optimize=True)


def build(name):
    skin = make(name)
    channels = [ch for ch, _ in LAYOUT[name]]
    made = sorted(skin.defaults)
    assert sorted(channels) == made, f"{name}: LAYOUT lists {sorted(channels)}, the rules make {made}"
    color_id = {ch: i + 1 for i, ch in enumerate(channels)}
    dmi_states = [("gags_blank", "\tdirs = 1\n\tframes = 1", [np.zeros((32, 32, 4), np.int32)])]
    configs = {}
    roles = {}
    for f in skin.sources:
        role = ROLE[f]
        meta = meta_blocks(f)
        config = {}
        for state in states_for(f, name):
            per = {}
            for i, frame in enumerate(dmi(f).frames(state)):
                _, layers, add, sub = skin.split(frame, state, f, i)
                for ch in channels + ["fixed"]:
                    per.setdefault(ch, []).append(layers.get(ch, np.zeros((32, 32, 4), np.int32)))
                per.setdefault("add", []).append(add)
                per.setdefault("sub", []).append(sub)
            layers = []
            for ch in channels + ["fixed"]:
                if any(x[..., 3].any() for x in per[ch]):
                    layer_name = f"{role}.{state}.{ch}"
                    dmi_states.append((layer_name, meta[state], per[ch]))
                    layer = {"type": "icon_state", "icon_state": layer_name, "blend_mode": "overlay"}
                    if ch != "fixed":
                        layer["color_ids"] = [color_id[ch]]
                    layers.append(layer)
            if not layers:
                layer_name = f"{role}.{state}.fixed"
                dmi_states.append((layer_name, meta[state], per["fixed"]))
                layers.append({"type": "icon_state", "icon_state": layer_name, "blend_mode": "overlay"})
            for key, mode in (("add", "add"), ("sub", "subtract")):
                if any(x[..., :3].any() for x in per[key]):
                    layer_name = f"{role}.{state}.{key}"
                    dmi_states.append((layer_name, meta[state], per[key]))
                    layers.append({"type": "icon_state", "icon_state": layer_name, "blend_mode": mode})
            config[state] = layers
        add_missing_channels(config, channels, color_id)
        configs[role] = config
        roles[role] = f
    # The paint kit menu: inventory and worn states together, so every channel shows up
    menu = {}
    for role in ("obj", "worn"):
        for state, layers in configs.get(role, {}).items():
            if state != "gags_channels":
                menu[f"{role} {state}"] = layers
    add_missing_channels(menu, channels, color_id)
    configs["menu"] = menu
    roles["menu"] = None

    write_dmi(REPO + ICON_DIR + f"{name}.dmi", dmi_states)
    os.makedirs(REPO + JSON_DIR, exist_ok=True)
    for role, config in configs.items():
        with open(REPO + JSON_DIR + f"{name}_{role}.json", "w") as out:
            json.dump(config, out, indent="\t")
    stock = "".join(hexs(skin.defaults[ch]) for ch in channels)
    default = stock
    if name in DEFAULT_LOOKS:
        cols = dict(skin.defaults)
        for ch, look in DEFAULT_LOOKS[name].items():
            cols[ch] = look_to_input(skin, ch, look)
        default = "".join(hexs(cols[ch]) for ch in channels)
    module_states = sorted({s for role in ("modules", "voxmodules", "digi") for s in configs.get(role, {}) if s.startswith("module_")})
    return {"channels": channels, "labels": [label for _, label in LAYOUT[name]], "stock": stock, "default": default,
            "roles": roles, "module_states": module_states}


def add_missing_channels(config, channels, color_id):
    """GAGS needs every config to use every color, or previews crash. Pad with a blank state."""
    used = {i for layers in config.values() for layer in layers for i in layer.get("color_ids", [])}
    missing = [color_id[ch] for ch in channels if color_id[ch] not in used]
    if missing:
        config["gags_channels"] = [{"type": "icon_state", "icon_state": "gags_blank", "blend_mode": "overlay"}] + \
            [{"type": "icon_state", "icon_state": "gags_blank", "blend_mode": "overlay", "color_ids": [i]} for i in missing]


def write_registry(manifest):
    out = ["// This file is generated from the MODsuit GAGS split tool. Every config here rebuilds its skin's",
           "// original sprites pixel for pixel at the stock colors. Edit the tool, not this file.",
           "// The tool: tools/modsuit_gags (see its README).", ""]
    entries = []
    for name in LAYOUT:
        m = manifest[name]
        nice = NICE.get(name, name.capitalize())
        for role in m["roles"]:
            out.append(f"/datum/greyscale_config/mod_gags_{name}_{role}")
            out.append(f'\tname = "MODsuit {nice} ({role})"')
            out.append(f"\ticon_file = '{ICON_DIR}{name}.dmi'")
            out.append(f"\tjson_config = '{JSON_DIR}{name}_{role}.json'")
            out.append("")
        files = [f'"{src}" = /datum/greyscale_config/mod_gags_{name}_{role}' for role, src in m["roles"].items() if src]
        entry = [f"/datum/mod_gags_skin/{name}",
                 f'\tskin = "{name}"',
                 f'\tstock_colors = "{m["stock"]}"',
                 f'\tdefault_colors = "{m["default"]}"',
                 "\tcolor_labels = list(" + ", ".join(f'"{i + 1}" = "{label}"' for i, label in enumerate(m["labels"])) + ")",
                 f"\tmenu_config = /datum/greyscale_config/mod_gags_{name}_menu",
                 "\tfile_configs = list(\n\t\t" + ",\n\t\t".join(files) + ",\n\t)"]
        if m["module_states"]:
            entry.append("\tmodule_states = list(" + ", ".join(f'"{s}"' for s in m["module_states"]) + ")")
        entries.append("\n".join(entry) + "\n")
    out.append("")
    out += entries
    with open(REPO + DM_FILE, "w") as f:
        f.write("\n".join(out))


def main(names):
    manifest = {}
    if os.path.exists(MANIFEST):
        with open(MANIFEST) as f:
            manifest = json.load(f)
    for name in names or list(LAYOUT):
        print(f"building {name}...", flush=True)
        manifest[name] = build(name)
    missing = [n for n in LAYOUT if n not in manifest]
    if missing:
        sys.exit(f"No build data for {missing}. Run without arguments once to build every skin.")
    with open(MANIFEST, "w") as f:
        json.dump(manifest, f, indent=1)
    write_registry(manifest)
    print("done. Now run check.py.")


if __name__ == "__main__":
    main(sys.argv[1:])
