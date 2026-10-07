"""
How each MODsuit skin is split into color channels.

Every pixel of a skin gets a channel from its color (the rules in SKINS), then a few
positional fixes run (helmet visors, shine, animated core pixels, per-suit posts).
Each channel color is fitted from its pixels, and every pixel is stored as
  greyscale value (multiplied by the channel color) + a fixed add/subtract leftover,
so the stock colors rebuild the original sprite exactly.

Rules take (h, l, s) from colorsys.rgb_to_hls, all 0..1. The first rule that matches wins.
"""
import re
from collections import Counter, defaultdict

import numpy as np
from PIL import Image

from gags_math import DMI, REPO, best_g, fit_color, hls

# Source sprite files
M = "icons/mob/clothing/modsuit/mod_clothing.dmi"
O = "icons/obj/clothing/modsuit/mod_clothing.dmi"
DG = "modular_skyrat/master_files/icons/mob/mod.dmi"
VX = "modular_skyrat/modules/better_vox/icons/clothing/mod.dmi"
MM = "icons/mob/clothing/modsuit/mod_modules.dmi"
VXM = "modular_skyrat/modules/better_vox/icons/clothing/mod_modules.dmi"
LWO = "modular_zubbers/icons/obj/clothing/modsuit/mod_lustwish.dmi"
LWM = "modular_zubbers/icons/mob/clothing/modsuit/mod_lustwish.dmi"
FO = "modular_skyrat/modules/novaya_ert/icons/mod.dmi"
FM = "modular_skyrat/modules/novaya_ert/icons/wornmod.dmi"
ZO = "modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi"
ZM = "modular_zubbers/icons/mob/clothing/modsuit/mod_clothing.dmi"
PRO = "modular_skyrat/modules/blueshield/icons/praetorian.dmi"
PRM = "modular_skyrat/modules/blueshield/icons/worn_praetorian.dmi"
STD = (M, O, DG, VX, MM, VXM)

# Which source file feeds which config role
ROLE = {M: "worn", O: "obj", DG: "digi", VX: "vox", MM: "modules", VXM: "voxmodules",
        LWO: "obj", LWM: "worn", FO: "obj", FM: "worn", ZO: "obj", ZM: "worn", PRO: "obj", PRM: "worn"}

_dmis = {}


def dmi(path):
    if path not in _dmis:
        _dmis[path] = DMI(path)
    return _dmis[path]


def states_for(path, skin):
    """The skin's own states in a file, plus its module faceplate states"""
    pattern = re.compile(rf"^({re.escape(skin)}(-.*)?|module_armorbooster_\w+-{re.escape(skin)}(_.*)?)$")
    return [k for k in dmi(path).fr if pattern.match(k)]


def red(h, l, s):
    return (h >= 0.93 or h < 0.04) and s >= 0.4


def cyan(h, l, s):
    return 0.44 <= h < 0.62 and s >= 0.35 and l >= 0.25


# skin -> (source files, [(channel, rule), ...])
SKINS = {
    "security": (STD, [
        ("visor", lambda h, l, s: s >= 0.5 and 0.05 <= h < 0.2 and l > 0.3),
        ("trim", lambda h, l, s: s >= 0.35 and (h >= 0.9 or h < 0.05) and l >= 0.1),
        ("plate", lambda h, l, s: True)]),
    "engineering": (STD, [
        ("shell", lambda h, l, s: (h < 0.15 or h > 0.95) and s >= 0.25 and l >= 0.06),
        ("joint", lambda h, l, s: l < 0.22),
        ("visor", lambda h, l, s: s >= 0.3 and 0.4 <= h < 0.575),
        ("lights", lambda h, l, s: s >= 0.3 and 0.575 <= h < 0.8),
        ("shell", lambda h, l, s: s >= 0.25),
        ("joint", lambda h, l, s: True)]),
    "civilian": (STD, [
        ("visor", lambda h, l, s: s >= 0.35 and 0.4 < h < 0.6 and l > 0.3),
        ("plate", lambda h, l, s: l >= 0.5),
        ("suit", lambda h, l, s: True)]),
    "medical": (STD, [
        ("lights", lambda h, l, s: s >= 0.45 and 0.44 < h < 0.52),
        ("accent", lambda h, l, s: s >= 0.35 and 0.4 < h < 0.65),
        ("plate", lambda h, l, s: l >= 0.5),
        ("suit", lambda h, l, s: True)]),
    "responsory": (STD, [
        ("visor", lambda h, l, s: s >= 0.35 and 0.4 < h < 0.65 and l > 0.25),
        ("accent", lambda h, l, s: l >= 0.5),
        ("highlight", lambda h, l, s: 0.3 <= l < 0.5),
        ("primary", lambda h, l, s: True)]),
    "apocryphal": (STD, [
        ("accent", red),
        ("glint", lambda h, l, s: s >= 0.35 and 0.45 < h < 0.65 and l > 0.7),
        ("visor", lambda h, l, s: (s >= 0.35 and 0.45 < h < 0.65 and l > 0.2) or l > 0.7),
        ("base", lambda h, l, s: True)]),
    "infiltrator": (STD, [
        ("accent", lambda h, l, s: (h >= 0.93 or h < 0.04) and s >= 0.35),
        ("visor", lambda h, l, s: l > 0.45 and s < 0.2),
        ("base", lambda h, l, s: True)]),
    "syndicate": (STD, [
        ("lights", lambda h, l, s: 0.2 < h < 0.5 and s > 0.5),
        ("red", lambda h, l, s: (h >= 0.93 or h < 0.04) and s >= 0.6 and l >= 0.1),
        ("under", lambda h, l, s: (h >= 0.9 or h < 0.05) and s >= 0.2),
        ("visor", lambda h, l, s: l > 0.45 and s < 0.2),
        ("base", lambda h, l, s: True)]),
    "glitch": (STD, [
        ("pack", red),
        ("bands", lambda h, l, s: 0.6 < h < 0.72 and s >= 0.35 and l >= 0.28),
        ("eyes", lambda h, l, s: 0.25 < h < 0.45 and s >= 0.2 and l >= 0.12)]),
    "standard": (STD, [
        ("lights", lambda h, l, s: s >= 0.35 and 0.45 < h < 0.65),
        ("trim", lambda h, l, s: 0.58 <= h < 0.7 and s >= 0.2 and l >= 0.3),
        ("suit", lambda h, l, s: True)]),
    "voskhod": ((ZO, ZM, DG), [
        ("orange", lambda h, l, s: 0.03 < h < 0.12 and s > 0.45),
        ("green", lambda h, l, s: 0.22 < h < 0.5 and s >= 0.1 and l >= 0.08),
        ("under", lambda h, l, s: l < 0.1 or (s >= 0.2 and 0.5 <= h < 0.75 and l < 0.35)),
        ("armor", lambda h, l, s: True)]),
    "inquisitory": (STD, [
        ("gold", lambda h, l, s: 0.06 < h < 0.2 and s >= 0.3),
        ("red", red),
        ("lights", lambda h, l, s: s >= 0.35 and 0.45 < h < 0.65),
        ("base", lambda h, l, s: True)]),
    "safeguard": (STD, [
        ("arrow", lambda h, l, s: 0.04 <= h < 0.2 and s >= 0.5 and l > 0.35),
        ("stripe", red),
        ("base", lambda h, l, s: True)]),
    "asteroid": (STD, [
        ("lights", lambda h, l, s: s >= 0.35 and 0.45 < h < 0.65),
        ("purple", lambda h, l, s: 0.7 < h < 0.85 and s >= 0.35),
        ("shell", lambda h, l, s: (h < 0.15 or h > 0.97) and s >= 0.25 and l >= 0.08),
        ("base", lambda h, l, s: True)]),
    "advanced": (STD, [
        ("trim", lambda h, l, s: 0.03 <= h < 0.13 and s >= 0.5),
        ("plate", lambda h, l, s: l >= 0.5),
        ("under", lambda h, l, s: True)]),
    "atmospheric": (STD, [
        ("shell", lambda h, l, s: (h < 0.16 or h > 0.97) and s >= 0.25 and l >= 0.08),
        ("lights", lambda h, l, s: 0.44 <= h < 0.56 and s >= 0.5 and l >= 0.45),
        ("teal", lambda h, l, s: 0.44 <= h < 0.66 and s >= 0.3),
        ("base", lambda h, l, s: True)]),
    "chrono": (STD, [
        ("lights", lambda h, l, s: 0.48 <= h < 0.62 and s >= 0.5),
        ("plate", lambda h, l, s: l >= 0.45),
        ("under", lambda h, l, s: True)]),
    "corporate": (STD, [
        ("green", lambda h, l, s: 0.28 <= h < 0.44 and s >= 0.3),
        ("gold", lambda h, l, s: 0.07 <= h < 0.15 and s >= 0.5),
        ("lights", lambda h, l, s: cyan(h, l, s) or (0.55 <= h < 0.65 and s >= 0.35 and l >= 0.2)),
        ("base", lambda h, l, s: True)]),
    "corpsman": (STD, [
        ("lights", lambda h, l, s: (h >= 0.98 or h < 0.02) and s >= 0.9 and l >= 0.48),
        ("red", lambda h, l, s: (h >= 0.9 or h < 0.03) and s >= 0.6),
        ("plate", lambda h, l, s: l >= 0.45),
        ("joints", lambda h, l, s: 0.55 <= h < 0.75),
        ("under", lambda h, l, s: True)]),
    "enchanted": (STD, [
        ("gold", lambda h, l, s: 0.09 <= h < 0.18 and s >= 0.5),
        ("blue", lambda h, l, s: 0.45 <= h < 0.65 and s >= 0.35),
        ("runes", lambda h, l, s: 0.7 <= h < 0.9 and s >= 0.5 and l >= 0.12),
        ("robe", lambda h, l, s: 0.7 <= h < 0.9 and s >= 0.15 and l >= 0.12),
        ("base", lambda h, l, s: True)]),
    "interdyne": (STD, [
        ("lights", lambda h, l, s: 0.5 <= h < 0.63 and s >= 0.6 and l >= 0.4),
        ("orange", lambda h, l, s: 0.03 <= h < 0.12 and s >= 0.35 and l >= 0.3),
        ("red", lambda h, l, s: (h >= 0.9 or h < 0.06) and s >= 0.3),
        ("teal", lambda h, l, s: 0.5 <= h < 0.62 and s >= 0.25),
        ("plate", lambda h, l, s: l >= 0.45),
        ("base", lambda h, l, s: True)]),
    "loader": (STD, [
        ("arms", lambda h, l, s: 0.04 <= h < 0.15 and s >= 0.4),
        ("lights", lambda h, l, s: 0.42 <= h < 0.58 and s >= 0.5),
        ("base", lambda h, l, s: True)]),
    "magnate": (STD, [
        ("gold", lambda h, l, s: 0.07 <= h < 0.15 and s >= 0.5),
        ("purple", lambda h, l, s: 0.68 <= h < 0.8 and s >= 0.4),
        ("blue", lambda h, l, s: 0.52 <= h < 0.66 and s >= 0.35),
        ("base", lambda h, l, s: True)]),
    "mining": (STD, [
        ("lights", lambda h, l, s: 0.45 <= h < 0.63 and s >= 0.35),
        ("base", lambda h, l, s: True)]),
    "rescue": (STD, [
        ("lights", lambda h, l, s: 0.44 <= h < 0.52 and s >= 0.45),
        ("blue", lambda h, l, s: 0.52 <= h < 0.63 and s >= 0.35 and 0.2 <= l < 0.85),
        ("plate", lambda h, l, s: l >= 0.5),
        ("base", lambda h, l, s: True)]),
    "research": (STD, [
        ("purple", lambda h, l, s: 0.72 <= h < 0.86 and s >= 0.5),
        ("lights", lambda h, l, s: 0.44 <= h < 0.62 and s >= 0.35),
        ("base", lambda h, l, s: True)]),
    "lustwish": ((LWO, LWM, DG), [
        ("light", lambda h, l, s: s > 0.3 and 0.22 < h < 0.45 and l > 0.2),
        ("accent", lambda h, l, s: s > 0.3 and 0.7 < h < 0.95),
        ("plate", lambda h, l, s: l >= 0.33),
        ("body", lambda h, l, s: True)]),
    "frontline": ((FO, FM, DG), [
        ("lights", lambda h, l, s: s > 0.6 and l > 0.4),
        ("armor", lambda h, l, s: True)]),
    "ninja": (STD, [
        ("shade", lambda h, l, s: s > 0.35 and 0.15 < l < 0.28),
        ("glow", lambda h, l, s: s > 0.35 and 0.28 <= l < 0.45),
        ("highlight", lambda h, l, s: s > 0.35 and l >= 0.45)]),
    "debug": (STD, [
        ("glowhl", lambda h, l, s: s >= 0.5 and 0.45 <= h < 0.56 and l >= 0.65),
        ("glow", lambda h, l, s: s >= 0.5 and 0.45 <= h < 0.565 and l >= 0.4),
        ("blue", lambda h, l, s: s >= 0.4 and 0.565 <= h < 0.76),
        ("trim", lambda h, l, s: 0.05 <= h < 0.18 and s >= 0.3),
        ("base", lambda h, l, s: True)]),
    "praetorian": ((PRO, PRM, DG, VX), [
        ("visor", lambda h, l, s: (0.45 <= h < 0.62 and 0.3 <= s < 0.9) or (l >= 0.75 and s >= 0.5)),
        ("lights", lambda h, l, s: s >= 0.9 and 0.45 <= h < 0.56 and l >= 0.38),
        ("blue", lambda h, l, s: s >= 0.9 and 0.55 <= h < 0.72),
        ("base", lambda h, l, s: True)]),
}

# Channel order in the paint menu, and the label players see. Every channel the rules make must be listed.
LAYOUT = {
    'security': [('plate', 'Primary'), ('trim', 'Accent'), ('visor', 'Visor'), ('core', 'Core')],
    'engineering': [('joint', 'Undersuit'), ('shell', 'Primary'), ('lights', 'Lights'), ('shade', 'Glass shade'), ('visor', 'Visor'), ('visorhl', 'Visor highlight'), ('core', 'Core')],
    'lustwish': [('plate', 'Primary'), ('body', 'Undersuit'), ('accent', 'Accent'), ('accenthl', 'Accent highlight'), ('light', 'Lights'), ('visor', 'Visor'), ('visorhl', 'Visor highlight')],
    'frontline': [('armor', 'Primary'), ('visor', 'Visor'), ('lights', 'Lights')],
    'voskhod': [('under', 'Undersuit'), ('armor', 'Primary'), ('orange', 'Lights'), ('visor', 'Visor'), ('green', 'Camo bands'), ('core', 'Core')],
    'ninja': [('glow', 'Lights'), ('shade', 'Lights shade'), ('highlight', 'Lights highlight'), ('core', 'Core')],
    'advanced': [('under', 'Undersuit'), ('plate', 'Primary'), ('trim', 'Trim'), ('core', 'Core')],
    'apocryphal': [('base', 'Primary'), ('accent', 'Accent'), ('glint', 'Visor glint'), ('visor', 'Visor'), ('core', 'Core')],
    'asteroid': [('base', 'Undersuit'), ('shell', 'Primary'), ('lights', 'Lights'), ('purple', 'Accent'), ('visor', 'Visor'), ('core', 'Core')],
    'atmospheric': [('base', 'Undersuit'), ('shell', 'Primary'), ('teal', 'Secondary'), ('lights', 'Lights'), ('visor', 'Visor'), ('core', 'Core')],
    'chrono': [('under', 'Undersuit'), ('plate', 'Primary'), ('lights', 'Lights'), ('visor', 'Visor'), ('core', 'Core')],
    'civilian': [('plate', 'Primary'), ('suit', 'Undersuit'), ('visor', 'Visor'), ('core', 'Core')],
    'corporate': [('base', 'Primary'), ('green', 'Accent'), ('lights', 'Lights'), ('gold', 'Trim'), ('visor', 'Visor'), ('core', 'Core')],
    'corpsman': [('plate', 'Primary'), ('under', 'Undersuit'), ('joints', 'Frame'), ('red', 'Accent'), ('lights', 'Lights'), ('core', 'Core')],
    'enchanted': [('runes', 'Robe'), ('robe', 'Armor'), ('base', 'Metal'), ('blue', 'Accent'), ('gold', 'Trim'), ('core', 'Core')],
    'glitch': [('pack', 'Backpack'), ('eyes', 'Eyes'), ('bands', 'Arm bands'), ('core', 'Core')],
    'infiltrator': [('base', 'Primary'), ('visor', 'Visor'), ('accent', 'Accent'), ('core', 'Core')],
    'inquisitory': [('base', 'Primary'), ('lights', 'Lights'), ('gold', 'Trim'), ('visor', 'Visor'), ('red', 'Accent'), ('core', 'Core')],
    'interdyne': [('lights', 'Lights'), ('teal', 'Secondary'), ('orange', 'Trim'), ('red', 'Accent'), ('base', 'Undersuit'), ('plate', 'Primary'), ('core', 'Core')],
    'loader': [('base', 'Primary'), ('arms', 'Arms'), ('lights', 'Lights'), ('visor', 'Visor'), ('visorhl', 'Visor highlight'), ('core', 'Core')],
    'magnate': [('base', 'Primary'), ('blue', 'Secondary'), ('purple', 'Accent'), ('gold', 'Trim'), ('core', 'Core')],
    'medical': [('suit', 'Undersuit'), ('plate', 'Primary'), ('accent', 'Accent'), ('lights', 'Lights'), ('dome', 'Dome'), ('core', 'Core')],
    'mining': [('base', 'Primary'), ('lights', 'Lights'), ('visor', 'Visor'), ('core', 'Core')],
    'rescue': [('base', 'Undersuit'), ('blue', 'Accent'), ('lights', 'Lights'), ('plate', 'Primary'), ('core', 'Core')],
    'research': [('base', 'Primary'), ('lights', 'Lights'), ('purple', 'Accent'), ('visor', 'Visor'), ('core', 'Core')],
    'responsory': [('primary', 'Primary'), ('visor', 'Visor'), ('accent', 'Accent'), ('highlight', 'Highlight'), ('core', 'Core')],
    'safeguard': [('base', 'Primary'), ('packlight', 'Backpack light'), ('stripe', 'Trim'), ('arrow', 'Helmet arrow'), ('core', 'Core')],
    'standard': [('suit', 'Primary'), ('lights', 'Lights'), ('visor', 'Visor'), ('trim', 'Trim'), ('core', 'Core')],
    'syndicate': [('base', 'Primary'), ('under', 'Undersuit'), ('lights', 'Lights'), ('red', 'Accent'), ('visor', 'Visor'), ('core', 'Core')],
    'debug': [('base', 'Primary'), ('blue', 'Accent'), ('glow', 'Lights'), ('glowhl', 'Lights highlight'), ('trim', 'Trim'), ('core', 'Core')],
    'praetorian': [('base', 'Primary'), ('blue', 'Accent'), ('lights', 'Lights'), ('visor', 'Visor'), ('visorhl', 'Visor highlight'), ('core', 'Core')],
}

# Channel color fitting: share of pixels that sit at or under the fitted color (default 0.97).
# Lower leaves headroom for bright repaints on mostly-white suits.
ANCHOR = {"standard": {"suit": 0.85}, "civilian": {"suit": 0.85, "plate": 0.85}}

# On helmet states these light channels become the visor
HELMET_FOLD = {"atmospheric": ("lights", "teal")}  # default ("lights",) for any skin with a "lights" rule
NO_FOLD = {"standard", "medical", "civilian", "corpsman"}  # these split the helmet themselves, or have no visor lights

# Lightness splits of glass and light channels, for ramps that drift in hue.
# lo / hi: darker than lo goes to the shade channel, at or above hi to "<channel>hl".
SPLIT = {"loader": {"visor": (None, 0.6)}, "praetorian": {"visor": (None, 0.6)},
         "engineering": {"visor": (0.3, 0.6), "lights": (0.45, None)}}
SHADE_NAME = {"engineering": {"visor": "shade", "lights": "shade"}}  # one shared channel for the dark glass rims

# Near-white shine on a colored channel stays white (fixed) on these skins, instead of tinting on a repaint
FIXED_SHINE = {"ninja", "enchanted", "corpsman", "lustwish"}
LEAK = 28  # residual spread (max - min of RGB) that counts as a visible tint


def _grow(lab, img, src, test, iters):
    h, w = lab.shape
    for _ in range(iters):
        new = lab.copy()
        for y, x in zip(*np.where((img[..., 3] > 0) & (lab != src))):
            if not test(*hls(img[y, x])):
                continue
            for dy, dx in ((0, 1), (1, 0), (0, -1), (-1, 0)):
                yy, xx = y + dy, x + dx
                if 0 <= yy < h and 0 <= xx < w and lab[yy, xx] == src:
                    new[y, x] = src
                    break
        lab = new
    return lab


def _components(mask):
    """4-connected components in raster order, like scipy.ndimage.label"""
    comp = np.zeros(mask.shape, int)
    count = 0
    for y, x in zip(*np.where(mask)):
        if comp[y, x]:
            continue
        count += 1
        stack = [(y, x)]
        comp[y, x] = count
        while stack:
            cy, cx = stack.pop()
            for dy, dx in ((0, 1), (1, 0), (0, -1), (-1, 0)):
                ny, nx = cy + dy, cx + dx
                if 0 <= ny < mask.shape[0] and 0 <= nx < mask.shape[1] and mask[ny, nx] and not comp[ny, nx]:
                    comp[ny, nx] = count
                    stack.append((ny, nx))
    return comp, count


def glitch_post(state, img, lab):
    return _grow(lab, img, "bands", lambda h, l, s: 0.6 < h < 0.75 and s >= 0.1 and l >= 0.2, 3)


def medical_post(state, img, lab):
    if "-helmet" in state or state.endswith("helmet"):
        lab = lab.copy()
        lab[lab == "suit"] = "dome"
    return lab


def safeguard_post(state, img, lab):
    if "control" in state:
        lab = lab.copy()
        lab[lab == "arrow"] = "packlight"
    return lab


def standard_post(state, img, lab):
    if "helmet" in state:
        lab = lab.copy()
        lab[lab == "lights"] = "visor"
    return lab


def engineering_post(state, img, lab):
    if "helmet" not in state:
        lab = lab.copy()
        lab[lab == "visor"] = "lights"
    return lab


def voskhod_post(state, img, lab):
    if "helmet" in state:
        lab = lab.copy()
        lab[lab == "green"] = "visor"
    return lab


def lustwish_post(state, img, lab):
    """The bubble helmet: the biggest accent patch on the helmet is the visor. Highlights get their own channels."""
    if "helmet" in state:
        mask = lab == "accent"
        comp, count = _components(mask)
        if count:
            sizes = [int((comp == i).sum()) for i in range(1, count + 1)]
            biggest = 1 + int(np.argmax(sizes))
            if sizes[biggest - 1] >= 12:
                lab = lab.copy()
                lab[comp == biggest] = "visor"
    lab = lab.copy()
    for y, x in zip(*np.where(img[..., 3] > 0)):
        if lab[y, x] in ("accent", "visor") and hls(img[y, x])[1] >= 0.62:
            lab[y, x] = lab[y, x] + "hl"
    return lab


POSTS = {"glitch": glitch_post, "medical": medical_post, "safeguard": safeguard_post, "standard": standard_post,
         "engineering": engineering_post, "voskhod": voskhod_post, "lustwish": lustwish_post}


def _neighbour_major(lab, y, x):
    h, w = lab.shape
    votes = {}
    for dy in (-1, 0, 1):
        for dx in (-1, 0, 1):
            if dy == dx == 0:
                continue
            yy, xx = y + dy, x + dx
            if 0 <= yy < h and 0 <= xx < w and lab[yy, xx] not in ("", "fixed", "core"):
                votes[lab[yy, xx]] = votes.get(lab[yy, xx], 0) + 1
    return max(votes, key=votes.get) if votes else None


def general_post(name):
    """Per-skin post, then: lights on helmets become the visor, and near-white shine joins what it sits on"""
    inner = POSTS.get(name)
    fold = HELMET_FOLD.get(name, ("lights",))
    folds = name not in NO_FOLD and any(rule[0] == "lights" for rule in SKINS[name][1])

    def post(state, img, lab):
        if inner:
            lab = inner(state, img, lab)
        lab = lab.copy()
        if "helmet" in state and folds:
            for ch in fold:
                lab[lab == ch] = "visor"
        shine = np.zeros(lab.shape, bool)
        for y, x in zip(*np.where(img[..., 3] > 0)):
            _, l, s = hls(img[y, x])
            if l >= 0.85 and s < 0.35:
                shine[y, x] = True
        for y, x in zip(*np.where(shine)):
            if lab[y, x] in ("", "fixed", "core"):
                continue
            major = _neighbour_major(lab, y, x)
            if major and major != lab[y, x]:
                lab[y, x] = major
        return lab
    return post


def split_post(name, inner):
    spec = SPLIT[name]
    shade = SHADE_NAME.get(name, {})

    def post(state, img, lab):
        lab = inner(state, img, lab).copy()
        for y, x in zip(*np.where(img[..., 3] > 0)):
            ch = lab[y, x]
            if ch in spec:
                l = hls(img[y, x])[1]
                lo, hi = spec[ch]
                if lo is not None and l < lo:
                    lab[y, x] = shade.get(ch, ch + "sh")
                elif hi is not None and l >= hi:
                    lab[y, x] = ch + "hl"
        return lab
    return post


def fixed_shine_post(inner, first):
    def post(state, img, lab):
        lab = inner(state, img, lab).copy()
        for y, x in zip(*np.where(img[..., 3] > 0)):
            ch = lab[y, x]
            if ch in ("", "fixed") or ch not in first.defaults:
                continue
            _, l, s = hls(img[y, x])
            if l >= 0.8 and s < 0.2:
                _, residual, _ = best_g(img[y, x], first.defaults[ch])
                if residual.max() - residual.min() >= LEAK:
                    lab[y, x] = "fixed"
        return lab
    return post


class Skin:
    """One skin, split into channels. defaults holds the fitted (stock) channel colors."""

    def __init__(self, name, post):
        self.name = name
        files, self.rules = SKINS[name]
        self.post = post
        self.anchor = ANCHOR.get(name, {})
        self.sources = [f for f in files if states_for(f, name)]
        self._anim = {}
        # Colors are classified from the skin's normal states. The "-helmet-visor" overlays are only drawn by
        # visor modules, which tint them their own color, so colors found only there stay fixed.
        self.chan = {}
        for f in self.sources:
            for state in states_for(f, name):
                if state.endswith("-helmet-visor"):
                    continue
                for frame in dmi(f).frames(state):
                    for p in frame[frame[..., 3] > 0]:
                        color = tuple(int(v) for v in p[:3])
                        if color not in self.chan:
                            h, l, s = hls(color)
                            self.chan[color] = next((ch for ch, rule in self.rules if rule(h, l, s)), "fixed")
        pools = defaultdict(Counter)
        for f in self.sources:
            for state in states_for(f, name):
                if state.endswith("-helmet-visor"):
                    continue  # drawn by visor modules with their own color: kept as is
                for i, frame in enumerate(dmi(f).frames(state)):
                    lab = self.label(frame, state, f, i)
                    for y, x in zip(*np.where(frame[..., 3] > 0)):
                        if lab[y, x] != "fixed":
                            pools[lab[y, x]][tuple(frame[y, x, :3])] += 1
        self.pools = pools
        self.defaults = {ch: fit_color(list(p), [p[c] for c in p], self.anchor.get(ch, 0.97)) for ch, p in pools.items()}

    def classify(self, color):
        return self.chan.get(color, "fixed")

    def anim_mask(self, f, state, index):
        """Pixels that change between animation frames: the core"""
        key = (f, state)
        if key not in self._anim:
            frames = dmi(f).frames(state)
            desc = re.search(r'state = "%s"\n\tdirs = (\d+)' % re.escape(state), dmi_desc(f))
            dirs = int(desc.group(1))
            count = len(frames) // dirs
            masks = []
            for d in range(dirs):
                stack = np.stack([frames[k * dirs + d] for k in range(count)])
                masks.append((stack != stack[0:1]).any(axis=(0, 3)) if count > 1 else np.zeros(frames[0].shape[:2], bool))
            self._anim[key] = (masks, dirs)
        masks, dirs = self._anim[key]
        return masks[index % dirs]

    def label(self, img, state, f, index):
        lab = np.full(img.shape[:2], "", object)
        for y, x in zip(*np.where(img[..., 3] > 0)):
            lab[y, x] = self.classify(tuple(int(v) for v in img[y, x, :3]))
        lab = self.post(state, img, lab)
        mask = self.anim_mask(f, state, index)
        if mask.any():
            lab = lab.copy()
            lab[mask & (img[..., 3] > 0)] = "core"
        return lab

    def split(self, img, state, f, index):
        """-> labels, {channel: greyscale layer, 'fixed': untouched pixels}, add layer, subtract layer"""
        lab = self.label(img, state, f, index)
        h, w = img.shape[:2]
        layers = {ch: np.zeros((h, w, 4), np.int32) for ch in self.defaults}
        layers["fixed"] = np.zeros((h, w, 4), np.int32)
        add = np.zeros((h, w, 4), np.int32)
        sub = np.zeros((h, w, 4), np.int32)
        add[..., 3] = 255  # full alpha: add/subtract layers multiply alpha into the result
        sub[..., 3] = 255
        for y, x in zip(*np.where(img[..., 3] > 0)):
            ch = lab[y, x]
            p = img[y, x]
            if ch in ("fixed", "") or ch not in self.defaults:
                layers["fixed"][y, x] = p
                continue
            g, residual, _ = best_g(p, self.defaults[ch])
            layers[ch][y, x] = (g, g, g, p[3])
            add[y, x, :3] = np.maximum(residual, 0)
            sub[y, x, :3] = np.maximum(-residual, 0)
        return lab, layers, add, sub


_desc = {}


def dmi_desc(f):
    if f not in _desc:
        _desc[f] = Image.open(REPO + f).info["Description"]
    return _desc[f]


def make(name):
    post = general_post(name)
    if name in SPLIT:
        post = split_post(name, post)
    skin = Skin(name, post)
    if name in FIXED_SHINE:
        skin = Skin(name, fixed_shine_post(post, skin))
    return skin
