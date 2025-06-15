/datum/round_event_control/antagonist/solo/bloodsucker
	name = "Bloodsuckers"
	roundstart = TRUE

	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	weight = 5
	min_players = 30

	maximum_antags_global = 3
	restricted_species = list(SPECIES_PROTEAN)
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/bloodsucker/midround
	name = "Vampiric Accident"
	roundstart = FALSE
