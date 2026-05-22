/datum/round_event_control/antagonist/solo/heretic
	name = "Acolytes"
	roundstart = TRUE

	antag_flag = ROLE_HERETIC
	antag_datum = /datum/antagonist/heretic
	weight = 7
	max_occurrences = 4
	min_players = 20

	maximum_antags_global = 2

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/heretic/New()
	protected_roles |= JOB_CHAPLAIN // Would be silly to get chaplain heretics
	. = ..()

#define TIME_CUTOFF 1.2 HOURS
/datum/round_event_control/antagonist/solo/heretic/midround
	name = "Midround Acolytes"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/heretic/midround/can_spawn_event(players_amt, allow_magic, popchecks)
	. = ..()
	if (!.)
		return FALSE

	var/time = STATION_TIME_PASSED()
	return time <= TIME_CUTOFF

/datum/round_event_control/antagonist/solo/heretic/event
	name = "Event Generated Acolyte"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1

#undef TIME_CUTOFF
