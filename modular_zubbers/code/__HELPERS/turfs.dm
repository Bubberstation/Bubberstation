///Returns a random turf on the station, excludes dense turfs (like walls) and areas that have valid_territory set to FALSE
/proc/get_safe_random_station_turf_light(list/areas_to_pick_from = GLOB.the_station_areas,minimum_lightness = 0.5)
	for (var/i in 1 to 5)
		var/list/turf_list = get_area_turfs(pick(areas_to_pick_from))
		var/turf/target
		while (turf_list.len && !target)
			var/I = rand(1, turf_list.len)
			var/turf/checked_turf = turf_list[I]
			if(checked_turf.get_lumcount() <= minimum_lightness)
				turf_list.Cut(I, I + 1)
				continue
			var/area/turf_area = get_area(checked_turf)
			if(!checked_turf.density && (turf_area.area_flags & VALID_TERRITORY) && !isgroundlessturf(checked_turf))
				var/clear = TRUE
				for(var/obj/checked_object in checked_turf)
					if(checked_object.density)
						clear = FALSE
						break
				if(clear)
					target = checked_turf
			if (!target)
				turf_list.Cut(I, I + 1)
		if (target)
			return target