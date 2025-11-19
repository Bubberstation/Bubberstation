/datum/round_event_control/antagonist/Families
	name = "Families"
	description = "Create a number of themed faction and send them at eachother's throats"
	antag_flag = ROLE_FAMILIES
	roundstart = TRUE
	antag_datum = /datum/antagonist/gang

	min_players = 0 //DEBUG: Set this to 10 later
	max_occurrences = 0 //disabled from naturally spawning until further notice
	maximum_antags = 3
	base_antags = 1
	minimum_candidate_base = 2
	tags = list(TAG_CREW_ANTAG)
