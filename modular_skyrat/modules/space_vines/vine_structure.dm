/obj/structure/spacevine
	layer = SPACEVINE_LAYER
	/// Whether the plant has a decreased chance of being destroyed by plant-b-gone
	var/plantbgone_resist = FALSE
	/// Next world.time at which this vine may attempt to force open a door
	var/next_pry_attempt = 0

/datum/spacevine_controller
	/// Quality defines (POSITIVE, NEGATIVE, MINOR_NEGATIVE) whose mutations are weighted down when evolving on this cluster
	var/list/banned_qualities = list()
	/// Last world.time this cluster successfully spread to a new tile
	var/last_spread_time = 0

/obj/structure/spacevine/proc/pry_door(obj/machinery/door/airlock/door)
	next_pry_attempt = world.time + SPACEVINE_PRY_COOLDOWN
	playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
	visible_message(span_warning("The vines force [door] open!"))
	addtimer(CALLBACK(door, TYPE_PROC_REF(/obj/machinery/door/airlock, finish_vine_pry), master, src), SPACEVINE_PRY_DELAY)

/obj/machinery/door/airlock/proc/finish_vine_pry(datum/spacevine_controller/vine_master, obj/structure/spacevine/prying_vine)
	if(QDELETED(src))
		return
	welded = FALSE
	set_bolt(FALSE)
	autoclose = FALSE
	open(BYPASS_DOOR_CHECKS)
	obj_flags |= EMAGGED
	feedback = FALSE
	locked = TRUE
	loseMainPower()
	loseBackupPower()
	if(!QDELETED(vine_master) && !QDELETED(prying_vine))
		vine_master.spawn_spacevine_piece(loc, prying_vine)

/// pull-based atmos check; TURF_EXPOSE never fires on settled or unsimulated tiles.
/// Returns FALSE if heat should destroy this vine; the caller handles deletion so controller lists aren't mutated mid-iteration.
/obj/structure/spacevine/proc/check_atmos_viability()
	var/turf/open/our_turf = loc
	if(!istype(our_turf))
		return TRUE
	var/datum/gas_mixture/air = our_turf.return_air()
	var/current_temp = air ? air.temperature : TCMB
	if(current_temp > FIRE_MINIMUM_TEMPERATURE_TO_SPREAD && !(trait_flags & SPACEVINE_HEAT_RESISTANT))
		return FALSE
	can_spread = !(current_temp < VINE_FREEZING_POINT && !(trait_flags & SPACEVINE_COLD_RESISTANT))
	return TRUE

/// Returns TRUE if glass or a full-tile door blocks a vine moving from its own turf into target along move_dir.
/// Windows and windoors only block from the side they face; airlocks are handled separately by the spread scan.
/obj/structure/spacevine/proc/vine_passage_blocked(turf/target, move_dir)
	for(var/obj/structure/window/window in loc)
		if(window.fulltile || window.dir == move_dir)
			return TRUE
	for(var/obj/machinery/door/window/exit_windoor in loc)
		if(exit_windoor.density && exit_windoor.dir == move_dir)
			return TRUE
	for(var/obj/structure/window/window in target)
		if(window.fulltile || window.dir == REVERSE_DIR(move_dir))
			return TRUE
	for(var/obj/machinery/door/blocking_door in target)
		if(!blocking_door.density)
			continue
		if(istype(blocking_door, /obj/machinery/door/airlock))
			continue
		if(istype(blocking_door, /obj/machinery/door/window))
			var/obj/machinery/door/window/entry_windoor = blocking_door
			if(entry_windoor.dir == REVERSE_DIR(move_dir))
				return TRUE
			continue
		return TRUE // shutters, poddoors, and any other full-tile door
	return FALSE
