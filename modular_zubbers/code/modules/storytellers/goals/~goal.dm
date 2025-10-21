// Storyteller Goals
/datum/storyteller_goal
	// Unique identifier for the goal
	var/id
	// Display name
	var/name
	// Description
	var/desc
	// Category of the goal
	var/category
	// Optional for filtering
	var/tags
	// Optional parent goal id
	var/parent_id
	// Linked child goal datums after resolution
	var/list/children
	// List of child goal ids to link after selection
	var/list/path_ids
	// Optional event path to trigger on achievement (e.g., /datum/event/meteor)
	var/event_path
	// Color for announcer messages
	var/announce_color = COLOR_GRAY
	// Minimum threat level required to select this goal
	var/requierd_threat_level = STORY_GOAL_NO_THREAT
	// Minimum population of alive and non-afk crew required to select this goal
	var/requierd_population = 0
	// Minimum round progress (from 0..1) required to select this goal
	var/required_round_progress = STORY_ROUND_PROGRESSION_START


/// Is goal available for selection under the given context?
/datum/storyteller_goal/proc/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = TRUE
	if(storyteller.get_effective_threat() < requierd_threat_level)
		. = FALSE
	if(vault[STORY_VAULT_CREW_ALIVE_COUNT] < requierd_population)
		. = FALSE
	if(storyteller.round_progression < required_round_progress)
		. = FALSE
	return .

/// Compute selection weight
/datum/storyteller_goal/proc/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/base_weight = STORY_GOAL_BASE_WEIGHT
	if(category & STORY_GOAL_GLOBAL)
		base_weight = STORY_GOAL_MAJOR_WEIGHT
	else if(category & STORY_GOAL_BAD)
		base_weight = STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_FORCE_TENSION) && category & STORY_GOAL_BAD)
		base_weight += STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_KIND) && category & STORY_GOAL_GOOD)
		base_weight += STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_NO_GOOD_EVENTS) && category & STORY_GOAL_GOOD)
		base_weight = 0
	return base_weight

/datum/storyteller_goal/proc/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/base_weight = STORY_GOAL_BASE_WEIGHT
	if(category & STORY_GOAL_GLOBAL)
		base_weight = STORY_GOAL_MAJOR_WEIGHT
	else if(category & STORY_GOAL_BAD)
		base_weight = STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_FORCE_TENSION) && category & STORY_GOAL_BAD)
		base_weight += STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_KIND) && category & STORY_GOAL_GOOD)
		base_weight += STORY_GOAL_BIG_WEIGHT
	if(HAS_TRAIT(storyteller, STORYTELLER_TRAIT_NO_GOOD_EVENTS) && category & STORY_GOAL_GOOD)
		base_weight = 0
	return base_weight


/datum/storyteller_goal/proc/get_progress(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 1


/datum/storyteller_goal/proc/can_fire_now(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE

/// Return linked children
/datum/storyteller_goal/proc/get_children()
	return children

/// Link this goal's children by id using a registry
/datum/storyteller_goal/proc/link_children(list/goals_by_id)
	children = list()
	if(!path_ids || !length(path_ids))
		return children

	for(var/i in 1 to path_ids.len)
		var/child_id = path_ids[i]
		var/datum/storyteller_goal/G = goals_by_id[child_id]
		if(G)
			children += G
	return children

/// Complete goal and triggers associative events if any
/datum/storyteller_goal/proc/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	if(event_path)
		var/datum/round_event/E = new event_path(TRUE, new /datum/round_event_control/storyteller_control)
		E.__setup_for_storyteller(threat_points)
	return TRUE


/datum/storyteller_goal/global_goal/execute_event
	name = "Execute the event"




/datum/storyteller_goal/execute_random_event
	id = "execute_random_event"
	name = "Execute Random Event"
	desc = "Triggers a random event from the SSevents event pool."
	children = list()
	category = STORY_GOAL_RANDOM
	tags = STORY_TAG_CHAOTIC
	event_path = null // This will be set dynamically

	var/list/possible_events = list()


/datum/storyteller_goal/execute_random_event/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(storyteller.mood.volatility >= 1.3) //Best for chaotic storytellers
		return TRUE
	else
		return FALSE


/datum/storyteller_goal/execute_random_event/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return rand(STORY_GOAL_BASE_WEIGHT, STORY_GOAL_BASE_WEIGHT * 2) * storyteller.mood.volatility

/datum/storyteller_goal/execute_random_event/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	var/base = ..()
	return base * (1 - storyteller.adaptation_factor)


/datum/storyteller_goal/execute_random_event/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	if(!possible_events.len)
		possible_events = list()
		for(var/datum/round_event/event in subtypesof(/datum/round_event))
			if(event::allow_random && event != /datum/round_event)
				possible_events += event

	if(!possible_events.len)
		message_admins("No valid random events found for storyteller to execute.")
		return
	var/datum/round_event/event_to_execute = pick(possible_events)
	var/datum/round_event/evt = new event_to_execute(TRUE, new /datum/round_event_control/storyteller_control)
	evt.setup() // Executing event normally(without storyteller)
	return TRUE
