/turf/closed/wall/update_overlays()
	. = ..()
	if(dent_decals)
		add_overlay(dent_decals)
	return .
