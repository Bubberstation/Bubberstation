# Modular DCS Vore
This is an implementation of vore made entirely using components.

## Configuration
Most critical options are in [_defines.dm](./_defines.dm) including things such as the max amount of bellies that can
be created, how many prey can be eaten, etc.

## Code Overview
[_defines.dm](./_defines.dm) - Settings and constants.
[belly.dm](./belly.dm) - Individual areas that have their own name, description and digestion mode.
[digest_modes.dm](./digest_modes.dm) - Singletons that handle affecting a belly's contents on each process.
[preferences.dm](./preferences.dm) - Vore related preferences
[subsystem.dm](./subsystem.dm) - Belly processing subsystem / global event listener
[ui.dm](./ui.dm) - tgui interface for managing the component
[vore.dm](./vore.dm) - The main component that orchestrates everything else.
[z_undefs.dm](./z_undefs.dm) - undefs to keep defines from escaping.
