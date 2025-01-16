/// Returns true if the map we're playing on is on a planet, but it DOES have space access.
/datum/controller/subsystem/mapping/proc/is_planetary_with_space()
	return is_planetary() && current_map.allow_space_when_planetary


/datum/map_config
	/// Are we allowing space even if we're planetary?
	var/allow_space_when_planetary = FALSE
