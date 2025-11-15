//////////////////////////////////////////////
//                                          //
//                 FAMILIES                 //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/families
	name = "Families"
	persistent = TRUE
	antag_datum = /datum/antagonist/gang
	antag_flag = ROLE_FAMILIES
	protected_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_PRISONER,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CAPTAIN,
		JOB_CYBORG,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	required_candidates = 3
	weight = 1
	cost = 19
	requirements = list(101,101,40,40,30,20,10,10,10,10)
	flags = HIGH_IMPACT_RULESET
	/// A reference to the handler that is used to run pre_execute(), execute(), etc..
	var/datum/gang_handler/handler

/datum/dynamic_ruleset/roundstart/families/pre_execute(population)
	..()
	handler = new /datum/gang_handler(candidates,restricted_roles)
	handler.gang_balance_cap = clamp((indice_pop - 3), 2, 5) // gang_balance_cap by indice_pop: (2,2,2,2,2,3,4,5,5,5)
	handler.use_dynamic_timing = TRUE
	return handler.pre_setup_analogue()

/datum/dynamic_ruleset/roundstart/families/execute()
	return handler.post_setup_analogue(TRUE)

/datum/dynamic_ruleset/roundstart/families/clean_up()
	QDEL_NULL(handler)
	..()

/datum/dynamic_ruleset/roundstart/families/rule_process()
	return handler.process_analogue()

/datum/dynamic_ruleset/roundstart/families/round_result()
	return handler.set_round_result_analogue()
