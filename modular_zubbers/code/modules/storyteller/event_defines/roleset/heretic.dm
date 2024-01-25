/datum/round_event_control/antagonist/solo/heretic
	name = "Heretics"
	roundstart = TRUE

	antag_flag = ROLE_HERETIC
	antag_datum = /datum/antagonist/heretic
	weight = 4
	min_players = 40

/datum/round_event_control/antagonist/solo/heretic/New()
	protected_roles |= JOB_CHAPLAIN // Would be silly to get chaplain heretics
	. = ..()

/datum/round_event_control/antagonist/solo/heretic/midround
	name = "Midround Heretics"
	prompted_picking = TRUE
	roundstart = FALSE
