/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 1
	weight = 10
	min_players = 50
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
	var/list/areas = list() // List of all the final areas
	var/list/possible_spawn_areas = typecacheof(typesof(/area/station/maintenance, /area/station/security/prison, /area/station/construction)) // Get us our areas

	for(var/area/iterating_area in GLOB.areas)
		if(!is_station_level(iterating_area.z))
			continue
		if(!is_type_in_typecache(iterating_area, possible_spawn_areas))
			continue
		areas += iterating_area

	shuffle(areas)

	var/turf/picked_turf = get_safe_random_station_turf(areas)

	if(!picked_turf)
		message_admins("Fleshmind failed to pick a proper turf!")
		return

	make_core(picked_turf)

/datum/round_event/fleshmind/proc/make_core(turf/location)
	new /obj/structure/fleshmind/structure/core(location)
