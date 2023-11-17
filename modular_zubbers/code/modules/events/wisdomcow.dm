/datum/round_event/wisdomcow/start()
	if(prob(80)) //20% chance to run the new and improved wisdom cow
		return ..()
	var/turf/targetloc
	if(spawn_location)
		targetloc = spawn_location
	else
		targetloc = get_safe_random_station_turf()
	var/mob/living/basic/cow/wisdom/dril/wise = new(targetloc, selected_wisdom, selected_experience)
	do_smoke(1, holder = wise, location = targetloc)
	announce_to_ghosts(wise)