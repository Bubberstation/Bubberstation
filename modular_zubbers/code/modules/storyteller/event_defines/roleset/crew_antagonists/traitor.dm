/datum/round_event_control/antagonist/solo/traitor
	name = "Traitors"
	roundstart = TRUE

	antag_flag = ROLE_TRAITOR
	antag_datum = /datum/antagonist/traitor
	weight = 6

	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/traitor/midround
	name = "Sleeper Agents (Traitors)"
	roundstart = FALSE
	weight = 7
