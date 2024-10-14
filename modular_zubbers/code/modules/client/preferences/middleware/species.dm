
// Remove any invalid quirks by the species whitelist
/datum/preference_middleware/species/post_set_preference(mob/user, preference, value)
	. = ..()
	var/species_id = value // one of the options that this can be is species_id, but it can be other things as well annoyingly
	var/datum/preference/choiced/species/species_pref // we don't care about non-species set actions, middleware are called on any pref set
	var/preference_key = initial(species_pref.savefile_key)
	if(preference != preference_key || !length(GLOB.quirk_species_whitelist) || !species_id)
		return .
	for(var/quirk_name as anything in preferences.all_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		var/list/species_whitelist = GLOB.quirk_species_whitelist[quirk_type]
		if(!length(species_whitelist) || (species_id in species_whitelist))
			continue
		preferences.all_quirks -= quirk_name
	return .
