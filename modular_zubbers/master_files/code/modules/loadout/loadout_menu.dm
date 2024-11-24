/datum/preference_middleware/loadout/New(datum/preferences)
	. = ..()
	action_delegations += list(
		"add_loadout_preset" = PROC_REF(add_loadout_preset),
		"remove_loadout_preset" = PROC_REF(remove_loadout_preset),
		"set_loadout_preset" = PROC_REF(set_loadout_preset),
	)

/datum/preference_middleware/loadout/proc/add_loadout_preset(list/params, mob/user)
	PRIVATE_PROC(TRUE)
	var/list/loadout_entries = preferences.read_preference(/datum/preference/loadout)

	if (loadout_entries.len >= LOADOUT_MAX_PRESETS)
		return TRUE

	var/loadout_name = params["name"]
	if (!istext(loadout_name) || length(loadout_name) >= LOADOUT_MAX_NAME_LENGTH || length(loadout_name) < 1)
		return TRUE

	if (islist(loadout_entries[loadout_name]))
		return TRUE

	loadout_entries[loadout_name] = list()
	preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], loadout_entries)
	preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout_index], loadout_name)
	return TRUE

/datum/preference_middleware/loadout/proc/remove_loadout_preset(list/params, mob/user)
	PRIVATE_PROC(TRUE)

	var/loadout_name = params["name"]
	if(!istext(loadout_name) || loadout_name == "Default")
		return TRUE

	var/list/loadout_entries = preferences.read_preference(/datum/preference/loadout)

	if (loadout_entries.len <= 1)
		return TRUE

	loadout_entries.Remove(loadout_name)
	preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], loadout_entries)
	preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout_index], "Default")
	return TRUE

/datum/preference_middleware/loadout/proc/set_loadout_preset(list/params, mob/user)
	PRIVATE_PROC(TRUE)

	var/loadout_name = params["name"]
	if(!istext(loadout_name))
		return TRUE

	var/list/loadout_entries = preferences.read_preference(/datum/preference/loadout)

	if (loadout_name in loadout_entries)
		preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout_index], loadout_name)

	return TRUE

/datum/preference_middleware/loadout/proc/get_current_loadout()
	var/list/loadout_entries = preferences.read_preference(/datum/preference/loadout)
	return loadout_entries[preferences.read_preference(/datum/preference/loadout_index)]

/datum/preference_middleware/loadout/proc/save_current_loadout(list/loadout)
	var/list/loadout_entries = preferences.read_preference(/datum/preference/loadout)
	loadout_entries[preferences.read_preference(/datum/preference/loadout_index)] = loadout
	preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], loadout_entries)
