/obj/structure/spacevine
	/// Whether the plant has a decreased chance of being destroyed by plant-b-gone
	var/plantbgone_resist = FALSE
	/// Next world.time at which this vine may attempt to force open a door
	var/next_pry_attempt = 0

/datum/spacevine_controller
	/// Quality flags (POSITIVE, NEGATIVE, MINOR_NEGATIVE) banned from evolving naturally on this cluster.
	var/list/banned_qualities = list()

/obj/structure/spacevine/proc/get_pryable_door()
	var/obj/machinery/door/airlock/candidate_door
	for(var/dir in GLOB.cardinals)
		var/turf/stepturf = get_step(src, dir)
		if(!stepturf)
			continue
		if(is_space_or_openspace(stepturf))
			continue
		if(stepturf.Enter(src))
			return null
		var/obj/machinery/door/airlock/door = locate() in stepturf
		if(door?.density && !candidate_door)
			var/datum/gas_mixture/other_side = stepturf.return_air()
			if(other_side?.return_pressure() >= HAZARD_LOW_PRESSURE)
				candidate_door = door
	return candidate_door

/obj/structure/spacevine/proc/pry_door(obj/machinery/door/airlock/door)
	next_pry_attempt = world.time + 30 SECONDS
	playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
	visible_message(span_warning("The vines force [door] open!"))
	door.open(BYPASS_DOOR_CHECKS)
	door.take_damage(AIRLOCK_PRY_DAMAGE, BRUTE, 0, 0)
	QDEL_NULL(door.electronics)
