/datum/config_entry/flag/hilbertshotel_enabled
	default = TRUE

/datum/config_entry/number/hilbertshotel_max_rooms
	default = 100

/datum/config_entry/number/hilbertshotel_max_rooms/ValidateAndSet(str_val)
	. = ..()
	if(!.)
		return

	if (config_entry_value < 0)
		config_entry_value = INFINITY

/datum/config_entry/flag/hilbertshotel_ghost_cafe_restricted
