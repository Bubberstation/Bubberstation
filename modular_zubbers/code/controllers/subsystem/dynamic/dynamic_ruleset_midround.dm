
//////////////////////////////////////////////
//                                          //
//          MIDROUND VAMPIRE                //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_living/vampire
	name = "Vampiric Accident"
	config_tag = "Midround Vampire"
	midround_type = HEAVY_MIDROUND
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRIC_ACCIDENT
	jobban_flag = ROLE_VAMPIRE
	blacklisted_roles = VAMPIRE_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be vampires
	var/list/restricted_species = VAMPIRE_RESTRICTED_SPECIES

/datum/dynamic_ruleset/midround/from_living/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_vampire_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/vampire/assign_role(datum/mind/candidate)
	var/datum/antagonist/vampire/vampire_datum = candidate.add_antag_datum(/datum/antagonist/vampire)
	var/extra_levels = rand(2, 3)
	vampire_datum.vampire_level_unspent += extra_levels
	vampire_datum.free_levels_remaining = max(vampire_datum.free_levels_remaining - extra_levels, 0)

/// Check if this is a valid person to actually be a vampire
/datum/mind/proc/valid_vampire_candidate()
	if(has_antag_datum(/datum/antagonist/vampire))
		return FALSE
	if(!(current.mob_biotypes & MOB_ORGANIC))
		return FALSE
	// While the antag can function without the mob itself having no blood, it doesn't make sense.
	if(HAS_TRAIT(current, TRAIT_NOBLOOD))
		return FALSE
	return TRUE

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
