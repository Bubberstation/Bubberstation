/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 1
	weight = 3
	min_players = 30
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT, TAG_CHAOTIC)
	earliest_start = 30 MINUTES
	track = EVENT_TRACK_MAJOR

/datum/round_event/fleshmind
	fakeable = FALSE
	announce_when = 200
	end_when = 201

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

	var/turf/picked_turf = get_safe_random_station_turf(areas)

	for(var/turf/open/floor/floors in range(2, picked_turf))
		if(!floors.Enter(test_resin))
			continue
		if(locate(/turf/closed) in range(1, test_resin))
			continue
		turfs += floors

	if(!LAZYLEN(turfs))
		message_admins("Fleshmind failed to pick a proper turf!")
		return

	qdel(test_resin)
	var/final_turf = pick(turfs)
	var/obj/structure/fleshmind/structure/core/new_core = new(final_turf)
	announce_to_ghosts(new_core)
