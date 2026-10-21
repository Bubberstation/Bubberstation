/datum/weather/rad_storm
	end_duration = 3 SECONDS
	telegraph_message = span_userdanger("The air begins to grow warm.")
	var/maint_flipped = FALSE

/datum/weather/rad_storm/New(...)
	LAZYOR(protected_areas, list(
		/area/station/terminal,
		/area/lavaland,
		/area/ruin,
		/area/moonstation/underground,
		/area/station/cargo/miningelevators,
		/area/station/cargo/miningfoundry/event_protected,
		/area/loopstation/radshelter,
		/area/ruin/unpowered/primitive_catgirl_den,
		/area/ruin/space/has_grav/bubbers/dauntless,
		/area/ruin/space/has_grav/bubbers/dauntless_space,
		/area/ruin/space/has_grav/bubbers/persistance,
	))
	. = ..()

/datum/weather/rad_storm/telegraph()
	. = ..()
	if(!GLOB.emergency_access)
		maint_flipped = TRUE
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(make_maint_all_access), TRUE), 0.5 SECONDS) // timed to match the status display

/datum/weather/rad_storm/end()
	. = ..()
	if(maint_flipped)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(revoke_maint_all_access), FALSE), 45 SECONDS)

/datum/weather/rad_storm/engaged_roleplay_filter(area/engaged_roleplay_area)
	if(!is_type_in_list(engaged_roleplay_area, GLOB.dorms_areas))
		return FALSE

	for(var/mob/living/carbon/human/roleplayer in engaged_roleplay_area.contents)
		if(engaged_role_play_check(player = roleplayer, station = FALSE, dorms = TRUE))
			return TRUE

	return FALSE

/datum/weather/rad_storm/send_alert(alert_msg, alert_sfx, alert_sfx_vol = 100)
	for(var/area/impacted_area as anything in impacted_areas)
		for(var/mob/living/player in impacted_area.contents)
			if(!can_get_alert(player))
				continue
			if(alert_msg)
				to_chat(player, alert_msg)

	if(!alert_sfx)
		return

	for(var/z_level in impacted_z_levels)
		for(var/mob/player as anything in SSmobs.clients_by_zlevel[z_level])
			if(!can_get_alert(player))
				continue
			if(alert_sfx)
				player.stop_sound_channel(CHANNEL_WEATHER)
				SEND_SOUND(player, sound(alert_sfx, channel = CHANNEL_WEATHER, volume = alert_sfx_vol))
