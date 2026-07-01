
//////////////////////////////////////////////
//                                          //
//        ROUNDSTART BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////



/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	config_tag = "Roundstart Bloodsucker"
	pref_flag = ROLE_BLOODSUCKER
	preview_antag_datum = /datum/antagonist/bloodsucker
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	max_antag_cap = list("denominator" = 24)
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/roundstart/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	return ..()

/datum/dynamic_ruleset/roundstart/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))


//////////////////////////////////////////////
//                                          //
//           ROUNDSTART DEVIL               //
//                                          //
//////////////////////////////////////////////



/datum/dynamic_ruleset/roundstart/devil
	name = "Devils"
	config_tag = "Roundstart Devil"
	pref_flag = ROLE_DEVIL
	preview_antag_datum = /datum/antagonist/devil
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES // I'm just going to re-use this.
	weight = 7 // Reduce to 5 before merge.
	max_antag_cap = list("denominator" = 24)
