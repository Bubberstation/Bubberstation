"""
Replays every generated MODsuit GAGS config at its stock colors, with the same math GAGS uses,
and compares the result to the original sprites: every state, direction and frame.

  python tools/modsuit_gags/check.py              check every skin
  python tools/modsuit_gags/check.py loader ninja check only these skins

Exits non-zero if any pixel or any state metadata differs.
"""
import json
import os
import re
import sys

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build import DM_FILE, ICON_DIR, JSON_DIR  # noqa: E402
from gags_math import DMI, REPO, apply_color, blend, meta_blocks  # noqa: E402


def colors(color_string):
    return [np.array([int(c[i:i + 2], 16) for i in (0, 2, 4)]) for c in color_string.split("#")[1:]]


def skins():
    """skin -> (stock colors, {original file: role}) read from the generated registry"""
    text = open(REPO + DM_FILE).read()
    out = {}
    for block in text.split("/datum/mod_gags_skin/")[1:]:
        name = block.split("\n", 1)[0].strip()
        stock = re.search(r'stock_colors = "([^"]+)"', block).group(1)
        files = dict(re.findall(r'"([^"]+)" = /datum/greyscale_config/mod_gags_\w+?_(\w+)', block))
        out[name] = (stock, files)
    return out


def check(name, stock, files):
    generated = DMI(ICON_DIR + f"{name}.dmi")
    generated_meta = meta_blocks(ICON_DIR + f"{name}.dmi")
    cols = colors(stock)
    bad = 0
    total = 0
    problems = []
    for source, role in files.items():
        config = json.load(open(REPO + JSON_DIR + f"{name}_{role}.json"))
        original = DMI(source)
        original_meta = meta_blocks(source)
        for state, layers in config.items():
            if state == "gags_channels":
                continue
            for layer in layers:
                if generated_meta[layer["icon_state"]] != original_meta[state]:
                    problems.append(f"{role} '{state}': layer {layer['icon_state']} has different dirs, frames or delays")
            reference = original.frames(state)
            for k in range(len(reference)):
                result = None
                for layer in layers:
                    pixels = generated.frames(layer["icon_state"])[k].copy()
                    if "color_ids" in layer:
                        pixels = apply_color(pixels, cols[layer["color_ids"][0] - 1])
                    result = pixels if result is None else blend(result, pixels, layer["blend_mode"])
                result[result[..., 3] == 0] = 0
                expected = reference[k].copy()
                expected[expected[..., 3] == 0] = 0
                diff = int((result != expected).any(2).sum())
                bad += diff
                total += int((expected[..., 3] > 0).sum())
                if diff:
                    problems.append(f"{role} '{state}' image {k + 1}: {diff} pixels differ")
    return bad, total, problems


def main(names):
    registry = skins()
    failed = False
    grand_bad = grand_total = 0
    for name in names or list(registry):
        stock, files = registry[name]
        bad, total, problems = check(name, stock, files)
        grand_bad += bad
        grand_total += total
        print(f"{name:12s} {bad} of {total} pixels differ")
        for problem in problems[:10]:
            print("   ", problem)
        failed |= bool(problems)
    print(f"TOTAL {grand_bad} of {grand_total} pixels differ")
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main(sys.argv[1:])
