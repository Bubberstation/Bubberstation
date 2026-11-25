/datum/round_event_control/antagonist/solo/vampire
	name = "Vampires"
	roundstart = TRUE

	antag_flag = ROLE_VAMPIRE
	antag_datum = /datum/antagonist/vampire
	weight = 5
	min_players = 30

	maximum_antags_global = 3
	restricted_species = list(SPECIES_PROTEAN)
	tags = list(TAG_COMBAT, TAG_SPOOKY, TAG_CREW_ANTAG)

/datum/round_event_control/antagonist/solo/vampire/midround
	name = "Vampiric Accident"
	roundstart = FALSE

/datum/round_event_control/antagonist/solo/vampire/event
	name = "Event Generated Vampire"
	roundstart = FALSE
	tags = list(TAG_ANTAG_REROLL)
	max_occurrences = 0
	maximum_antags = 1
