/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 1
	weight = 3
	min_players = 30
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT)
	earliest_start = 30 MINUTES
	track = EVENT_TRACK_MAJOR

/datum/round_event/fleshmind
	fakeable = FALSE
	announce_when = 150
	end_when = 151

/datum/round_event/fleshmind/announce(fake)
	priority_announce("Confirmed outbreak of level CLASSIFIED biohazard aboard [station_name()]. Station quarantine subroutines activated.", "Critical Biohazard Alert", ANNOUNCER_MUTANTS)

/datum/round_event/fleshmind/start()
	make_core()

/datum/round_event/fleshmind/proc/make_core()
	var/obj/structure/mold/resin/test/test_resin = new()
	var/list/turfs = list() // List of all the final turfs
	var/list/areas = list() // List of all the final areas
	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction)) // Get us our areas

	for(var/area/iterating_area in GLOB.areas)
		if(!is_station_level(iterating_area.z))
			continue
		if(!is_type_in_typecache(iterating_area, possible_spawn_areas))
			continue
		areas += iterating_area
	if(!LAZYLEN(areas))
		message_admins("Fleshmind event controller failed to find a proper area.")
		return

	var/area_pick = pick(areas)
	for(var/turf/open/floor in area_pick)
		if(!floor.Enter(test_resin))
			continue
		if(locate(/turf/closed) in range(2, floor))
			continue
		turfs += floor

	qdel(test_resin, TRUE)

	if(!turfs)
		message_admins("Fleshmind failed to find an appropriate turf to spawn in [area_pick]!")
		return
	var/turf/picked_turf = pick(turfs)

	var/obj/structure/fleshmind/structure/core/new_core = new(picked_turf)
	announce_to_ghosts(new_core)
/*
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	var/obj/structure/mold/resin/test/test_resin = new()

	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction))

	shuffle(possible_spawn_areas)

	for(var/area/iterating_area in GLOB.areas)
		if(!is_station_level(iterating_area.z))
			continue
		if(!is_type_in_typecache(iterating_area, possible_spawn_areas))
			continue
		for(var/turf/open/floor in iterating_area)
			if(!floor.Enter(test_resin))
				continue
			if(locate(/turf/closed) in range(2, floor))
				continue
			turfs += floor

	QDEL_NULL(test_resin)

	if(!turfs)
		message_admins("Fleshmind failed to find an appropriate area to spawn.")
		return

	var/turf/picked_turf = pick(turfs)

	var/obj/structure/fleshmind/structure/core/new_core = new(picked_turf)
	announce_to_ghosts(new_core)
*/

