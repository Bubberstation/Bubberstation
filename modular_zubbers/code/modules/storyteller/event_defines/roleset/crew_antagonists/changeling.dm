/datum/round_event_control/antagonist/solo/changeling
	name = "Changelings"
	roundstart = TRUE

	antag_flag = ROLE_CHANGELING
	antag_datum = /datum/antagonist/changeling
	weight = 8
	min_players = 20
	maximum_antags_global = 4

	tags = list(TAG_COMBAT, TAG_CREW_ANTAG)

	restriction_tags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL
	restriction_tag_requirement = 2

/datum/round_event_control/antagonist/solo/changeling/midround
	name = "Genome Awakening (Changelings)"
	roundstart = FALSE
