/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 1
	weight = 1 // Rare
	min_players = 30
	earliest_start = 30 MINUTES
	track = EVENT_TRACK_MAJOR

/datum/round_event/fleshmind
	fakeable = FALSE
	announce_when = 150
	end_when = 151

/datum/round_event/fleshmind/announce(fake)
	priority_announce("Confirmed outbreak of level $£%!£ biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_AIMALF)

/datum/round_event/fleshmind/start()
	make_core()

/datum/round_event/fleshmind/proc/make_core()

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


