/datum/storyteller/black_star
	name = "Black Star (High Chaos)"
	desc = "The Black Star will have a chance to roll Nukies on round start and otherwise be chaotic"
	welcome_text = "Oh my, would you look at the time..."

	tag_multipliers = list(
		TAG_BIG_THREE = 2,
		TAG_CHAOTIC = 2,
		TAG_DESTRUCTIVE = 1
	)

	population_min = 70
	antag_divisor = 6
	storyteller_type = STORYTELLER_TYPE_INTENSE

	track_data = /datum/storyteller_data/tracks/gamer

	guarantees_roundstart_crewset = TRUE

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.7,
		EVENT_TRACK_MODERATE = 1.4,
		EVENT_TRACK_MAJOR = 1.2,
		EVENT_TRACK_GHOSTSET = 0
	)
