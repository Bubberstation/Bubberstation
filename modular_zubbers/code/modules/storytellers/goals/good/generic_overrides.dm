/datum/round_event_control/stray_cargo
	id = "stray_cargo"
	typepath = /datum/round_event/stray_cargo
	story_category = STORY_GOAL_GOOD
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_WIDE_IMPACT, STORY_TAG_HEALTH)
	story_weight = STORY_GOAL_BASE_WEIGHT * 1.2

/datum/round_event_control/stray_cargo/syndicate
	id = "stray_cargo_syndicate"
	typepath = /datum/round_event/stray_cargo/syndicate
	story_category = STORY_GOAL_GOOD
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8

/datum/round_event_control/wisdomcow
	id = "wisdomcow"
	typepath = /datum/round_event/wisdomcow
	story_category = STORY_GOAL_GOOD
	tags = list(STORY_TAG_HUMOROUS, STORY_TAG_SOCIAL)
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8

/datum/round_event_control/sentience
	id = "sentience_animal"
	story_category = STORY_GOAL_GOOD
	tags = list(STORY_TAG_SOCIAL)
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.9

/datum/round_event_control/sentience/all
	id = "sentience_all"
	story_category = STORY_GOAL_GOOD
	tags = list(STORY_TAG_SOCIAL, STORY_TAG_EPIC)
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8
