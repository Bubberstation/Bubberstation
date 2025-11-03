/datum/round_event_control
	// Universal id of this event
	var/id
	// A storyteller category of this event
	var/story_category =  STORY_GOAL_RANDOM | STORY_GOAL_NEVER
	// Is control of this event was overrided by storyteller
	var/storyteller_override = FALSE
	// A universal tags that helps storyteller to predict event behevour
	var/tags = NONE
	// A storyteller weight override for event selection
	var/story_weight = STORY_GOAL_BASE_WEIGHT * 0.1 // Low weight by default

	var/story_prioty = STORY_GOAL_BASE_PRIORITY
	// Minimum threat level required to select this goal
	var/requierd_threat_level = STORY_GOAL_NO_THREAT
	// Minimum round progress (from 0..1) required to select this goal
	var/required_round_progress = STORY_ROUND_PROGRESSION_START

	VAR_FINAL/additional_arguments = list()


/datum/round_event_control/proc/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!can_spawn_event(inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT)))
		return FALSE
	if(!valid_for_map())
		return FALSE
	if(storyteller.get_effective_threat() < requierd_threat_level)
		return FALSE
	if(storyteller.round_progression < required_round_progress)
		return FALSE
	return TRUE




/datum/round_event_control/proc/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_weight




/datum/round_event_control/proc/get_story_priority(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_prioty





/datum/round_event_control/proc/can_fire_now(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE




/datum/round_event_control/proc/pre_storyteller_run(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	return


/datum/round_event_control/proc/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	pre_storyteller_run(inputs, storyteller, threat_points)
	var/datum/round_event/round_event = new typepath(TRUE, src)
	if(SEND_SIGNAL(SSdcs, COMSIG_GLOB_STORYTELLER_RUN_EVENT, round_event) && CANCEL_STORYTELLER_EVENT)
		return FALSE

	round_event.__setup_for_storyteller(threat_points, additional_arguments, inputs, storyteller)
	round_event.current_players = storyteller.get_active_player_count()
	occurrences += 1
	testing("[time2text(world.time, "hh:mm:ss", 0)] [round_event.type]")
	triggering = TRUE
	storyteller_override = TRUE
	log_storyteller("[storyteller.name] run event [name]")
	if(alert_observers)
		round_event.announce_deadchat(FALSE, "by [storyteller.name]")
	message_admins("[span_notice("[storyteller.name] fired event: ")] [name || id]. with threat points: [threat_points]")
	SSblackbox.record_feedback("tally", "event_ran", 1, "[round_event]")
	return TRUE

