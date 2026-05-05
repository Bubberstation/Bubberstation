/datum/round_event_control/fleshmind
	name = "Fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 1
	weight = 10
	min_players = 35
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT, TAG_CHAOTIC)
	earliest_start = 60 MINUTES
	track = EVENT_TRACK_MAJOR

/datum/round_event/fleshmind
	fakeable = FALSE
	announce_when = 200
	end_when = 201

/datum/round_event/fleshmind/announce(fake)
	priority_announce("Confirmed outbreak of level CLASSIFIED biohazard aboard [station_name()]. Station quarantine subroutines activated.", "Critical Biohazard Alert", ANNOUNCER_MUTANTS)

/datum/round_event/fleshmind/start()
	var/turf/current_turf = get_turf(src)

	if(is_valid_turf(current_turf))
		return

	var/turf/spawn_turf = null

	if(LAZYLEN(GLOB.blobstart))
		var/list/shuffled_blobstarts = shuffle(GLOB.blobstart)

		for(var/turf/blob_turf in shuffled_blobstarts)
			if(is_valid_turf(blob_turf))
				spawn_turf = blob_turf
				break

	else
		for(var/attempt in 1 to 16)
			var/turf/candidate_turf = get_safe_random_station_turf_equal_weight()

			if(is_valid_turf(candidate_turf))
				spawn_turf = candidate_turf
				break

	if(!spawn_turf)
		CRASH("Fleshmind failed to pick a valid turf!")

	make_core(spawn_turf)
	var/datum/round_event_control/event = locate(/datum/round_event_control/wire_priest) in SSevents.control
	event.run_event(admin_forced = TRUE)

/datum/round_event/fleshmind/proc/make_core(turf/location)
	new /obj/structure/fleshmind/structure/core(location)

/// Copied from line 150 of code/modules/antagonists/blob/overmind.dm
/datum/round_event/fleshmind/proc/is_valid_turf(turf/tile)
	var/area/area = get_area(tile)
	if((area && !(area.area_flags & BLOBS_ALLOWED)) || !tile || !is_station_level(tile.z) || isgroundlessturf(tile))
		return FALSE

	if(area_has_player(tile, 7))
		return FALSE

	return TRUE

/datum/round_event/fleshmind/proc/area_has_player(turf/center, range = 7)
	for(var/mob/living/blocked_mob in range(range, center))
		if(blocked_mob.client)
			return TRUE
	return FALSE
