//Body size configs, the feature will be disabled if both min and max have the same value.
/datum/config_entry/number/body_size_min
	default = 0.8
	min_val = 0.1 //to avoid issues with zeros and negative values.
	max_val = RESIZE_DEFAULT_SIZE
	integer = FALSE

/datum/config_entry/number/body_size_max
	default = 1.5
	min_val = RESIZE_DEFAULT_SIZE
	integer = FALSE

/datum/config_entry/number/body_size_slowdown_multiplier
	default = 0
	min_val = 0
	integer = FALSE

/datum/config_entry/number/macro_health_cap
	default = 3.5 //21 ft
	integer = FALSE
