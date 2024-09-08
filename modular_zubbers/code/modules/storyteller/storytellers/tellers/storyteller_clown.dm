/datum/storyteller/clown
	name = "The Clown"
	desc = "The Clown will try to create the most events and antagonists out of all the storytellers, regardless if you like it or not."
	welcome_text = "honk"

	track_data = /datum/storyteller_data/tracks/clown

	population_min = 50
	antag_divisor = 4
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller_data/tracks/clown
	threshold_mundane = 700
	threshold_moderate = 1600
	threshold_major = 4800
	threshold_crewset = 1000
	threshold_ghostset = 4000
