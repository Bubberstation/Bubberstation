https://github.com/Skyrat-SS13/Skyrat-tg/pull/16787

## Title:
Engineering override for airlocks on orange alert
MODULE ID: AIRLOCK_OVERRIDE

### Description:
Adds functionality to the airlocks so that when the alert level is set to orange, engineers receive expanded access so they aren't stuck at an airlock when disaster happens.

### TG Proc/File Changes:
code/game/machinery/computer/communications.dm
code/modules/security_levels/keycard_authentication.dm
tgui/packages/tgui/interfaces/CommunicationsConsole.js
tgui/packages/tgui/interfaces/KeycardAuth.js

### Defines:
AIRLOCK_LIGHT_ENGINEERING in \Skyrat-tg\modular_skyrat\modules\aesthetics\airlock\code\airlock.dm
AIRLOCK_ENGINEERING_LIGHT_COLOR in \Skyrat-tg\modular_skyrat\modules\aesthetics\airlock\code\airlock.dm

### Credits:
LT3
