/obj/docking_port/mobile
	/// Does this shuttle play sounds upon landing and takeoff?
	var/shuttle_sounds = TRUE
	/// The take off sound to be played
	var/takeoff_sound = sound('modular_skyrat/modules/advanced_shuttles/sound/engine_startup.ogg')
	/// The landing sound to be played
	var/landing_sound = sound('modular_skyrat/modules/advanced_shuttles/sound/engine_landing.ogg')
	/// The sound range coeff for the landing and take off sound effect
	var/sound_range = 20

	var/list/all_extensions = list()
	var/list/engine_extensions = list()

	var/overmap_shuttle_type = /datum/overmap_object/shuttle

	/// The direction override that overmap objects representing this shuttle apply to it. Needs to be tracked seperately to the old method because shuttles should work fine without overmap objects. Null means not overriden, direction means it is (with 0 being stop)
	var/overmap_parallax_dir

	///Can this shuttle be called while it's in transit? (Prevents people recalling it once it's already enroute)
	var/can_be_called_in_transit = TRUE

	var/admin_forced = FALSE

	var/gateway_stranded = FALSE


//call the shuttle to destination target_dock
/obj/docking_port/mobile/proc/request(obj/docking_port/stationary/target_dock, forced = FALSE)
	if(!check_dock(target_dock) && !forced)
		testing("check_dock failed on request for [src]")
		return

	if(forced)
		admin_forced = TRUE

	if(mode == SHUTTLE_IGNITING && destination == target_dock)
		return

	switch(mode)
		if(SHUTTLE_CALL)
			if(!can_be_called_in_transit)
				return
			if(target_dock == destination)
				if(timeLeft(1) < callTime * engine_coeff)
					setTimer(callTime * engine_coeff)
			else
				destination = target_dock
				setTimer(callTime * engine_coeff)
		if(SHUTTLE_RECALL)
			if(!can_be_called_in_transit) //SKYRAT EDIT ADDITION
				return
			if(target_dock == destination)
				setTimer(callTime * engine_coeff - timeLeft(1))
			else
				destination = target_dock
				setTimer(callTime * engine_coeff)
			mode = SHUTTLE_CALL
		if(SHUTTLE_IDLE, SHUTTLE_IGNITING)
			destination = target_dock
			mode = SHUTTLE_IGNITING
			bolt_all_doors()
			play_engine_sound(src, TRUE) //SKYRAT EDIT ADDITION
			setTimer(ignitionTime)


/obj/docking_port/mobile/proc/bolt_all_doors() // Expensive procs :(
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]
		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			if(airlock_door.external)
				airlock_door.close(force_crush = TRUE)
				airlock_door.bolt()

/obj/docking_port/mobile/proc/unbolt_all_doors()
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]
		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			if(airlock_door.external)
				airlock_door.unbolt()

/obj/docking_port/mobile/proc/play_engine_sound(atom/distant_source, takeoff)
	if(distant_source)
		for(var/mob/hearing_mob in range(sound_range, distant_source))
			if(hearing_mob?.client)
				var/dist = get_dist(hearing_mob.loc, distant_source.loc)
				var/vol = clamp(50 - ((dist - 7) * 5), 10, 50) // Every tile decreases sound volume by 5
				if(takeoff)
					if(hearing_mob.client?.prefs?.read_preference(/datum/preference/toggle/sound_ship_ambience))
						hearing_mob.playsound_local(distant_source, takeoff_sound, vol)
				else
					if(hearing_mob.client?.prefs?.read_preference(/datum/preference/toggle/sound_ship_ambience))
						hearing_mob.playsound_local(distant_source, landing_sound, vol)

/obj/docking_port/mobile/proc/DrawDockingThrust()
	var/drawn_power = 0
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		if(!ext.turned_on)
			continue
		drawn_power += ext.DrawThrust(5)

	if(drawn_power > 1)
		return TRUE
	else
		return FALSE

/obj/docking_port/mobile/proc/TurnEnginesOn()
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		ext.turned_on = TRUE

/obj/docking_port/mobile/proc/TurnEnginesOff()
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		ext.turned_on = FALSE
