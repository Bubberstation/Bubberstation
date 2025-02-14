
// Remove any invalid quirks by the species whitelist
/datum/preference_middleware/species/post_set_preference(mob/user, preference, value)
	. = ..()
	var/species_id = value // one of the options that this can be is species_id, but it can be other things as well annoyingly
	if(preference != "species" || !length(GLOB.quirk_species_whitelist) || !species_id)
		return .
	var/needs_update = FALSE
	for(var/quirk_name as anything in preferences.all_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		var/list/species_whitelist = GLOB.quirk_species_whitelist[quirk_type]
		if(!length(species_whitelist) || (species_id in species_whitelist))
			continue
		preferences.all_quirks -= quirk_name
		needs_update = TRUE
	if(needs_update)
		preferences.update_static_data(user)
	return .
