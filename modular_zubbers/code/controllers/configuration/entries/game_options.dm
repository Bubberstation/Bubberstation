/// Offsets the station time (in minutes) compared to the system clock
/datum/config_entry/number/shift_time_clock_offset
	default = 0
	min_val = 0
	max_val = 1439

/// Minutes a citation can go unpaid before it elevates to fine evasion. 0 disables it.
/datum/config_entry/number/fine_evasion_minutes
	default = 10
	integer = TRUE
	min_val = 0
