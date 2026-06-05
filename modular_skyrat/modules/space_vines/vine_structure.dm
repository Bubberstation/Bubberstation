/obj/structure/spacevine
	/// Whether the plant has a decreased chance of being destroyed by plant-b-gone
	var/plantbgone_resist = FALSE
	/// Next world.time at which this vine may attempt to force open a door
	var/next_pry_attempt = 0

/datum/spacevine_controller
	/// Quality flags (POSITIVE, NEGATIVE, MINOR_NEGATIVE) banned from evolving naturally on this cluster.
	var/list/banned_qualities = list()

/obj/structure/spacevine/proc/get_pryable_door(turf/target)
	var/obj/machinery/door/airlock/door = locate() in target
	if(!door?.density)
		return null
	var/datum/gas_mixture/other_side = target.return_air()
	if(!other_side || other_side.return_pressure() < HAZARD_LOW_PRESSURE)
		return null
	return door

/obj/structure/spacevine/proc/pry_door(obj/machinery/door/airlock/door)
	next_pry_attempt = world.time + 30 SECONDS
	playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
	visible_message(span_warning("The vines force [door] open!"))
	door.welded = FALSE
	door.set_bolt(FALSE)
	door.autoclose = FALSE
	door.open(BYPASS_DOOR_CHECKS)
	door.obj_flags |= EMAGGED
	door.feedback = FALSE
	door.locked = TRUE
	door.loseMainPower()
	door.loseBackupPower()
