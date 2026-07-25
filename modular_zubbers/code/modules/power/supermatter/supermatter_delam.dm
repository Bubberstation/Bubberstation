/obj/machinery/power/supermatter_crystal
	COOLDOWN_DECLARE(emergency_stationwide_cooldown)
	COOLDOWN_DECLARE(emergency_local_cooldown)

/datum/sm_delam/proc/delam_alarm_sounds(obj/machinery/power/supermatter_crystal/sm)
	var/main_engine = sm.is_main_engine
	if(!main_engine)
		var/area/sm_area = get_area(sm)
		if(istype(sm_area, /area/station/engineering/supermatter))
			main_engine = TRUE

	switch(sm.get_status())
		if(SUPERMATTER_NOTIFY) //a bit bad
			playsound(sm, 'sound/machines/terminal/terminal_alert.ogg', 100, FALSE, 7, 4, falloff_distance = 7)

		if(SUPERMATTER_WARNING) //kinda bad
			playsound(sm, 'sound/machines/terminal/terminal_alert.ogg', 100, FALSE, 7, 4, falloff_distance = 7)

		if(SUPERMATTER_DANGER) //bad
			playsound(sm, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE, 45, 14, falloff_distance = 15)

		if(SUPERMATTER_EMERGENCY) //very bad
			if(main_engine)
				if(COOLDOWN_FINISHED(sm, emergency_stationwide_cooldown))
					alert_sound_to_playing('modular_skyrat/master_files/sound/effects/reactor/core_overheating.ogg')
					COOLDOWN_START(sm, emergency_stationwide_cooldown, 4 MINUTES)
					return
				if(COOLDOWN_FINISHED(sm, emergency_local_cooldown))
					playsound(sm, 'sound/machines/engine_alert/engine_alert2.ogg', 100, FALSE, 70, 7, falloff_distance = 30)
					COOLDOWN_START(sm, emergency_local_cooldown, 80 SECONDS)
					return

			playsound(sm, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE, 45, 14, falloff_distance = 15)

		if(SUPERMATTER_DELAMINATING) //less than ideal
			// we don't play the skyrat sound on the process loop, since it's long as hell we want it played at the right moment
			playsound(sm, 'sound/machines/engine_alert/engine_alert1.ogg', 100, FALSE, 45, 14, falloff_distance = 15)

/// Plays the long meltdown message if it's the main engine going kaboom
/obj/machinery/power/supermatter_crystal/proc/final_announcement()
	var/area/sm_area = get_area(src)
	var/main_engine = is_main_engine || istype(sm_area, /area/station/engineering/supermatter)
	if(!main_engine)
		return

	alert_sound_to_playing('sound/announcer/alarm/bloblarm.ogg')
	sleep(12 SECONDS)
	alert_sound_to_playing('modular_skyrat/master_files/sound/effects/reactor/meltdown.ogg')
	sleep(3 SECONDS)
	for(var/mob/mobs as anything in GLOB.mob_list)
		var/turf/mob_turf = get_turf(mobs)
		if(!istype(mob_turf))
			continue
		if(!is_station_level(mob_turf.z))
			continue
		if(mobs.client)
			shake_camera(M = mobs, duration = 1.5 SECONDS, strength = 1.5)
