/datum/storyteller/outsiders
	name = "Contacts at the Gate (High Chaos)"
	desc = "Contacts at the Gate attempts to prioritize external, high threat events such as Blob and Xenos, with a little bit of space traitor and ling, as a treat."
	welcome_text = "Damn, they're certainly at that gate alright. Fucked up."

	tag_multipliers = list(
		TAG_DESTRUCTIVE = 1,
		TAG_CHAOTIC = 0.75,
		TAG_CREW_ANTAG = 0.25,
	)
	population_min = 35
	antag_divisor = 10
	storyteller_type = STORYTELLER_TYPE_INTENSE

	guarantees_roundstart_crewset = TRUE

	track_data = /datum/storyteller_data/tracks/outsiders

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.5,
		EVENT_TRACK_MODERATE = 0.5,
		EVENT_TRACK_MAJOR = 0.75,
		EVENT_TRACK_CREWSET = 0.15,
		EVENT_TRACK_GHOSTSET = 1
	)

	event_repetition_multiplier = 1

/datum/storyteller_data/tracks/outsiders
	threshold_mundane = 1200
	threshold_moderate = 1800
	threshold_major = 4000
	threshold_crewset = 5000
	threshold_ghostset = 4000
