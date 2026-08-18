/datum/storyteller/default
	name = "Default Event/Antag Rolls"
	desc = "Formerly called Default Andy, this is the default Storyteller, and the comparison point for every other Storyteller. \
	More frequent events than the lower intensity Chill or the Fragile, but less frequent events than Gamer or Enemy Within. Best for an average, varied experience."
	welcome_text = "If I chopped you up in a meat grinder..."
	antag_divisor = 8
	storyteller_type = STORYTELLER_TYPE_ALWAYS_AVAILABLE

	tag_multipliers = list(
		TAG_CHAOTIC = 0.7
	)

/datum/storyteller/default/New()
	track_data = new /datum/storyteller_data/tracks
	track_data.threshold_mundane *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/default_points_threshold_coefficient) * CONFIG_GET(number/default_ghostset_points_threshold_coefficient)

/datum/config_entry/number/default_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/default_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

