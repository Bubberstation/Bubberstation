/datum/dynamic_ruleset/roundstart/gang
	name = "Families"
	config_tag = "Roundstart gang"
	preview_antag_datum = /datum/antagonist/gang
	pref_flag = ROLE_FAMILIES
	weight = 1
	min_pop = 10
	min_antag_cap = 2
	max_antag_cap = 3
	repeatable = FALSE
	solo = TRUE
	var/datum/gang_handler/handler

/datum/dynamic_ruleset/roundstart/gang/assign_role(datum/mind/candidate)
	. = ..()
	handler = new /datum/gang_handler(selected_minds, blacklisted_roles)
	handler.gang_balance_cap = clamp((get_active_player_count() - 3), 2, 5) // gang_balance_cap by indice_pop: (2,2,2,2,2,3,4,5,5,5)
	handler.use_dynamic_timing = TRUE
	return handler.pre_setup_analogue()

/datum/dynamic_ruleset/roundstart/gang/execute()
	return handler.post_setup_analogue(TRUE)

/*
//Removing this will surely be fine! DEBUG:
/datum/dynamic_ruleset/roundstart/gang/clean_up()
	QDEL_NULL(handler)
	..()

//This claims to be essential, but the process_analogue proc seems to be empty? wtf?
/datum/dynamic_ruleset/roundstart/gang/rule_process()
	return handler.process_analogue()
*/

/datum/dynamic_ruleset/roundstart/gang/round_result()
	return handler.set_round_result_analogue()

/datum/dynamic_ruleset/midround/family_head_aspirant
	name = "Families"
	config_tag = "Midround gang"
	preview_antag_datum = /datum/antagonist/gang
	pref_flag = ROLE_FAMILY_HEAD_ASPIRANT
	weight = 1
	min_pop = 10
	max_antag_cap = 3
