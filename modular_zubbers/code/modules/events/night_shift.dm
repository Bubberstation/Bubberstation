/datum/round_event_control/nightshift
	track = EVENT_TRACK_MUNDANE
	weight = 75
	max_occurrences = 2
	earliest_start = 15 MINUTES
	tags = list(TAG_COMMUNAL, TAG_POSITIVE)
	reoccurence_penalty_multiplier = 0
	// last time we ran night shift
	var/previous_night_shift

// because we can run night shift multiple times over 3+ hour rounds, we enforce a minimum time between night shift triggers
/datum/round_event_control/nightshift/can_spawn_event(players_amt, allow_magic = FALSE)
	. = ..()
	if(!.)
		return

	var/datum/round_event_control/nightshift/night_shift = locate(/datum/round_event_control/nightshift) in SSgamemode.event_pools[EVENT_TRACK_MUNDANE]
	if(!night_shift.previous_night_shift)
		return TRUE

	if(world.time <= night_shift.previous_night_shift + 90 MINUTES)
		return FALSE

	return TRUE

/datum/round_event/nightshift
	end_when = 1400
