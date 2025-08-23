/// list of dorms areas for doing event checks
GLOBAL_LIST_EMPTY(dorms_areas)

/area/station/commons/dorms/New()
	. = ..()
	GLOB.dorms_areas[src] = TRUE

/datum/weather/proc/enhanced_roleplay_filter(list/affectareas)
	return affectareas

/datum/weather/rad_storm/enhanced_roleplay_filter(list/affectareas)
	var/list/filtered_areas = affectareas
	for(var/area/engaged_roleplay_area as anything in GLOB.dorms_areas)
		for(var/mob/living/carbon/human/roleplayer in engaged_roleplay_area.contents)
			if(engaged_role_play_check(player = roleplayer, station = FALSE, dorms = TRUE))
				LAZYREMOVE(filtered_areas, engaged_roleplay_area)
				break
	return filtered_areas

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

/**
 * Checks if a player meets certain conditions to exclude them from event selection.
 */
/proc/engaged_role_play_check(mob/player, station = TRUE, dorms = TRUE)

	var/turf/player_turf = get_turf(player)

	if(station && !is_station_level(player_turf.z))
		return TRUE

	if(player_turf && dorms && length(GLOB.dorms_areas))
		var/area/player_area = player_turf.loc
		if(GLOB.dorms_areas[player_area])
			return TRUE

	return FALSE
