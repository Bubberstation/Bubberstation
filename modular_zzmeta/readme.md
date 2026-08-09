# modular_zzmeta

This is Metastruct's own modular layer, kept separate from `modular_zubbers/` (Bubberstation's own modular content) and `modular_skyrat/` (legacy, inherited from the Skyrat split).

The general modularization protocol is unchanged — see [`modular_zubbers/readme.md`](../modular_zubbers/readme.md) for the full guide (file placement, maps, TGUI, etc.). The short version:

- Mirror the original file's path under `modular_zzmeta/` (e.g. `code/game/foo.dm` → `modular_zzmeta/code/game/foo.dm`).
- Override procs with `. = ..()` rather than copy-pasting the whole proc.
- New files must be manually added to `tgstation.dme`.
- For unavoidable inline edits to non-modular code, use `// META EDIT - ADDITION/CHANGE/REMOVAL - START/END - FEATURE_NAME` instead of `// BUBBER EDIT`

## Things to add here later, once needed (not done yet, no files exist to need them)

- `tools/ci/check_grep.sh` already includes `modular_zzmeta/**/**.dm` in its lint globs, and `modular_zzmeta/tools/ci/zzmeta_check_grep.sh` re-runs those checks scoped to this folder.
- If we ever add new global `__DEFINES`, register the glob in `tools/define_sanity/check.py`.
- If we ever add greyscale/icon-cutter `.toml` configs, register the glob in `tools/icon_cutter/check.py`.
- If we ever add runtime-loaded assets (icons, json configs not compiled into the `.dmb`), add a copy step to the deploy scripts (`tools/deploy.sh` / `tools/ci/copy_build_output.sh`) and give it its own hook rather than editing `modular_zubbers/tools/deploy_bubber.sh`, which is Bubberstation's.
- A `.github/CODEOWNERS` entry for `/modular_zzmeta/**` once we know who should be auto-requested for review.
