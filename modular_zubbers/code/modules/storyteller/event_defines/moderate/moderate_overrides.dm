/datum/round_event_control/brand_intelligence
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_DESTRUCTIVE, TAG_COMMUNAL, TAG_CHAOTIC)
	restriction_tags = DEPARTMENT_BITFLAG_ENGINEERING
	restriction_tag_requirement = 2

/datum/round_event_control/carp_migration
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL)
	restriction_tags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY
	restriction_tag_requirement = 2

/datum/round_event_control/communications_blackout
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_SPOOKY)

/datum/round_event_control/grid_check
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_SPOOKY)

/datum/round_event_control/ion_storm
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_TARGETED)
	restriction_tags = DEPARTMENT_BITFLAG_COMMAND
	restriction_tag_requirement = 1

/datum/round_event_control/processor_overload
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL)

/datum/round_event_control/radiation_leak
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL)
	restriction_tags = DEPARTMENT_BITFLAG_ENGINEERING
	restriction_tag_requirement = 1

/datum/round_event_control/sandstorm
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_DESTRUCTIVE)
	restriction_tags = DEPARTMENT_BITFLAG_ENGINEERING
	restriction_tag_requirement = 1

/datum/round_event_control/shuttle_catastrophe
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL)
	restriction_tags = DEPARTMENT_BITFLAG_ENGINEERING //Unironic chance to get build your own shuttle.
	restriction_tag_requirement = 2

/datum/round_event_control/vent_clog
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL)
	restriction_tags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY //Could be something bad.
	restriction_tag_requirement = 2

/datum/round_event_control/anomaly
	weight = 10 // Lower from original 15 because it KEEPS SPAWNING THEM
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_DESTRUCTIVE)
	restriction_tags = DEPARTMENT_BITFLAG_SCIENCE
	restriction_tag_requirement = 2

/datum/round_event_control/spacevine
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_CHAOTIC)
	restriction_tags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY //Could spawn sentient maneaters.
	restriction_tag_requirement = 4

/datum/round_event_control/portal_storm_syndicate
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMBAT, TAG_CHAOTIC)
	restriction_tags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY
	restriction_tag_requirement = 4

/datum/round_event_control/mold
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_COMBAT, TAG_CHAOTIC)
	restriction_tags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_ENGINEERING
	restriction_tag_requirement = 4
	weight = 0
	max_occurrences = 0
