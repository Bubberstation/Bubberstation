/datum/storyteller/chill
	name = "Low Event/Antag Rolls"
	desc = "Formerly known as Chill, this storyteller will be light on events and antag rolls compared to other storytellers, especially so on ones involving combat, destruction, or chaos. \
	The least hectic storyteller of all, while still having some spice. Best for RP-focused rounds with a few events and antags sprinkled in."
	welcome_text = "If you vote for this storyteller on Ice Box, you have no originality."

	track_data = /datum/storyteller_data/tracks/chill

	guarantees_roundstart_crewset = FALSE
	tag_multipliers = list(
		TAG_COMBAT = 0.3,
		TAG_DESTRUCTIVE = 0.3,
		TAG_CHAOTIC = 0.1
	)
	antag_divisor = 32
	storyteller_type = STORYTELLER_TYPE_CALM

/datum/storyteller/chill/New()
	track_data = new /datum/storyteller_data/tracks/chill
	track_data.threshold_mundane *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_mundane_points_threshold_coefficient)
	track_data.threshold_moderate *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_moderate_points_threshold_coefficient)
	track_data.threshold_major *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_major_points_threshold_coefficient)
	track_data.threshold_crewset *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_crewset_points_threshold_coefficient)
	track_data.threshold_ghostset *= CONFIG_GET(number/chill_points_threshold_coefficient) * CONFIG_GET(number/chill_ghostset_points_threshold_coefficient)

/datum/storyteller_data/tracks/chill
	threshold_mundane = 1800
	threshold_moderate = 2700
	threshold_major = 16000
	threshold_crewset = 3200
	threshold_ghostset = 20000

/datum/config_entry/number/chill_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_mundane_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_moderate_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_major_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_crewset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0

/datum/config_entry/number/chill_ghostset_points_threshold_coefficient
	default = 1
	integer = FALSE
	min_val = 0
