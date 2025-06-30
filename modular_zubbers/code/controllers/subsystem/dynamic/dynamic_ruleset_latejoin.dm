
//////////////////////////////////////////////
//                                          //
//          LATEJOIN BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	config_tag = "Latejoin Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_BLOODSUCKERBREAKOUT
	jobban_flag = ROLE_BLOODSUCKER
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/latejoin/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_bloodsucker_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))
