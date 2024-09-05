/datum/storyteller/destructive
	name = "The Bomb"
	desc = "The Bomb will try to make as many destructive events as possible. For when you have a full engineering team. Or not, because they all cryo'd."
	welcome_text = "Somebody set up us the bomb."
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.5,
		EVENT_TRACK_MODERATE = 1.4,
		EVENT_TRACK_MAJOR = 1.5,
		EVENT_TRACK_ROLESET = 1,
		EVENT_TRACK_OBJECTIVES = 0.8
	)
	tag_multipliers = list(
		TAG_DESTRUCTIVE = 2.5
	)
	population_min = 25
	antag_divisor = 10
