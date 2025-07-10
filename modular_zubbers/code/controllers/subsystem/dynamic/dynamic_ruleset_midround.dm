
//////////////////////////////////////////////
//                                          //
//          MIDROUND BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_living/bloodsucker
	name = "Vampiric Accident"
	config_tag = "Midround Bloodsucker"
	midround_type = HEAVY_MIDROUND
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_VAMPIRICACCIDENT
	jobban_flag = ROLE_BLOODSUCKER
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/midround/from_living/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_bloodsucker_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))


/datum/dynamic_ruleset/midround/from_living/traitor
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_ghosts/blob
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_living/blob
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_ghosts/xenomorph
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_ghosts/nightmare
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_ghosts/abductors
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_ghosts/space_ninja
	min_pop = 20
	repeatable = FALSE

/datum/dynamic_ruleset/midround/spiders
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_ghosts/revenant
	repeatable = FALSE

/datum/dynamic_ruleset/midround/pirates
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_living/obsesed
	repeatable = FALSE
