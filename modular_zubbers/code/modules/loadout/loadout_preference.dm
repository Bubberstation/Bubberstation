// Oh, I'm sorry, you were looking for GOOD code? Turn around and leave. - Rimi

/datum/preference/loadout_index
	savefile_key = "loadout_index"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/loadout_index/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/loadout_index/create_informed_default_value(datum/preferences/preferences)
	var/list/loadouts = preferences.read_preference(/datum/preference/loadout)
	if(length(loadouts))
		return loadouts[1]

/datum/preference/loadout_index/deserialize(input, datum/preferences/preferences)
	if (istext(input))
		return input

	return create_informed_default_value(preferences)

/datum/preference/loadout_index/is_valid(value)
	return istext(value)

/datum/preference/loadout
	savefile_key = "loadout_lists" // Change the savefile key to avoid data corruption if this goes COMPLETELY WRONG during a test merge.

// I'm going to flex my cursed modular knowledge now.
/datum/preference/loadout/deserialize(list/input, datum/preferences/preferences)
	for (var/name in input)
		input[name] = ..(input[name], preferences) // ULTIMATE MODULARITY BULLSHIT GO

	return input

/datum/preference/loadout/create_default_value(datum/preferences/preferences)
	return list("Default" = list())

/datum/preference/loadout/compile_ui_data(mob/user, value)
	var/list/data = ..()
	var/list/loadout_list = list()
	for(var/key in data)
		loadout_list += key
	data = list("loadout" = data[user?.client?.prefs.read_preference(/datum/preference/loadout_index)] || "Default") // Fail nicely and hopefully avoid runtiming, though this is client bullshit we're on about
	data["loadouts"] = loadout_list
	return data
