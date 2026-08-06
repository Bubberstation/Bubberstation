/datum/storyteller/bomb
	name = "Destructive Event/Antag Rolls"
	desc = "Formerly known as Bomb, this storyteller will try to make more destructive events. For when you have a full engineering team. Or not, because they all cryo'd."
	welcome_text = "Somebody set up us the bomb."
	track_data = /datum/storyteller_data/tracks/bomb

	tag_multipliers = list(
		TAG_DESTRUCTIVE = 1.5
	)
	population_min = 25
	antag_divisor = 10
	storyteller_type = STORYTELLER_TYPE_INTENSE

/datum/storyteller/bomb/New()
	track_data = new /datum/storyteller_data/tracks/bomb
	track_data.threshold_mundane *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/bomb_points_threshold_coefficient) * CONFIG_GET(number/bomb_ghostset_points_threshold_coefficient)

/datum/storyteller_data/tracks/bomb
	threshold_mundane = 1800
	threshold_moderate = 1400
	threshold_major = 5500

/datum/config_entry/number/bomb_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/bomb_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0
