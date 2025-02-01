## Title: Magazine Fed Turrets

MODULE ID: MAGFED TURRETS

### Description:

Magazine fed turrets for temporary threats in space ruins for either ruin tiding or ghostroles, along with Target Designators made for controlling said turrets..

Contains Code and Sprites.

If changes are needed involving defines and flags, Please make said changes within the framework file.

cargo.dm is for models that are available through cargo. Currently, This is just a gags-ible toy turret that shoots foam darts.

ruins.dm is for models that are available within space, lavaland, icemoon, etc, or ghost role ruins.

if additional files are needed for, say, research or fully crafting reliant (or other methods), it is advised to follow similar formats.

Notable Changes/abilities:

- Bullet specific effects (Dragonsbreath, Pellet clouds, Recyclability(foam darts :p))
- Burst-fire with modular burst-rate and volley count (Optional)
- Tool-less deployment and retraction (Optional)
- Deployment through throwing (Cant be cooked like a grenade, but will deploy shortly after turf impact) (Optional)
- Can be toggled between shooting no human-like being, shooting indescriminantly at anything not in its factions, or shooting according to normal turret targeting flags.
- Can be refilled by attacking with magazines
- Can be made fragile, causing the turret to break into an assembly rather than dropping its toolbox on non-dissassembly destruction.
- Can be linked to and forced to target an object through a target designator (Currently Prototyping)

### TG Proc Changes:

- None, However over-writes most turret procs for magazine fed turrets.

### Defines:

- Several temporary defines. See first section of turret_framework.dm

### Master file additions

- N\A

### Included files that are not contained in this module:

- modular_nova\module\GAGS\json_configs\turret.json
- modular_nova\module\GAGS\json_configs\turret_toolbox.json
- modular_nova\module\tarkon\code\misc_fluff\turret.dm
- modular_nova\nodule\tarkon\icons\obj\turret.dmi
- modular_nova\nodule\tarkon\icons\mob\clothing\belt.dmi // PARTIAL
- modular_nova\nodule\tarkon\icons\mob\inhands\lefthand.dmi // PARTIAL
- modular_nova\nodule\tarkon\icons\mob\inhands\righthand.dmi // PARTIAL

### Credits:

ZenithEevee - Main author
CliffracerX - GAGS work
VinylSpider - Code Assistance
Paxil - i nabbed a bit of your artstyle and colour for some of the sprites
