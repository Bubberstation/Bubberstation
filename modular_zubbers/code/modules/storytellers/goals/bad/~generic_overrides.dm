/datum/round_event_control/operative
	story_category = STORY_GOAL_NEVER

/datum/round_event_control/dark_matteor
	story_category = STORY_GOAL_NEVER

/datum/round_event_control/radiation_storm
	id = "radiation_storm"
	typepath = /datum/round_event/radiation_storm
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_AFFECTS_WHOLE_STATION, STORY_TAG_ENVIRONMENTAL)
	min_players = 6
	required_round_progress = STORY_ROUND_PROGRESSION_MID

/datum/round_event_control/portal_storm_syndicate
	id = "portal_storm_syndicate"
	typepath = /datum/round_event/portal_storm/syndicate_shocktroop
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_AFFECTS_WHOLE_STATION, STORY_TAG_COMBAT, STORY_TAG_ESCALATION, STORY_TAG_ENTITIES)
	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID

/datum/round_event_control/portal_storm_narsie
	id = "portal_storm_narsie"
	typepath = /datum/round_event/portal_storm/portal_storm_narsie
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_AFFECTS_WHOLE_STATION, STORY_TAG_COMBAT, STORY_TAG_ESCALATION, STORY_TAG_ENTITIES)
	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID


/datum/round_event_control/processor_overload
	id = "processor_overload"
	typepath = /datum/round_event/processor_overload
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_CHAOTIC, STORY_TAG_REQUIRES_ENGINEERING)
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.3


/datum/round_event_control/shuttle_catastrophe
	id = "shuttle_catastrophe"
	typepath = /datum/round_event/shuttle_catastrophe
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_CHAOTIC, STORY_TAG_TRAGIC)
	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID


/datum/round_event_control/radiation_leak
	id = "radiation_leak"
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_WIDE_IMPACT, STORY_TAG_REQUIRES_ENGINEERING)
	typepath = /datum/round_event/radiation_leak
	min_players = 6
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED


/datum/round_event_control/earthquake
	id = "earthquake"
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_ESCALATION, STORY_TAG_WIDE_IMPACT, STORY_TAG_ENVIRONMENTAL, STORY_TAG_REQUIRES_ENGINEERING, STORY_TAG_EPIC)
	typepath = /datum/round_event_control/earthquake

	min_players = 15
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.8


/datum/round_event_control/vent_clog/critical
	id = "vent_clog_critical"
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_REQUIRES_ENGINEERING, STORY_TAG_AFFECTS_WHOLE_STATION, STORY_TAG_ESCALATION)
	typepath = /datum/round_event/vent_clog/critical
	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.4


/datum/round_event_control/immovable_rod
	id = "immovable_rod"
	typepath = /datum/round_event/immovable_rod
	story_category = STORY_GOAL_BAD
	tags = list(STORY_TAG_HUMOROUS, STORY_TAG_CHAOTIC)
	min_players = 5
	required_round_progress = STORY_ROUND_PROGRESSION_MID
