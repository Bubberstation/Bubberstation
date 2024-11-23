/datum/storyteller/gamer
	name = "The Gamer"
	desc = "The Gamer will try to create the most combat focused events, while trying to avoid purely destructive ones."
	welcome_text = "Welcome to the Gamer storyteller. Now with 50% more ahelps!"

	track_data = /datum/storyteller_data/tracks/gamer

	tag_multipliers = list(
		TAG_COMBAT = 1.5,
		TAG_DESTRUCTIVE = 0.7,
		TAG_CHAOTIC = 1.3
	)
	population_min = 35
	antag_divisor = 5
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller_data/tracks/gamer
	threshold_moderate = 1300
	threshold_major = 6150
	threshold_ghostset = 6000
