/*
/datum/storyteller/fragile
	name = "The Fragile"
	desc = "The Fragile will limit destructive and combat-focused events, and you'll rarely see midround antagonist roles that usually cause it."
	welcome_text = "Handle with care!"

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_ROLESET = 4,
		EVENT_TRACK_OBJECTIVES = 1
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_MAJOR = 1,
		EVENT_TRACK_ROLESET = 0.1,
		EVENT_TRACK_OBJECTIVES = 1
	)

	event_repetition_multiplier = 0.5

	tag_multipliers = list(
		TAG_COMBAT = 0.5,
		TAG_SPOOKY = 1,
		TAG_DESTRUCTIVE = 0.1,
		TAG_COMMUNAL = 0.5,
		TAG_TARGETED = 0.5,
		TAG_POSITIVE = 2,
		TAG_CREW_ANTAG = 2,
		TAG_TEAM_ANTAG = 0.5,
		TAG_OUTSIDER_ANTAG = 0.25
	)
*/
