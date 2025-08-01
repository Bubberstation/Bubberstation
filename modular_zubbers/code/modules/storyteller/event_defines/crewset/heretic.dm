/datum/round_event_control/antagonist/solo/heretic
	name = "Heretics"
	roundstart = TRUE

	antag_flag = ROLE_HERETIC
	antag_datum = /datum/antagonist/heretic
	weight = 9
	min_players = 35

	maximum_antags_global = 4

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/heretic/New()
	protected_roles |= JOB_CHAPLAIN // Would be silly to get chaplain heretics
	. = ..()

/datum/round_event_control/antagonist/solo/heretic/midround
	name = "Midround Heretics"
	roundstart = FALSE
