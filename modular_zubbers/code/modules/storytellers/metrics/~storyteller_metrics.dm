/datum/storyteller_metric
	var/name = "Generic check"


/datum/storyteller_metric/proc/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return TRUE


/datum/storyteller_metric/proc/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	set waitfor = FALSE

	SHOULD_CALL_PARENT(TRUE)
	if(anl)
		anl.try_stop_analyzing(src)


/datum/storyteller_metric/proc/get_alive_crew(only_humans = TRUE, only_station = TRUE, only_with_mind = TRUE, no_afk = TRUE)
	var/list/to_check = SSstorytellers.simulation ? GLOB.alive_mob_list : GLOB.alive_player_list
	if(!length(to_check))
		return list()

	var/list/result
	for(var/mob/living/L as anything in to_check)
		if(only_humans && !(ishuman(L)))
			continue
		if(only_station && !is_station_level(L.z))
			continue
		if(only_with_mind && !L.mind)
			continue
		if(L.client && L?.client.is_afk())
			continue
		LAZYADD(result, L)
	return result

/datum/storyteller_metric/proc/get_dead_crew(only_humans = TRUE, only_station = TRUE, only_with_mind = TRUE)
	var/list/to_check = SSstorytellers.simulation ? GLOB.dead_mob_list : GLOB.dead_mob_list
	if(!length(to_check))
		return list()

	var/list/result
	for(var/mob/living/L as anything in to_check)
		if(only_humans && !(ishuman(L)))
			continue
		if(only_station && !is_station_level(L.z))
			continue
		if(only_with_mind && !L.mind)
			continue
		LAZYADD(result, L)
	return result
