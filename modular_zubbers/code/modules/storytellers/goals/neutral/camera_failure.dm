/datum/storyteller_goal/execute_event/camera_failure
	id = "camera_failure"
	name = "Cause Camera Failure"
	desc = "Disable a number of security cameras around the station."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	path_ids = list()
	event_path = /datum/round_event/camera_failure


/datum/storyteller_goal/execute_event/camera_failure/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_WEIGHT + storyteller.threat_points * 0.03

/datum/storyteller_goal/execute_event/camera_failure/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_PRIORITY + storyteller.threat_points * 0.05

/datum/round_event/camera_failure
	allow_random = FALSE
