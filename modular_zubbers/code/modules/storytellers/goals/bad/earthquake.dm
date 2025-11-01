/datum/round_event_control/earthquake
	id = "earthquake"
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	typepath = /datum/round_event_control/earthquake

	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8
