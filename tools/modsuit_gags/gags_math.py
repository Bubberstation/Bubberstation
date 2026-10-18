"""
DMI reading and the GAGS layer math, copied from what rust-g iconforge does at runtime.

  multiply:      floor(a * b / 255)
  add, subtract: saturating, per channel
  alpha for add, subtract and colored layers: floor(a_dst * (a_src / 255) + 0.5)
  overlay:       onto an alpha 0 base pixel it takes the new pixel, otherwise
                 c_src + (c_dst - c_src) * a_dst / 255, truncated toward zero

If this math drifts from the engine, the generated layers stop rebuilding the
original sprites exactly. check.py replays it to catch that.
"""
import colorsys
import os
import re

import numpy as np
from PIL import Image

# Repository root, so every path in the tool can be written the way the .dme writes it
REPO = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..")) + os.sep


class DMI:
    """A .dmi file: frames are 32x32 RGBA int arrays, in the order the file stores them."""

    def __init__(self, path, root=REPO):
        self.path = path
        raw = Image.open(root + path)
        desc = raw.info["Description"]
        self.image = np.array(raw.convert("RGBA")).astype(np.int32)
        self.w = int(re.search(r"width = (\d+)", desc).group(1))
        self.h = int(re.search(r"height = (\d+)", desc).group(1))
        self.cols = self.image.shape[1] // self.w
        self.fr = {}
        index = 0
        for block in desc.split("state = ")[1:]:
            state = re.match(r'"([^"]*)"', block).group(1)
            dirs = int(re.search(r"dirs = (\d+)", block).group(1))
            frames = re.search(r"frames = (\d+)", block)
            count = dirs * (int(frames.group(1)) if frames else 1)
            self.fr[state] = (index, count)
            index += count

    def frames(self, state):
        start, count = self.fr[state]
        out = []
        for i in range(start, start + count):
            y, x = divmod(i, self.cols)
            out.append(self.image[y * self.h:(y + 1) * self.h, x * self.w:(x + 1) * self.w])
        return out


def meta_blocks(path, root=REPO):
    """state name -> its metadata lines (dirs, frames, delay, ...), exactly as the file has them"""
    desc = Image.open(root + path).info["Description"]
    out = {}
    for block in desc.split("state = ")[1:]:
        name = re.match(r'"([^"]*)"', block).group(1)
        body = block.split("\n", 1)[1]
        out[name] = "\n".join(line for line in body.split("\n") if line.startswith("\t"))
    return out


def hls(p):
    return colorsys.rgb_to_hls(*(np.asarray(p[:3]) / 255))


def mulf(g, c):
    return (np.asarray(g) * np.asarray(c)) // 255


def fit_color(colors, weights, pct=0.97):
    """The channel color: the main direction of the palette, scaled so pct of the pixels sit at or under it."""
    a = np.asarray(colors, float)
    w = np.asarray(weights, float)[:, None]
    _, _, vt = np.linalg.svd(a * np.sqrt(w), full_matrices=False)
    v = np.abs(vt[0])
    proj = a @ v
    order = np.argsort(proj)
    cw = np.cumsum(np.asarray(weights, float)[order])
    cw /= cw[-1]
    top = proj[order][min(len(order) - 1, np.searchsorted(cw, pct))]
    c = v * top
    if c.max() > 255:
        c *= 255 / c.max()
    return np.clip(np.round(c), 1, 255).astype(int)


GREYS = np.arange(256)


def best_g(pixel, color):
    """Greyscale value that gets this pixel closest from the channel color. Returns (grey, residual, cost)."""
    made = mulf(GREYS[:, None], np.asarray(color)[None, :])
    residual = np.asarray(pixel[:3])[None, :] - made
    cost = np.abs(residual).sum(1) * 4 + (residual.max(1) - residual.min(1)) * 3
    g = int(np.argmin(cost))
    return g, residual[g], cost[g]


def overlay(base, new):
    out = base.copy()
    a_s = base[..., 3]
    a_d = new[..., 3]
    take = a_s == 0
    delta = (new[..., :3] - base[..., :3]) * a_d[..., None]
    delta = np.where(delta < 0, -((-delta) // 255), delta // 255)  # Rust i32 division truncates toward zero
    out[..., :3] = np.where(take[..., None], new[..., :3], np.clip(base[..., :3] + delta, 0, 255))
    out[..., 3] = np.clip(np.round((a_s / 255 + a_d / 255 * (1 - a_s / 255)) * 255), 0, 255).astype(np.int32)
    return out


def alpha_lu(a_src, a_dst):
    return np.floor(a_dst.astype(np.float32) * (a_src.astype(np.float32) / np.float32(255.0)) + np.float32(0.5)).astype(np.int32)


def apply_color(layer, color):
    layer = layer.copy()
    layer[..., :3] = mulf(layer[..., :3], np.asarray(color))
    layer[..., 3] = alpha_lu(layer[..., 3], np.full_like(layer[..., 3], 255))
    return layer


def blend(base, layer, mode):
    if mode == "overlay":
        return overlay(base, layer)
    out = base.copy()
    if mode == "add":
        out[..., :3] = np.minimum(255, base[..., :3] + layer[..., :3])
    else:
        out[..., :3] = np.maximum(0, base[..., :3] - layer[..., :3])
    out[..., 3] = alpha_lu(base[..., 3], layer[..., 3])
    return out
