/datum/storyteller/plenty
	name = "The Clown"
	desc = "The Clown will try to create the most events out of all the storytellers, regardless if you like it or not."
	welcome_text = "honk"
	event_repetition_multiplier = 0.8
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.2,
		EVENT_TRACK_MODERATE = 1.4,
		EVENT_TRACK_MAJOR = 1.4,
		EVENT_TRACK_ROLESET = 1,
		EVENT_TRACK_OBJECTIVES = 1
	)
	population_min = 35
	antag_divisor = 8
