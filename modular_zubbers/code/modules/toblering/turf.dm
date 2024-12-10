/turf
	/// You may be wondering why I'm putting this on turf.
	/// Windows.
	var/lighting_uses_jen = FALSE

/turf/set_smoothed_icon_state(new_junction)
	. = ..()

	if(smoothing_junction != .) //The smoothing changed
		lighting_object?.update()
