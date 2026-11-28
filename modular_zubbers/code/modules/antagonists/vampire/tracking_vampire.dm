#define VASSAL_SCAN_MIN_DISTANCE 5
#define VASSAL_SCAN_PING_TIME (2 SECONDS)

/datum/antagonist/vampire/proc/setup_tracker(mob/living/body)
	for(var/datum/antagonist/vassal/vassal in vassals)
		vassal.setup_monitor(vassal.owner?.current)

/datum/antagonist/vampire/proc/cleanup_tracker()
	for(var/datum/antagonist/vassal/vassal in vassals)
		vassal.owner?.current?.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)

/**
 * Pinpointer that points to the vassal's Master at all times.
**/
/atom/movable/screen/alert/status_effect/agent_pinpointer/vassal_edition
	name = "Blood Bond"
	desc = "You always know where your master is."

/datum/status_effect/agent_pinpointer/vassal_edition
	id = "vassal_pinpointer"
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/vassal_edition
	minimum_range = VASSAL_SCAN_MIN_DISTANCE
	tick_interval = VASSAL_SCAN_PING_TIME
	duration = STATUS_EFFECT_PERMANENT
	range_fuzz_factor = 0

/datum/status_effect/agent_pinpointer/vassal_edition/scan_for_target()
	var/datum/antagonist/vassal/vassaldatum = IS_VASSAL(owner)
	scan_target = vassaldatum?.master?.owner?.current

#undef VASSAL_SCAN_MIN_DISTANCE
#undef VASSAL_SCAN_PING_TIME
