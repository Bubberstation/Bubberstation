/datum/storyteller_goal/execute_event/bureaucratic_error
	id = "bureaucratic_error"
	name = "Execute Bureaucratic Error"
	desc = "Randomly opens and closes job slots, along with changing the overflow role."
	category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_CHAOTIC | STORY_TAG_AFFECTS_POLITICS | STORY_TAG_AFFECTS_MORALE
	path_ids = list()
	event_path = /datum/round_event_control/bureaucratic_error

	base_weight = STORY_GOAL_BASE_WEIGHT * 0.9
	required_population = 5
