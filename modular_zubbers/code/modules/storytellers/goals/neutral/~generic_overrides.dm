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

/datum/round_event_control/space_dust
	id = "space_dust_storyteller"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL)

/datum/round_event_control/fake_virus
	id = "fake_virus"
	typepath = /datum/round_event/fake_virus
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_HUMOROUS, STORY_TAG_SOCIAL)
	min_players = 4
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

/datum/round_event_control/falsealarm
	id = "falsealarm"
	typepath = /datum/round_event/falsealarm
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_HUMOROUS, STORY_TAG_SOCIAL)
	min_players = 4
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

/datum/round_event_control/grey_tide
	id = "grey_tide"
	typepath = /datum/round_event/grey_tide
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_WIDE_IMPACT, STORY_TAG_ENVIRONMENTAL)
	min_players = 8
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

/datum/round_event_control/scrubber_overflow
	id = "scrubber_overflow"
	typepath = /datum/round_event/scrubber_overflow
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_WIDE_IMPACT, STORY_TAG_ENVIRONMENTAL, STORY_TAG_CHAOTIC)
	min_players = 6
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY

/datum/round_event_control/shuttle_insurance
	id = "shuttle_insurance"
	typepath = /datum/round_event/shuttle_insurance
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_SOCIAL)
	min_players = 10
	required_round_progress = STORY_ROUND_PROGRESSION_MID

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

/datum/round_event_control/tram_malfunction
	id = "tram_malfunction"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_REQUIRES_ENGINEERING)
	typepath = /datum/round_event/tram_malfunction
	min_players = 6
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.5

/datum/round_event_control/vent_clog
	id = "vent_clog"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_REQUIRES_ENGINEERING, STORY_TAG_AFFECTS_WHOLE_STATION)
	typepath = /datum/round_event/vent_clog
	min_players = 6
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.6

/datum/round_event_control/vent_clog/major
	id = "vent_clog_major"
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_REQUIRES_ENGINEERING, STORY_TAG_AFFECTS_WHOLE_STATION, STORY_TAG_CHAOTIC)
	typepath = /datum/round_event/vent_clog/major
	min_players = 10
	story_weight = STORY_GOAL_BASE_WEIGHT * 0.5
	required_round_progress = STORY_ROUND_PROGRESSION_LATE

/datum/round_event_control/wormholes
	id = "wormholes"
	typepath = /datum/round_event/wormholes
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENTITIES, STORY_TAG_CHAOTIC, STORY_TAG_HUMOROUS)

/datum/round_event_control/stray_meteor
	id = "stray_meteor"
	typepath = /datum/round_event/stray_meteor
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_ENVIRONMENTAL, STORY_TAG_HUMOROUS)
	required_round_progress = STORY_ROUND_PROGRESSION_LATE

/datum/round_event_control/shuttle_loan
	id = "shuttle_loan"
	typepath = /datum/round_event/shuttle_loan
	story_category = STORY_GOAL_NEUTRAL
	tags = list(STORY_TAG_SOCIAL)
	min_players = 8
	required_round_progress = STORY_ROUND_PROGRESSION_LATE
