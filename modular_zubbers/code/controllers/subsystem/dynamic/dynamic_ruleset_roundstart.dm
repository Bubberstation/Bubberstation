
//////////////////////////////////////////////
//                                          //
//        ROUNDSTART VAMPIRE                //
//                                          //
//////////////////////////////////////////////



/datum/dynamic_ruleset/roundstart/vampire
	name = "Vampires"
	config_tag = "Roundstart Vampire"
	pref_flag = ROLE_VAMPIRE
	preview_antag_datum = /datum/antagonist/vampire
	blacklisted_roles = VAMPIRE_BLACKLISTED_ROLES
	weight = 5
	max_antag_cap = list("denominator" = 24)
	/// List of species that cannot be vampires
	var/list/restricted_species = VAMPIRE_RESTRICTED_SPECIES

/datum/dynamic_ruleset/roundstart/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	return ..()

/datum/dynamic_ruleset/roundstart/vampire/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/vampire)
