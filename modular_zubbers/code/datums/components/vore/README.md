# Modular DCS Vore
This is an implementation of vore made entirely using components.

By [Shadow Larkens](https://github.com/ShadowLarkens/)

## Configuration
Most critical options are in [_defines.dm](./_defines.dm) including things such as the max amount of bellies that can
be created, how many prey can be eaten, etc.

## Debugging
If you need to debug this system, go to the top of [_defines.dm](./_defines.dm) and uncomment `#define VORE_TESTING`
to enable helpful debugging features such as not needing clients and working on all living mobs.

## Code Overview
[_defines.dm](./_defines.dm) - Settings and constants.
[absorb_control.dm](./absorb_control.dm) - Component used for prey controlling preds temporarily
[belly.dm](./belly.dm) - Individual areas that have their own name, description and digestion mode.
[belly_messages.dm](./belly_messages.dm) - Contains helpers for all of the many different customizable messages a belly can produce.
[belly_serde.dm](./belly_serd.dm) - Controls belly serialization and deserialization.
[digest_modes.dm](./digest_modes.dm) - Singletons that handle affecting a belly's contents on each process.
[preferences.dm](./preferences.dm) - Vore related preferences
[subsystem.dm](./subsystem.dm) - Belly processing subsystem / global event listener
[ui.dm](./ui.dm) - tgui interface for managing the component
[vore.dm](./vore.dm) - The main component that orchestrates everything else.
[z_undefs.dm](./z_undefs.dm) - undefs to keep defines from escaping.

## Special Notes
- Being absorbed is marked by TRAIT_RESTRAINED and TRAIT_STASIS with a source of TRAIT_SOURCE_VORE.
