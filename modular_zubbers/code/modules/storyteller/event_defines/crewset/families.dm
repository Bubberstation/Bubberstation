/datum/round_event_control/antagonist/families
	name = "Families"
	description = "Create a number of themed faction and send them at eachother's throats"
	antag_flag = ROLE_FAMILIES
	roundstart = TRUE
	antag_datum = /datum/antagonist/gang
	typepath = /datum/round_event/antagonist/families

	min_players = 20
	max_occurrences = 0 //disabled from naturally spawning until further notice
	maximum_antags = 3
	base_antags = 2
	minimum_candidate_base = 2

	tags = list(TAG_CREW_ANTAG, TAG_TEAM_ANTAG)

/datum/round_event/antagonist/families
	var/datum/gang_handler/handler

/datum/round_event/antagonist/families/candidate_setup(datum/round_event_control/antagonist/cast_control)
	handler = new /datum/gang_handler(cast_control.get_candidates(), cast_control.restricted_roles)
	handler.gang_balance_cap = clamp((get_active_player_count() - 3), 2, 5) // gang_balance_cap by indice_pop: (2,2,2,2,2,3,4,5,5,5)
	handler.use_dynamic_timing = TRUE
	return handler.pre_setup_analogue()

/datum/round_event/antagonist/families/start()
	return handler.post_setup_analogue(TRUE)



/datum/round_event_control/antagonist/families/midround
	name = "Family head aspirant"
	roundstart = FALSE
	antag_flag = ROLE_FAMILY_HEAD_ASPIRANT
