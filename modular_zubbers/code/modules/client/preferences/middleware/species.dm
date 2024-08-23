
// /datum/preference/choiced/species/update_preference(datum/preference/preference, preference_value)
// 	// check that the current preference does not have invalid quirks
// 	var/quirks = all_quirks
// Remove any invalid quirks by the species whitelist
/datum/preference_middleware/species/post_set_preference(mob/user, preference, value)
	. = ..()
	var/species_id = value
	if(!length(GLOB.quirk_species_whitelist) || !species_id)
		return
	for(var/quirk_name as anything in preferences.all_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		var/list/species_whitelist = GLOB.quirk_species_whitelist[quirk_type]
		if(!length(species_whitelist) || (species_id in species_whitelist))
			continue
		preferences.all_quirks -= quirk_name
