/datum/storyteller_goal/execute_event/gravity_generator_error
	id = "gravity_generator_error"
	name = "Gravity Generator Error"
	desc = "Cause a malfunction in the station's gravity generator."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	path_ids = list()
	event_path = null

/datum/storyteller_goal/gravity_generator_error/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return storyteller.mood.get_threat_multiplier() > 1.0
