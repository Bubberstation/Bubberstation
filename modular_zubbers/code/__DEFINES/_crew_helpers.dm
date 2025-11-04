/proc/get_alive_station_crew(ignore_erp = TRUE, ignore_afk = TRUE, only_crew = TRUE, sort = TRUE)
	var/to_check = GLOB.alive_player_list.Copy()

	if(!length(to_check))
		return list()
	var/list/to_return = null

	for(var/mob/living/living in to_check)
		if(!living.mind)
			continue
		if(!is_station_level(living.z))
			continue
		if(ignore_erp && engaged_role_play_check(living))
			continue
		if(ignore_afk && living?.client)
			if(living.client.is_afk())
				continue
		if(only_crew && !living.mind?.assigned_role)
			continue
		LAZYADD(to_return, living)

	if(sort)
		for(var/i = 0 to rand(1, 3))
			shuffle(to_return)

	return to_return
