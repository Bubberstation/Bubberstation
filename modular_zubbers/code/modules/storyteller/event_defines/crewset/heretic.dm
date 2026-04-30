/datum/round_event_control/antagonist/solo/heretic
	name = "Acolytes"
	roundstart = TRUE

	antag_flag = ROLE_HERETIC
	antag_datum = /datum/antagonist/heretic
	weight = 6
	max_occurrences = 4
	min_players = 20

	maximum_antags_global = 2

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/heretic/New()
	protected_roles |= JOB_CHAPLAIN // Would be silly to get chaplain heretics
	. = ..()

/datum/round_event_control/antagonist/solo/heretic/midround
	name = "Midround Acolytes"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/heretic/event
	name = "Event Generated Acolyte"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
