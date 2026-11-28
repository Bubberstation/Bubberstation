
//////////////////////////////////////////////
//                                          //
//          LATEJOIN VAMPIRE                //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/vampire
	name = "Vampire Breakout"
	config_tag = "Latejoin Vampire"
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRE_BREAKOUT
	jobban_flag = ROLE_VAMPIRE
	blacklisted_roles = VAMPIRE_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be vampires
	var/list/restricted_species = VAMPIRE_RESTRICTED_SPECIES

/datum/dynamic_ruleset/latejoin/vampire/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_vampire_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/vampire/assign_role(datum/mind/candidate)
	var/datum/antagonist/vampire/vampire_datum = candidate.add_antag_datum(/datum/antagonist/vampire)
	var/extra_levels = rand(2, 3)
	vampire_datum.vampire_level_unspent += extra_levels
	vampire_datum.free_levels_remaining = max(vampire_datum.free_levels_remaining - extra_levels, 0)
