/datum/dynamic_ruleset/midround/from_living/opfor_candidate
	name = "OPFOR Candidate Reroll"
	config_tag = "OPFOR"
	preview_antag_datum = /datum/antagonist/opfor_candidate
	midround_type = LIGHT_MIDROUND
	pref_flag = ROLE_OPFOR_CANDIDATE
	jobban_flag = BAN_OPFOR
	weight = 0
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_living/opfor_candidate/is_valid_candidate(mob/candidate, client/candidate_client)
	if(candidate_client.ckey in GLOB.opfor_passed_ckeys)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/opfor_candidate/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/opfor_candidate)
	message_admins("[ADMIN_LOOKUPFLW(candidate.current)] had OPFOR candidacy passed onto them.")
	log_dynamic("[key_name(candidate.current)] had OPFOR candidacy passed onto them.")
