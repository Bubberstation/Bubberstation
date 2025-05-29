
/datum/round_event_control/dessert_infestation
	name = "Dessert Infestation"
	typepath = /datum/round_event/dessert_infestation
	weight = 6
	max_occurrences = 3
	min_players = 6

/datum/round_event/dessert_infestation
	announce_when = 100
	var/static/list/dessert_station_areas_blacklist = typecacheof(/area/space,
	/area/shuttle,
	/area/mine,
	/area/holodeck,
	/area/ruin,
	/area/hallway,
	/area/hallway/primary,
	/area/hallway/secondary,
	/area/hallway/secondary/entry,
	/area/engineering/supermatter,
	/area/ai_monitored/turret_protected,
	/area/asteroid/nearstation,
	/area/science/server,
	/area/science/explab,
	/area/science/xenobiology,
	/area/security/processing)
	var/spawncount = 1
	fakeable = FALSE

/datum/round_event/dessert_infestation/setup()
	announce_when = rand(announce_when, announce_when + 50)
	spawncount = rand(4, 7)

/datum/round_event/dessert_infestation/announce(fake)
	priority_announce("Unidentified lifesigns detected aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", 'GainStation13/sound/ai/aliens.ogg')

/datum/round_event/dessert_infestation/start()
	var/list/area/stationAreas = list()
	var/list/area/eligible_areas = list()
	for(var/area/A in world) // Get the areas in the Z level
		if(A.z == SSmapping.station_start)
			stationAreas += A
	for(var/area/place in stationAreas) // first we check if it's a valid area
		if(place.outdoors)
			continue
		if(place.areasize < 16)
			continue
		if(is_type_in_typecache(place, dessert_station_areas_blacklist))
			continue
		eligible_areas += place
	for(var/area/place in eligible_areas) // now we check if there are people in that area
		var/numOfPeople
		for(var/mob/living/carbon/H in place)
			numOfPeople++
			break
		if(numOfPeople > 0)
			eligible_areas -= place

	var/validFound = FALSE
	var/list/turf/validTurfs = list()
	var/area/pickedArea
	while(!validFound || !eligible_areas.len)
		pickedArea = pick_n_take(eligible_areas)
		var/list/turf/t = get_area_turfs(pickedArea, SSmapping.station_start)
		for(var/turf/thisTurf in t) // now we check if it's a closed turf, cold turf or occupied turf and yeet it
			if(isclosedturf(thisTurf))
				t -= thisTurf
			else
				for(var/obj/O in thisTurf)
					if(O.density && !(istype(O, /obj/structure/table)))
						t -= thisTurf
						break
		if(t.len >= spawncount) //Is the number of available turfs equal or bigger than spawncount?
			validFound = TRUE
			validTurfs = t

	if(!eligible_areas.len)
		message_admins("No eligible areas for spawning dessert mobs.")
		return WAITING_FOR_SOMETHING

	notify_ghosts("A group of feeder mobs has spawned in [pickedArea]!", source=pickedArea, action=NOTIFY_ATTACK, flashwindow = FALSE)
	while(spawncount > 0 && validTurfs.len)
		spawncount--
		var/turf/pickedTurf = pick_n_take(validTurfs)
		if(spawncount != 0)
			var/spawn_type = /mob/living/simple_animal/hostile/feed/chocolate_slime
			spawn_atom_to_turf(spawn_type, pickedTurf, 1, FALSE)
		else
			var/spawn_type = /mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast
			spawn_atom_to_turf(spawn_type, pickedTurf, 1, FALSE)
	return SUCCESSFUL_SPAWN
