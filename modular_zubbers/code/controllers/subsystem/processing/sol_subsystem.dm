

PROCESSING_SUBSYSTEM_DEF(sunlight)
	name = "Sol"
	can_fire = FALSE
	runlevels = RUNLEVEL_GAME
	wait = 2 SECONDS
	flags = SS_NO_INIT | SS_KEEP_TIMING | SS_TICKER

	///If the Sun is currently out our not.
	var/sunlight_active = FALSE
	///The time between the next cycle, randomized every night.
	var/time_til_cycle = TIME_BLOODSUCKER_NIGHT_MAX
	///If Bloodsucker levels for the night has been given out yet.
	var/issued_XP = FALSE
	/// Mobs that make use of the sunlight system.
	var/list/sun_sufferers = list()

/datum/controller/subsystem/processing/sunlight/fire(resumed = FALSE)
	time_til_cycle--
	if(sunlight_active)
		if(time_til_cycle > 0)
			SEND_SIGNAL(src, COMSIG_SOL_RISE_TICK)
			if(!issued_XP && time_til_cycle <= 15)
				issued_XP = TRUE
				SEND_SIGNAL(src, COMSIG_SOL_RANKUP_BLOODSUCKERS)
		if(time_til_cycle <= 1)
			sunlight_active = FALSE
			issued_XP = FALSE
			//randomize the next sol timer
			time_til_cycle = rand(TIME_BLOODSUCKER_NIGHT_MIN, TIME_BLOODSUCKER_NIGHT_MAX)
			message_admins("BLOODSUCKER NOTICE: Daylight Ended. Resetting to Night (Lasts for [time_til_cycle / 60] minutes.")
			SEND_SIGNAL(src, COMSIG_SOL_END)
			warn_daylight(
				danger_level = DANGER_LEVEL_SOL_ENDED,
				vampire_warning_message = span_announce("The solar flare has ended, and the daylight danger has passed... for now."),
				vassal_warning_message = span_announce("The solar flare has ended, and the daylight danger has passed... for now."),
			)
		return ..()

	switch(time_til_cycle)
		if(TIME_BLOODSUCKER_DAY_WARN)
			SEND_SIGNAL(src, COMSIG_SOL_NEAR_START)
			warn_daylight(
				danger_level = DANGER_LEVEL_FIRST_WARNING,
				vampire_warning_message = span_danger("Solar Flares will bombard the station with dangerous UV radiation in [TIME_BLOODSUCKER_DAY_WARN / 60] minutes. <b>Prepare to seek cover in a coffin or closet.</b>"),
			)
		if(TIME_BLOODSUCKER_DAY_FINAL_WARN)
			message_admins("BLOODSUCKER NOTICE: Daylight beginning in [TIME_BLOODSUCKER_DAY_FINAL_WARN] seconds.)")
			warn_daylight(
				danger_level = DANGER_LEVEL_SECOND_WARNING,
				vampire_warning_message = span_userdanger("Solar Flares are about to bombard the station! You have [TIME_BLOODSUCKER_DAY_FINAL_WARN] seconds to find cover!"),
				vassal_warning_message = span_danger("In [TIME_BLOODSUCKER_DAY_FINAL_WARN] seconds, your master will be at risk of a Solar Flare. Make sure they find cover!"),
			)
		if(TIME_BLOODSUCKER_BURN_INTERVAL)
			warn_daylight(
				danger_level = DANGER_LEVEL_THIRD_WARNING,
				vampire_warning_message = span_userdanger("Seek cover, for Sol rises!"),
			)
		if(NONE)
			sunlight_active = TRUE
			//set the timer to countdown daytime now.
			time_til_cycle = TIME_BLOODSUCKER_DAY
			message_admins("BLOODSUCKER NOTICE: Daylight Beginning (Lasts for [TIME_BLOODSUCKER_DAY / 60] minutes.)")
			warn_daylight(
				danger_level = DANGER_LEVEL_SOL_ROSE,
				vampire_warning_message = span_userdanger("Solar flares bombard the station with deadly UV light! Stay in cover for the next [TIME_BLOODSUCKER_DAY / 60] minutes or risk Final Death!"),
				vassal_warning_message = span_userdanger("Solar flares bombard the station with UV light!"),
			)
	..()

/datum/controller/subsystem/processing/sunlight/proc/warn_daylight(danger_level, vampire_warning_message, vassal_warning_message)
	SEND_SIGNAL(src, COMSIG_SOL_WARNING_GIVEN, danger_level, vampire_warning_message, vassal_warning_message)


/datum/controller/subsystem/processing/sunlight/proc/add_sun_sufferer(mob/victim)
	var/sufferer_list = is_sufferer(victim)
	if(sufferer_list)
		return FALSE
	var/atom/movable/screen/bloodsucker/sunlight_counter/sun_hud = new(null, victim.hud_used)
	victim.hud_used.infodisplay += sun_hud
	victim.hud_used.show_hud(victim.hud_used.hud_version)
	sun_hud.update_sol_hud()
	sun_sufferers += list(list("victim" = WEAKREF(victim), "sun_hud" = sun_hud))
	if(length(sun_sufferers))
		can_fire = TRUE

	return TRUE

/datum/controller/subsystem/processing/sunlight/proc/remove_sun_sufferer(mob/victim)
	var/sufferer_list = is_sufferer(victim)
	if(!sufferer_list)
		return FALSE
	var/atom/movable/screen/bloodsucker/sunlight_counter/sun_hud = sufferer_list["sun_hud"]
	if(sun_hud)
		victim?.hud_used.infodisplay -= sun_hud
		qdel(sun_hud)
	// We have to use the index here as -= won't work with two lists
	sun_sufferers.Cut(sufferer_list["index"])
	if(!length(sun_sufferers))
		can_fire = FALSE
		sunlight_active = initial(sunlight_active)
		time_til_cycle = initial(time_til_cycle)
		issued_XP = initial(issued_XP)
	return TRUE

/datum/controller/subsystem/processing/sunlight/proc/warn_notify(mob/target, danger_level, message)
	if(!target)
		return
	to_chat(target, message)

	switch(danger_level)
		if(DANGER_LEVEL_FIRST_WARNING)
			target.playsound_local(null, 'modular_zubbers/sound/bloodsucker/griffin_3.ogg', 50, TRUE)
		if(DANGER_LEVEL_SECOND_WARNING)
			target.playsound_local(null, 'modular_zubbers/sound/bloodsucker/griffin_5.ogg', 50, TRUE)
		if(DANGER_LEVEL_THIRD_WARNING)
			target.playsound_local(null, 'sound/effects/alert.ogg', 75, TRUE)
		if(DANGER_LEVEL_SOL_ROSE)
			target.playsound_local(null, 'sound/ambience/ambimystery.ogg', 75, TRUE)
		if(DANGER_LEVEL_SOL_ENDED)
			target.playsound_local(null, 'sound/misc/ghosty_wind.ogg', 90, TRUE)


/datum/controller/subsystem/processing/sunlight/proc/is_sufferer(mob/victim)
	for(var/i in 1 to length(sun_sufferers))
		var/list/sufferers_original = sun_sufferers[i]
		var/list/sufferer_list = sufferers_original?.Copy()
		if(!sufferer_list)
			continue
		sufferer_list["index"] = i
		var/datum/weakref/sufferer_ref = sufferer_list["victim"]
		if(!sufferer_ref)
			continue
		var/sufferer = sufferer_ref.resolve()
		if(sufferer == victim)
			return sufferer_list
	return null
