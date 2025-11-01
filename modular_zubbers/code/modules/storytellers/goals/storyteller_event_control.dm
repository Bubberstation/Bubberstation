/datum/round_event_control
	// Universal id of this event
	var/id
	// A storyteller category of this event
	var/story_category =  STORY_GOAL_RANDOM
	// Is control of this event was overrided by storyteller
	var/storyteller_override = FALSE
	// A universal tags that helps storyteller to predict event behevour
	var/tags = NONE
	// A storyteller weight override for event selection
	var/story_weight = STORY_GOAL_BASE_WEIGHT

	var/story_prioty = STORY_GOAL_BASE_PRIORITY
	// Minimum threat level required to select this goal
	var/requierd_threat_level = STORY_GOAL_NO_THREAT
	// Minimum round progress (from 0..1) required to select this goal
	var/required_round_progress = STORY_ROUND_PROGRESSION_START



/datum/round_event_control/proc/is_avaible(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = TRUE
	if(!can_spawn_event(inputs.get_entry(STORY_VAULT_CREW_ALIVE_COUNT)))
		return FALSE
	if(!valid_for_map())
		return FALSE
	if(storyteller.get_effective_threat() < requierd_threat_level)
		return FALSE
	if(storyteller.round_progression < required_round_progress)
		return FALSE
	return .




/datum/round_event_control/proc/get_story_weight(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/base_weight = story_weight
	if(story_category & STORY_GOAL_GLOBAL)
		base_weight = STORY_GOAL_MAJOR_WEIGHT
	else if(story_category & STORY_GOAL_BAD)
		base_weight = STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_FORCE_TENSION) && story_category & STORY_GOAL_BAD)
		base_weight += STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_KIND) && story_category & STORY_GOAL_GOOD)
		base_weight += STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_NO_GOOD_EVENTS) && story_category & STORY_GOAL_GOOD)
		base_weight = 0
	return base_weight




/datum/round_event_control/proc/get_story_priority(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return story_prioty







/datum/round_event_control/proc/can_fire_now(datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE






/datum/round_event_control/proc/run_event_as_storyteller(datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points)
	var/datum/round_event/round_event = new typepath(TRUE, src)
	if(SEND_SIGNAL(SSdcs, COMSIG_GLOB_STORYTELLER_RUN_EVENT, round_event) && CANCEL_STORYTELLER_EVENT)
		return FALSE

	round_event.__setup_for_storyteller(threat_points)
	round_event.current_players = storyteller.get_active_player_count()
	occurrences += 1
	testing("[time2text(world.time, "hh:mm:ss", 0)] [round_event.type]")
	triggering = TRUE
	storyteller_override = TRUE
	log_storyteller("[storyteller.name] run event [name]")
	if(alert_observers)
		round_event.announce_deadchat(FALSE, "by [storyteller.name]")

	SSblackbox.record_feedback("tally", "event_ran", 1, "[round_event]")
	return TRUE
