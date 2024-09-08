/datum/storyteller/clown
	name = "The Clown"
	desc = "The Clown will try to create the most events and antagonists out of all the storytellers, regardless if you like it or not."
	welcome_text = "honk"

	track_data = /datum/storyteller_data/tracks/clown

	population_min = 50
	antag_divisor = 4

/datum/storyteller_data/tracks/clown
	var/threshold_mundane = 700
	var/threshold_moderate = 1600
	var/threshold_major = 4800
	var/threshold_crewset = 1000
	var/threshold_ghostset = 4000
