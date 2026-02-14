//Frankly, this is more red than not. Probably incompatible, maybe just needs some vars to be renamed.
//For now I am just commenting it all out, since we don't run dynamic anyway

//////////////////////////////////////////////
//                                          //
//                 FAMILIES                 //
//                                          //
//////////////////////////////////////////////

/*
/datum/dynamic_ruleset/midround/families
	name = "Family Head Aspirants"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	persistent = TRUE
	antag_datum = /datum/antagonist/gang
	antag_flag = ROLE_FAMILY_HEAD_ASPIRANT
	antag_flag_override = ROLE_FAMILIES
	protected_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_PRISONER,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	required_candidates = 3
	weight = 2
	cost = 19
	requirements = list(101,101,40,40,30,20,10,10,10,10)
	flags = HIGH_IMPACT_RULESET
	blocking_rules = list(/datum/dynamic_ruleset/roundstart/families)
	/// A reference to the handler that is used to run pre_execute(), execute(), etc..
	var/datum/gang_handler/handler

/datum/dynamic_ruleset/midround/families/trim_candidates()
	..()
	candidates = living_players
	for(var/mob/living/player in candidates)
		if(issilicon(player))
			candidates -= player
		else if(is_centcom_level(player.z))
			candidates -= player
		else if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			candidates -= player
		else if(HAS_TRAIT(player, TRAIT_MINDSHIELD))
			candidates -= player
		else if(player.mind.assigned_role.title in restricted_roles)
			candidates -= player


/datum/dynamic_ruleset/midround/families/ready(forced = FALSE)
	if (required_candidates > living_players.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/families/pre_execute()
	..()
	handler = new /datum/gang_handler(candidates,restricted_roles)
	handler.gang_balance_cap = clamp((indice_pop - 3), 2, 5) // gang_balance_cap by indice_pop: (2,2,2,2,2,3,4,5,5,5)
	handler.midround_ruleset = TRUE
	handler.use_dynamic_timing = TRUE
	return handler.pre_setup_analogue()

/datum/dynamic_ruleset/midround/families/execute()
	return handler.post_setup_analogue(TRUE)

/datum/dynamic_ruleset/midround/families/clean_up()
	QDEL_NULL(handler)
	..()

/datum/dynamic_ruleset/midround/families/rule_process()
	return handler.process_analogue()

/datum/dynamic_ruleset/midround/families/round_result()
	return handler.set_round_result_analogue()
*/
