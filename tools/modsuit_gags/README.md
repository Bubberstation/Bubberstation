# MODsuit GAGS tool

This tool makes the paintable versions of the MODsuit sprites. It reads the original sprite files and writes:

- `modular_zubbers/icons/mob/clothing/modsuit/gags/<skin>.dmi` (the greyscale layers)
- `modular_zubbers/code/datums/greyscale/json_configs/modsuit/<skin>_<role>.json` (the GAGS configs)
- `modular_zubbers/code/modules/mod/gags/mod_gags_skins.dm` (the config datums and the skin registry)

Do not edit those files by hand. Edit the original sprites or the rules here, then rebuild.

## How it works

1. Each pixel of a skin goes into a color channel (Primary, Visor, Lights and so on), from its color. The rules for each skin are in `rules.py`.
2. A channel color is fitted from all of its pixels. Each pixel is then stored as a greyscale value, which GAGS multiplies by the channel color.
3. Pixel art often shifts hue across its shading, so greyscale times one color does not always give the exact pixel back. The difference goes into two fixed layers, `.add` and `.sub`, which GAGS adds and subtracts after the colors. They look like black squares in a DMI editor: they hold small numbers, and they must be fully opaque.
4. At the stock colors, the layers rebuild the original sprite exactly. `check.py` proves this for every state, direction and frame.

## Rebuilding

Use the repository's Python (it already has Pillow and numpy):

```
tools/bootstrap/python tools/modsuit_gags/build.py
tools/bootstrap/python tools/modsuit_gags/check.py
```

`build.py` with skin names (for example `build.py loader ninja`) rebuilds only those skins. `check.py` must end with `TOTAL 0 of ... pixels differ`. A different Pillow version can change the bytes of the .dmi files without changing a pixel. `check.py` is what matters.

## Common changes

- **A sprite changed.** Rebuild that skin, then run `check.py`.
- **A new skin.** Add its rules to `SKINS` and its channels to `LAYOUT` in `rules.py`. Rebuild, run `check.py`, and look at the result in game with a few bright colors. Stray pixels in the wrong channel show up fast that way.
- **A repaint looks tinted** (for example olive flecks on a grey paint job). The shading of that channel drifts in hue. Split the channel with `SPLIT` in `rules.py` (a lightness cut into shade or highlight channels), or give the drifting colors their own rule.
- **Channel names or menu order.** Edit `LAYOUT`. The order there is the order in the paint menu.
- **A skin that spawns in non-stock colors.** Add it to `DEFAULT_LOOKS` in `build.py`, as the color the channel should look like. The build converts it to the GAGS input color.

`manifest.json` stores the result of the last build of each skin, so a partial rebuild can still write the full registry. Commit it with the other generated files.
