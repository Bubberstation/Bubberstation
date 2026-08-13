// BUBBER EDIT ADDITION -- memory logging subsystem, ported from Rotwood-Vale/Ratwood-2.0 #2136 and #2226

/// Disables periodic memory usage logging (SSmemory_stats) and the statpanel memory readout.
/// Absent = enabled.
/datum/config_entry/flag/enable_memory_stats

/datum/config_entry/flag/enable_memory_stats/ValidateAndSet(str_val)
	. = ..()
	if(.)
		SSmemory_stats?.can_fire = !config_entry_value

/datum/config_entry/flag/enable_memory_stats/vv_edit_var(var_name, var_value)
	. = ..()
	if(. && var_name == NAMEOF(src, config_entry_value))
		SSmemory_stats?.can_fire = !config_entry_value
