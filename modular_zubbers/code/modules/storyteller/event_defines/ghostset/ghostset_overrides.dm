/datum/round_event_control/nightmare
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_SPOOKY)
	weight = 4
	restriction_tags = DEPARTMENT_BITFLAG_SECURITY
	restriction_tag_requirement = 1

/datum/round_event_control/space_dragon
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_CHAOTIC)
	weight = 2
	restriction_tags = DEPARTMENT_BITFLAG_SECURITY
	restriction_tag_requirement = 4

/datum/round_event_control/space_ninja
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT)
	weight = 4
	restriction_tags = DEPARTMENT_BITFLAG_SECURITY
	restriction_tag_requirement = 2

/datum/round_event_control/changeling
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_CREW_ANTAG)
	min_players = 20
	weight = 6
	restriction_tags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL
	restriction_tag_requirement = 2

/datum/round_event_control/alien_infestation
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CHAOTIC)
	weight = 2
	restriction_tags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL
	restriction_tag_requirement = 4

/datum/round_event_control/spider_infestation
	track = EVENT_TRACK_GHOSTSET
	tags = list(TAG_COMBAT, TAG_DESTRUCTIVE, TAG_CHAOTIC)
	weight = 2
	restriction_tags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL
	restriction_tag_requirement = 4
