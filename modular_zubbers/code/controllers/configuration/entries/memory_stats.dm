// BUBBER EDIT ADDITION -- memory logging subsystem

/datum/config_entry/flag/enable_memory_stats

/datum/config_entry/flag/enable_memory_stats/ValidateAndSet(str_val)
	. = ..()
	if(.)
		SSmemory_stats?.can_fire = config_entry_value

/datum/config_entry/flag/enable_memory_stats/vv_edit_var(var_name, var_value)
	. = ..()
	if(. && var_name == NAMEOF(src, config_entry_value))
		SSmemory_stats?.can_fire = config_entry_value
