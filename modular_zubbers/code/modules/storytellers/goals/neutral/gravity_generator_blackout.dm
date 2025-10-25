/datum/storyteller_goal/execute_event/gravity_generator_blackout
	id = "gravity_generator_error"
	name = "Gravity Generator Error"
	desc = "Cause a malfunction in the station's gravity generator."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	event_path = /datum/round_event/gravity_generator_blackout
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY


/datum/storyteller_goal/execute_event/gravity_generator_blackout/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = ..()
	if(SSmapping.is_planetary())
		. = FALSE
	return .
