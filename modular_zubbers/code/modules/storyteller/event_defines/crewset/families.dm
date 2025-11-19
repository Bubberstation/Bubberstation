/datum/round_event_control/antagonist/solo/Families
	name = "Families"
	description = "Create a number of themed faction and send them at eachother's throats"
	antag_flag = ROLE_FAMILIES
	roundstart = TRUE
	antag_datum = /datum/antagonist/gang

	min_players = 2 //DEBUG: Set this to 10 later
	max_occurrences = 0 //disabled from naturally spawning until further notice
	maximum_antags = 3
	base_antags = 1
	minimum_candidate_base = 2

	tags = list(TAG_CREW_ANTAG, TAG_TEAM_ANTAG)

/datum/round_event_control/antagonist/solo/Families/midround
	name = "Family head aspirant"
	roundstart = FALSE
	antag_flag = ROLE_FAMILY_HEAD_ASPIRANT
