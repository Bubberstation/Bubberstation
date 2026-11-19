/// list of dorms areas for doing event checks
GLOBAL_LIST_EMPTY(dorms_areas)

/area/station/commons/dorms/New()
	. = ..()
	GLOB.dorms_areas[src] = TRUE

/datum/weather/proc/engaged_roleplay_filter(area/engaged_roleplay_area)
	return FALSE

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
