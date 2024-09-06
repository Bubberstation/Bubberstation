/datum/round_event_control/antagonist/solo/bloodsucker
	name = "Bloodsuckers"
	roundstart = TRUE

	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	weight = 8
	min_players = 20

	base_antags = 2
	maximum_antags = 3
	maximum_antags_global = 3

	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

	restriction_tags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL
	restriction_tag_requirement = 2

/datum/round_event_control/antagonist/solo/bloodsucker/midround
	name = "Vampiric Accident"
	roundstart = FALSE
