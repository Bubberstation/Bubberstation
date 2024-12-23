/obj/item/flatpack/mailsorter
	name = "mail sorter flatpack"

/datum/area_spawn/mailsorter
	target_areas = list(/area/station/cargo/office)
	desired_atom = /obj/item/flatpack/mailsorter

/datum/area_spawn/mailsorter/try_spawn()
	// Turfs that are available
	var/list/available_turfs

	for(var/area_type in target_areas)
		var/area/found_area = GLOB.areas_by_type[area_type]
		if(!found_area)
			continue
		available_turfs = SSarea_spawn.get_turf_candidates(found_area, mode)
		if(LAZYLEN(available_turfs))
			break

	if(!LAZYLEN(available_turfs))
		return

	for(var/i in 1 to amount_to_spawn)
		var/turf/candidate_turf = SSarea_spawn.pick_turf_candidate(available_turfs)
		var/final_desired_atom = desired_atom
		new final_desired_atom(candidate_turf)
