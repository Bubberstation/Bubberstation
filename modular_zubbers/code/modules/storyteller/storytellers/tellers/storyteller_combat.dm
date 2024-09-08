/datum/storyteller/combat
	name = "The Gamer"
	desc = "The Gamer will try to create the most combat focused events, while trying to avoid purely destructive ones."
	welcome_text = "Welcome to the Gamer storyteller. Now with 50% more ahelps!"
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1.3,
		EVENT_TRACK_MAJOR = 1.3,
		EVENT_TRACK_ROLESET = 1,
		EVENT_TRACK_OBJECTIVES = 1
	)
	tag_multipliers = list(
		TAG_COMBAT = 1.5,
		TAG_DESTRUCTIVE = 0.5
	)
	population_min = 35
	antag_divisor = 5
