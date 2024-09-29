/turf/open/AfterChange(flags, oldType)
	. = ..()
	//This makes it so that turfs will NOT create planetary atmos if it's indoors.
	if(oldType && src.planetary_atmos && (flags & (CHANGETURF_IGNORE_AIR | CHANGETURF_INHERIT_AIR)))
		var/area/turf_area = src.loc
		if(!turf_area.outdoors)
			src.planetary_atmos = FALSE
