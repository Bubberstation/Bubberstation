/proc/get_safe_lucky_player_turf(list/mobs_to_check = GLOB.alive_player_list,list/mobs_to_exclude,list/areas_to_exclude)

	var/list/list_to_check = shuffle(mobs_to_check)
	if(length(mobs_to_exclude))
		list_to_check -= mobs_to_exclude

	if(length(list_to_check))
		for(var/mob/player_mob as anything in list_to_check)

			//Safety bullshit in case of race conditions.
			if(!player_mob || !player_mob.mind || !player_mob.client)
				continue

			//Don't include afk people.
			if(player_mob.client.is_afk())
				continue

			var/datum/job/player_role = player_mob.mind.assigned_role

			//Don't include people who aren't crew.
			if(!(player_role.job_flags & JOB_CREW_MEMBER))
				continue

			//Don't include people who aren't even on the station or doing something "important"
			if(engaged_role_play_check(player_mob, station = TRUE, dorms = TRUE))
				continue

			var/turf/player_turf = get_turf(player_mob)
			if(!player_turf)
				continue //Safety

			var/area/player_area = player_turf.loc

			if(length(areas_to_exclude) && (player_area in areas_to_exclude))
				continue

			var/turf/found_turf = get_safe_random_station_turf(player_area)
			if(!found_turf)
				continue //Safety

			return found_turf

	return get_safe_random_station_turf()
