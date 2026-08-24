/datum/storyteller/enemy
	name = "Higher Crewset Antag/Event Rolls"
	desc = "Formerly known as The Enemy Within, this storyteller aims to ensure that there are only crew antagonists while also prioritizing spawns for those antagonist types."
	welcome_text = "Chat, I think there is an imposter among us on this Space Station 13. I have grown suspicious."

	tag_multipliers = list(
		TAG_DESTRUCTIVE = 0.25,
		TAG_CHAOTIC = 0.1, //*look inside high chaos storyteller* *no chaos*
		TAG_CREW_ANTAG = 2,
	)
	population_min = 35
	antag_divisor = 5
	storyteller_type = STORYTELLER_TYPE_INTENSE

	guarantees_roundstart_crewset = TRUE

	track_data = /datum/storyteller_data/tracks/enemy

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 0,
		EVENT_TRACK_MODERATE = 0,
		EVENT_TRACK_MAJOR = 0,
		EVENT_TRACK_CREWSET = 1,
		EVENT_TRACK_GHOSTSET = 0
	)

	event_repetition_multiplier = 1 //Set from default 0.6 so that the round just doesn't throw every antag type possible at the crew.

/datum/storyteller/enemy/New()
	track_data = new /datum/storyteller_data/tracks/enemy
	track_data.threshold_mundane *= CONFIG_GET(number/enemy_points_threshold_coefficient) * CONFIG_GET(number/enemy_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/enemy_points_threshold_coefficient) * CONFIG_GET(number/enemy_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/enemy_points_threshold_coefficient) * CONFIG_GET(number/enemy_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/enemy_points_threshold_coefficient) * CONFIG_GET(number/enemy_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/enemy_points_threshold_coefficient) * CONFIG_GET(number/enemy_ghostset_points_threshold_coefficient)

/datum/storyteller_data/tracks/enemy
	threshold_mundane = 1200
	threshold_moderate = 1800
	threshold_major = 8000
	threshold_crewset = 1950
	threshold_ghostset = 6500

/datum/config_entry/number/enemy_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/enemy_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/enemy_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/enemy_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/enemy_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/enemy_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0
