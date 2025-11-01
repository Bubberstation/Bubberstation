/datum/storyteller_goal/execute_event/earthquake
	id = "earthquake"
	name = "Chasmic Earthquake"
	desc = "Causes an earthquake, demolishing anything caught in the fault."
	category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	event_path = /datum/round_event_control/earthquake

	required_population = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED

	base_weight = STORY_GOAL_BASE_WEIGHT * 0.8

/datum/storyteller_goal/execute_event/earthquake/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(!SSmapping.is_planetary())
		. = FALSE
	return .

