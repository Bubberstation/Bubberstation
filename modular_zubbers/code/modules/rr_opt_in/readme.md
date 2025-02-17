https://github.com/Bubberstation/Bubberstation/pull/2122

Original PR:
https://github.com/NovaSector/NovaSector/pull/121

## \<Title Round Removal Opt In>

Module ID: RR_OPTIN

### Description:

Adds functionality to allow players to 'opt-in' to being round removed. 

### TG Proc/File Changes:

- examine_tgui.dm (Adds opt in info to OOC examine info)
- death.dm (death logging) 

### Modular Overrides:

- N/A

### Config:

- /datum/config_entry/flag/RR_OPT_LEVEL_ANTAG   - TRUE OR FALSE, defines default antag opt in level
- /datum/config_entry/flag/RR_OPT_LEVEL_DEFAULT - TRUE or FALSE, defines default opt in for all

### Included files that are not contained in this module:

- tgui\packages\tgui\interfaces\PreferencesMenu\preferences\features\character_preferences\skyrat\antag_optin.tsx

### Credits:

- Swiftfeather - Retooling for Bubberstation and Round Removal.
- niko - for doing stuff and taking over
- plum - the original author
