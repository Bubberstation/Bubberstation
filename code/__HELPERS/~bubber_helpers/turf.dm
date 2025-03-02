/turf/proc/return_turf_delta_p()
	var/pressure_greatest = 0
	var/pressure_smallest = INFINITY //Freaking terrified to use INFINITY, man
	for(var/t in RANGE_TURFS(1, src)) //Begin processing the delta pressure across the wall.
		var/turf/open/turf_adjacent = t
		if(!istype(turf_adjacent))
			continue
		pressure_greatest = max(pressure_greatest, turf_adjacent.air.return_pressure())
		pressure_smallest = min(pressure_smallest, turf_adjacent.air.return_pressure())

	return pressure_greatest - pressure_smallest

///Runs through all adjacent open turfs and checks if any are planetary_atmos returns true if even one passes.
/turf/proc/is_nearby_planetary_atmos()
	. = FALSE
	for(var/t in RANGE_TURFS(1, src))
		if(!isopenturf(t))
			continue
		var/turf/open/turf_adjacent = t
		if(turf_adjacent.planetary_atmos)
			return TRUE
