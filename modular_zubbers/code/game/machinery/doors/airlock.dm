/obj/machinery/door/airlock/proc/airlock_sound(airlock_state)
	var/list/nearby = get_hearers_in_range(SOUND_RANGE, src)
	for(var/mob/listening_mob in nearby)
		if(!listening_mob || !listening_mob.client)
			continue

		if(listening_mob.client.prefs?.read_preference(/datum/preference/toggle/departmental_airlock_sounds))
			switch(airlock_state)
				if(AIRLOCK_OPENING)
					listening_mob.playsound_local(turf_source = src.loc, soundin = sound_dept_open, vol = 25, vary = FALSE)
				if(AIRLOCK_CLOSING)
					listening_mob.playsound_local(turf_source = src.loc, soundin = sound_dept_close, vol = 25, vary = FALSE)
		else
			switch(airlock_state)
				if(AIRLOCK_OPENING)
					listening_mob.playsound_local(turf_source = src.loc, soundin = doorOpen, vol = 0, vary = TRUE)
				if(AIRLOCK_CLOSING)
					listening_mob.playsound_local(turf_source = src.loc, soundin = doorClose, vol = 30, vary = TRUE)

//replaced with better sounds
/obj/machinery/door/airlock
	sound_dept_open = 'modular_zubbers/sound/machines/door/covert1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/covert1c.ogg'

/obj/machinery/door/airlock/command
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/security
	sound_dept_open = 'modular_zubbers/sound/machines/door/sec1o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/sec1c_2.ogg'

/obj/machinery/door/airlock/engineering
	sound_dept_open = 'modular_zubbers/sound/machines/door/eng1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/eng1c.ogg'

/obj/machinery/door/airlock/medical
	sound_dept_open = 'modular_zubbers/sound/machines/door/med2o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/med2c.ogg'

/obj/machinery/door/airlock/virology
	sound_dept_open = 'modular_zubbers/sound/machines/door/med2o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/med2c.ogg'

/obj/machinery/door/airlock/psych
	sound_dept_open = 'modular_zubbers/sound/machines/door/med2o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/med2c.ogg'

/obj/machinery/door/airlock/maintenance
	sound_dept_open = 'modular_zubbers/sound/machines/door/hall3o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/hall3c.ogg'

/obj/machinery/door/airlock/external
	sound_dept_open = 'modular_zubbers/sound/machines/door/space1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/space1c_2.ogg'

//They are the same because hall1c & hall1o were loud
/obj/machinery/door/airlock/public
	sound_dept_open = 'modular_skyrat/modules/aesthetics/airlock/sound/open.ogg'
	sound_dept_close = 'modular_skyrat/modules/aesthetics/airlock/sound/close.ogg'

/obj/machinery/door/airlock/colony_prefab
	sound_dept_open = 'modular_skyrat/modules/aesthetics/airlock/sound/open.ogg'
	sound_dept_close = 'modular_skyrat/modules/aesthetics/airlock/sound/close.ogg'

/obj/machinery/door/airlock/centcom
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/grunge
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'


/obj/machinery/door/airlock/hatch
	sound_dept_open = 'modular_zubbers/sound/machines/door/hall3o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/hall3c.ogg'

/obj/machinery/door/airlock/maintenance_hatch
	sound_dept_open = 'modular_zubbers/sound/machines/door/hall3o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/hall3c.ogg'

/obj/machinery/door/airlock/atmos
	sound_dept_open = 'modular_zubbers/sound/machines/door/eng1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/eng1c.ogg'

/obj/machinery/door/airlock/research
	sound_dept_open = 'modular_zubbers/sound/machines/door/sci1o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/sci1c_2.ogg'

/obj/machinery/door/airlock/science
	sound_dept_open = 'modular_zubbers/sound/machines/door/sci1o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/sci1c_2.ogg'

/obj/machinery/door/airlock/mining
	sound_dept_open = 'modular_zubbers/sound/machines/door/cgo1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cgo1c.ogg'

/obj/machinery/door/airlock/highsecurity
	sound_dept_open = 'modular_zubbers/sound/machines/door/secure1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/secure1c.ogg'

/obj/machinery/door/airlock/shuttle
	sound_dept_open = 'modular_zubbers/sound/machines/door/shuttle1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/shuttle1c_2.ogg'

/obj/machinery/door/airlock/survival_pod
	sound_dept_open = 'modular_zubbers/sound/machines/door/shuttle1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/shuttle1c_2.ogg'

/obj/machinery/door/airlock/titanium
	sound_dept_open = 'modular_zubbers/sound/machines/door/shuttle1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/shuttle1c_2.ogg'

/obj/machinery/door/airlock/multi_tile
	sound_dept_open = 'modular_skyrat/modules/aesthetics/airlock/sound/open.ogg'
	sound_dept_close = 'modular_skyrat/modules/aesthetics/airlock/sound/close.ogg'

/obj/machinery/door/airlock/captain
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd1c.ogg'

/obj/machinery/door/airlock/corporate
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/hos
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd1o.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd1c.ogg'

/obj/machinery/door/airlock/hop
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/rd
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/qm
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/cmo
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'

/obj/machinery/door/airlock/ce
	sound_dept_open = 'modular_zubbers/sound/machines/door/cmd3o_2.ogg'
	sound_dept_close = 'modular_zubbers/sound/machines/door/cmd3c.ogg'
