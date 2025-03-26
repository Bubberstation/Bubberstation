https://github.com/Bubberstation/Bubberstation/pull/2122

Original PR:
https://github.com/NovaSector/NovaSector/pull/121

## \<Title Round Removal Opt In>

Module ID: RR_OPTIN

### Description:

Adds functionality to allow players to 'opt-in' to being round removed.

### TG Proc/File Changes:

- death.dm (death logging)

### Modular Overrides:

- N/A

### Config:

- /datum/config_entry/flag/rr_opt_level_default - TRUE or FALSE, defines default opt in for all
- /datum/config_entry/flag/use_rr_opt_in_preferences - TRUE or FALSE, defines whether RR prefs are used

### Included files that are not contained in this module:

- tgui\packages\tgui\interfaces\PreferencesMenu\preferences\features\character_preferences\bubber\round_remove.tsx

### Credits:

- Swiftfeather - Retooling for Bubberstation and Round Removal.
- niko - for doing stuff and taking over
- plum - the original author
