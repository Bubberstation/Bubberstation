/datum/dynamic_ruleset
	/// Species that won't be considered as a valid target for the rule.
	var/restricted_species = list()

/datum/dynamic_ruleset/proc/trim_restricted_species()
	for(var/mob/candidate_player in candidates)
		var/client/candidate_client = GET_CLIENT(candidate_player)
		var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
		if(selected_species in restricted_species)
			candidates.Remove(candidate_player)

/datum/dynamic_ruleset/roundstart/trim_candidates()
	. = ..()
	trim_restricted_species()

/datum/dynamic_ruleset/midround/trim_candidates()
	. = ..()
	trim_restricted_species()

/datum/dynamic_ruleset/latejoin/trim_candidates()
	. = ..()
	trim_restricted_species()
