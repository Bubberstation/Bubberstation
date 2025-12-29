/datum/round_event_control/sandstorm
	id = "sandstorm"
	typepath = /datum/round_event/sandstorm
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL)

/datum/round_event_control/sandstorm_classic
	id = "sandstorm_classic"
	typepath = /datum/round_event/sandstorm_classic
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL)

/datum/round_event_control/scrubber_overflow
	id = "scrubber_overflow"
	typepath = /datum/round_event/scrubber_overflow
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_WIDE_IMPACT, STORY_TAG_ENVIRONMENTAL, STORY_TAG_CHAOTIC)
	min_players = 6
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

/datum/round_event_control/bureaucratic_error
	id = "bureaucratic_error"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_SOCIAL, STORY_TAG_HUMOROUS)
	typepath = /datum/round_event_control/bureaucratic_error

	story_weight = STORY_GOAL_BASE_WEIGHT * 0.9
	min_players = 5

/datum/round_event_control/camera_failure
	id = "camera_failure"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_REQUIRES_ENGINEERING)
	typepath = /datum/round_event/camera_failure


/datum/round_event_control/mass_hallucination
	id = "mass_hallucination"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_HUMOROUS, STORY_TAG_SOCIAL)
	typepath = /datum/round_event/mass_hallucination

	min_players = 2
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.7

/datum/round_event_control/mice_migration
	id = "mice_migration"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENTITIES)
	typepath = /datum/round_event/mice_migration
