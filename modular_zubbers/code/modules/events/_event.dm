//Note: Regardless of these settings, all events cannot run if the shuttle is in transit or docked at central command.
//Some /tg/station events have hardcoded condition checks (Example: The shuttle insurance event cannot trigger if the shuttle is already docked with the station).

//Always run the event, regardless of shuttle status (Exception: See above).
#define EVENT_CONTROL_SHUTTLE_ALWAYS 0x0

//Only run when the shuttle is idle or is recalled.
#define EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE (1 << 0)

//Only run when the shuttle can be recalled.
#define EVENT_CONTROL_RUN_WHEN_RECALLABLE (1 << 1)

//Only run when the shuttle is not docked, or past that point.
#define EVENT_CONTROL_RUN_WHEN_NOT_DOCKED (1 << 2)

/datum/round_event_control/
	var/shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_NOT_DOCKED //By default, no events will trigger if the emergency shuttle is docked with the station or past that point.

/datum/round_event_control/can_spawn_event(players_amt, allow_magic = FALSE)

	. = ..()

	if( (shuttle_run_flags & EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE) && !EMERGENCY_IDLE_OR_RECALLED)
		return FALSE

	if( (shuttle_run_flags & EVENT_CONTROL_RUN_WHEN_RECALLABLE) && EMERGENCY_PAST_POINT_OF_NO_RETURN)
		return FALSE

	if( (shuttle_run_flags & EVENT_CONTROL_RUN_WHEN_NOT_DOCKED) && !EMERGENCY_AT_LEAST_DOCKED)
		return FALSE

//These are crew roles that require some semblence of setup (mechanics wise) and/or roleplay. Usually.
//Basically these are roles that are typically poorly played if rushed or against a short time limit (see: shuttle call).
/datum/round_event_control/antagonist //Almost all antagonist events. These are typically crew spawns. Don't worry blob and xeno mains; these aren't counted.
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/abductor
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/lone_infiltrator
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/obsessed
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/changeling
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/fugitives
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/space_ninja
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/operative
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/pirates
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE

/datum/round_event_control/cortical_borer
	shuttle_run_flags = EVENT_CONTROL_RUN_WHEN_SHUTTLE_IDLE
