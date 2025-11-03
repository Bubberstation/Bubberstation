/datum/round_event_control/radiation_storm
	id = "radiation_storm"
	typepath = /datum/round_event/radiation_storm
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION
	min_players = 6
	required_round_progress = STORY_ROUND_PROGRESSION_MID

/datum/round_event_control/portal_storm_syndicate
	id = "portal_storm_syndicate"
	typepath = /datum/round_event/portal_storm/syndicate_shocktroop
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_ESCALATION | STORY_TAG_ENTITIES
	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID

/datum/round_event_control/portal_storm_narsie
	id = "portal_storm_narsie"
	typepath = /datum/round_event/portal_storm/portal_storm_narsie
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_ESCALATION | STORY_TAG_ENTITIES
	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID


/datum/round_event_control/processor_overload
	id = "processor_overload"
	typepath = /datum/round_event/processor_overload
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_TARGETS_SYSTEMS
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.3


/datum/round_event_control/shuttle_catastrophe
	id = "shuttle_catastrophe"
	typepath = /datum/round_event/shuttle_catastrophe
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_ESCALATION
	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID


/datum/round_event_control/radiation_leak
	id = "radiation_leak"
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_TARGETS_SYSTEMS | STORY_TAG_ESCALATION
	typepath = /datum/round_event/radiation_leak
	min_players = 6
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED


/datum/round_event_control/earthquake
	id = "earthquake"
	story_category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_TARGETS_SYSTEMS
	typepath = /datum/round_event_control/earthquake

	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8
