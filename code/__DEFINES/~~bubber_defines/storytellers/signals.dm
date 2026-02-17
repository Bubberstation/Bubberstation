// From /datum/storyteller_analyzer/proc/scan_station()
#define COMSIG_STORYTELLER_RUN_METRICS "comsig_storyteller_run_metrics"

// From /datum/storyteller_analyzer/proc/scan_station(), storyteller_inputs/inputs, timeout, total_metrics
#define COMSIG_STORYTELLER_FINISHED_ANALYZING "comsig_storyteller_finish_analyzing"

// From /datum/storyteller/proc/think()
#define COMSIG_STORYTELLER_PRE_THINK "comsig_storyteller_pre_think"
	// Use to prevent thinking
	#define COMPONENT_THINK_BLOCKED (1 << 0)

// From /datum/storyteller/proc/think()
#define COMSIG_STORYTELLER_POST_THINK "comsig_storyteller_post_think"

// From /datum/controller/subsystem/storytellers/proc/start_vote()
#define COMSIG_STORYTELLER_VOTE_START "comsig_stryteller_vote_start"

// From /datum/controller/subsystem/storytellers/proc/end_vote()
#define COMSIG_STORYTELLER_VOTE_END "comsig_stryteller_vote_end"

/// Called by (/datum/round_event_control/run_event_as_storyteller).
#define COMSIG_GLOB_STORYTELLER_RUN_EVENT "!storyteller_event"
	/// Do not allow this random event to continue.
	#define CANCEL_STORYTELLER_EVENT (1<<0)
