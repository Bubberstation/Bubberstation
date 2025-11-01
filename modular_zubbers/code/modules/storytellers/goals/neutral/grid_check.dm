/datum/storyteller_goal/execute_event/grid_check
	id = "grid_check"
	name = "Execute Grid Check"
	desc = "Turns off all APCs for a while, or until they are manually rebooted."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_TARGETS_SYSTEMS | STORY_TAG_AFFECTS_WHOLE_STATION
	event_path = /datum/round_event/grid_check
