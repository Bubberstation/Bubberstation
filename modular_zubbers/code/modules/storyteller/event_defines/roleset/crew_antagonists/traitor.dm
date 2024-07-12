/datum/round_event_control/antagonist/solo/traitor
	name = "Traitors"
	roundstart = TRUE

	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor
	min_players = 40
	weight = 5
	base_antags = 1
	maximum_antags = 2

	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/traitor/midround
	name = "Sleeper Agents (Traitors)"
	roundstart = FALSE
	weight = 7
	antag_datum = /datum/antagonist/traitor/infiltrator/sleeper_agent
