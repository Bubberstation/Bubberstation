/datum/storyteller_goal/execute_event/camera_failure
	id = "camera_failure"
	name = "Cause Camera Failure"
	desc = "Disable a number of security cameras around the station."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	path_ids = list()
	event_path = /datum/round_event/camera_failure




/datum/round_event/camera_failure
	allow_random = FALSE
