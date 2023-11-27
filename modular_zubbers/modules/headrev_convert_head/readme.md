https://github.com/Bubberstation/Bubberstation/pull/763

## \Head Convert Device for HeadRevs

Module ID: HEADREV_CONVERT_HEAD

### Description:

This module adds an ability for headrevs to convert heads to progress the round instead of round-removing them.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- `modular_zubbers\master_files\code\modules\antagonists\revolution\revolution.dm`: `proc/equip_rev`
- `modular_zubbers\master_files\code\game\gamemodes\objective.dm`: `proc/check_completion`

### Defines:

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

Larentoun
