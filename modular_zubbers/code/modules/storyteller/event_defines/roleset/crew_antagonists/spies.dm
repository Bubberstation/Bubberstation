/datum/round_event_control/antagonist/solo/spy
	name = "Spies"
	roundstart = TRUE

	antag_flag = ROLE_SPY
	antag_datum = /datum/antagonist/spy
	weight = 4
	min_players = 40
	base_antags = 2
	maximum_antags = 3
	tags = list(TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/spy/midround
	name = "Spies (Midround)"
	roundstart = FALSE
	weight = 7
