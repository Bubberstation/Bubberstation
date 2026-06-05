/datum/round_event_control/antagonist/solo/devil
	name = "Devils"
	roundstart = TRUE

	antag_flag = ROLE_DEVIL
	antag_datum = /datum/antagonist/devil
	weight = 7 // Just for testing, then bump it down to 5.
	min_players = 30

	maximum_antags_global = 1

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/devil/midround
	name = "Midround Devil"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/devil/event
	name = "Event Generated Devil"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
