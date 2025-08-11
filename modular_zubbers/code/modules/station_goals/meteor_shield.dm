/obj/machinery/satellite/meteor_shield/emag_act(mob/user, obj/item/card/emag/emag_card)

	if(obj_flags & EMAGGED)
		balloon_alert(user, "already emagged!")
		return FALSE
	if(!COOLDOWN_FINISHED(src, shared_emag_cooldown))
		balloon_alert(user, "on cooldown!")
		to_chat(user, span_warning("The last satellite emagged needs [DisplayTimeText(COOLDOWN_TIMELEFT(src, shared_emag_cooldown))] to recalibrate first. Emagging another so soon could damage the satellite network."))
		return FALSE

	COOLDOWN_START(src, shared_emag_cooldown, 1 MINUTES)

	obj_flags |= EMAGGED

	playsound(loc, 'sound/machines/warning-buzzer.ogg', 75, TRUE)
	to_chat(user, span_notice("You access the satellite's debug mode and it begins emitting a strange signal..."))
	to_chat(user, span_danger("The meteor shield buzzes! You should probably run away!"))

	addtimer(CALLBACK(src, PROC_REF(rod_from_god_climax)), 4 SECONDS, TIMER_UNIQUE)
	addtimer(CALLBACK(src, PROC_REF(rod_from_god_clarity)), 16 SECONDS, TIMER_UNIQUE)

/obj/machinery/satellite/meteor_shield/proc/rod_from_god_climax()

	var/turf/target_turf = get_turf(src)

	var/start_side = 0x0
	if(target_turf.x >= 128) //Closer to the east
		start_side |= WEST
	else
		start_side |= EAST

	if(target_turf.y >= 128) //Closer to the north
		start_side |= SOUTH
	else
		start_side |= NORTH

	if(!target_turf) // Was probably deleted.
		return

	target_turf = get_step(target_turf,turn(start_side,pick(-90,90))) //So we don't hit the meteor sat. Probably. Maybe.
	priority_announce("What the fuck is that?!", "General Alert")
	var/turf/start_turf = spaceDebrisStartLoc(start_side, target_turf.z)
	var/turf/end_turf = spaceDebrisFinishLoc(start_side, target_turf.z)
	new /obj/effect/immovablerod(start_turf, end_turf, target_turf, FALSE)

/obj/machinery/satellite/meteor_shield/proc/rod_from_god_clarity()
	priority_announce(
		"It appears a meteor point-defense satellite was tampered with, and may or may not have attracted an elongated object. Please check your GPSs to resolve the issue.",
		"Clarification on what the fuck that was."
	)

/obj/machinery/satellite/meteor_shield/update_emagged_meteor_sat()
	return

/obj/machinery/satellite/meteor_shield/handle_new_emagged_shield_threshold()
	return

/obj/machinery/satellite/meteor_shield/change_meteor_chance(mod)
	return
