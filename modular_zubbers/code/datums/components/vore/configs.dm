// Configuration entries for vore system parameters
/datum/config_entry/number/vore_max_bellies
	default = 10
	min_val = 1

/datum/config_entry/number/vore_max_prey
	default = 3
	min_val = 1

/datum/config_entry/number/vore_delay
	default = 4 SECONDS
	min_val = 1

/datum/config_entry/number/vore_eject_delay
	default = 2 SECONDS
	min_val = 1

/datum/config_entry/number/vore_max_belly_layouts
	default = 20
	min_val = 1

/datum/config_entry/number/vore_max_burn_damage
	default = 2.5
	integer = FALSE
	min_val = 0

/datum/config_entry/number/vore_max_brute_damage
	default = 2.5
	integer = FALSE
	min_val = 0

/datum/config_entry/number/vore_min_escape_time
	default = 2 SECONDS
	integer = FALSE
	min_val = 1

/datum/config_entry/number/vore_default_escape_time
	default = 15 SECONDS
	integer = FALSE
	min_val = 1

/datum/config_entry/number/vore_max_escape_time
	default = 60 SECONDS
	integer = FALSE
	min_val = 1

/datum/config_entry/number/vore_max_verb_length
	default = 20
	min_val = 1

/datum/config_entry/number/vore_max_message_length
	default = 160
	min_val = 1

/datum/config_entry/number/vore_min_message_length
	default = 10
	min_val = 1

/datum/config_entry/flag/vore_matryoshka_banned

/datum/config_entry/flag/vore_disables_sensors

/datum/config_entry/flag/vore_no_dead

/datum/config_entry/flag/vore_requires_player
