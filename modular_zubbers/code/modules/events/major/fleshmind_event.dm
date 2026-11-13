/datum/round_event_control/fleshmind
	name = "Fleshmind"
	description = "Spawns a fleshmind"
	typepath = /datum/round_event/fleshmind
	max_occurrences = 1
	weight = 10
	min_players = 35
	tags = list(TAG_DESTRUCTIVE, TAG_COMBAT, TAG_CHAOTIC, TAG_NPC_ANTAG)
	earliest_start = 60 MINUTES
	track = EVENT_TRACK_MAJOR

/datum/round_event/fleshmind
	fakeable = FALSE
	announce_when = 200
	end_when = 201

/datum/round_event/fleshmind/announce(fake)
	priority_announce("Confirmed outbreak of level CLASSIFIED biohazard aboard [station_name()]. Station quarantine subroutines activated.", "Critical Biohazard Alert", ANNOUNCER_MUTANTS)

/datum/round_event/fleshmind/start()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_WIRE_PRIEST, role = ROLE_WIRE_PRIEST, role_name_text = "Wirepriest eye", amount_to_pick = 1, alert_pic = /obj/structure/fleshmind/structure/core)
	if(isnull(chosen_one))
		return fallback_spawn() // Fallback raw spawning
	var/mob/eye/wire_priest/new_priest = new(get_random_station_turf())
	new_priest.PossessByPlayer(chosen_one.key)
	qdel(chosen_one)

/datum/round_event/fleshmind/proc/fallback_spawn()
	var/turf/current_turf = get_turf(src)

	if(wireweed_is_valid_turf(current_turf))
		return

	var/turf/spawn_turf = wireweed_get_valid_loc()

	if(!spawn_turf)
		CRASH("Fleshmind failed to pick a valid turf!")

	new /obj/structure/fleshmind/structure/core(spawn_turf)
	//var/datum/round_event_control/event = locate(/datum/round_event_control/wire_priest) in SSevents.control
	//event.run_event(admin_forced = TRUE)

/proc/wireweed_get_valid_loc()
	var/list/priority_areas = list(
		/area/station/engineering/atmos/hfr_room,
		/area/station/engineering/atmos/mix,
		/area/station/engineering/atmospherics_engine,
		/area/station/maintenance/disposal/incinerator,
		/area/station/commons/vacant_room/office,
		/area/station/common/night_club,
		/area/station/science/xenobiology,
		/area/station/construction/mining/aux_base,
		/area/station/service/chapel/office,
		/area/station/security/prison/garden, // Who out here growing their fleshmind
		/area/station/science/circuits,
		/area/station/service/kitchen/coldroom, // Unlikely, but still
		/area/station/medical/chemistry, // These are super isolated on some stations
	) + subtypesof(/area/station/maintenance)

	var/list/area/final_area_list = list()
	var/turf/final_turf = null

	for(var/area/checked_area as anything in priority_areas)
		if(checked_area in GLOB.the_station_areas)
			final_area_list += checked_area

	if(isnull(final_area_list)) // How did we get here
		return null
	final_turf = wireweed_try_get_valid_turf(final_area_list)
	if(final_turf)
		return final_turf

	// Fallback blobber
	if(LAZYLEN(GLOB.blobstart))
		var/list/shuffled_blobstarts = shuffle(GLOB.blobstart)
		for(var/turf/blob_turf in shuffled_blobstarts)
			if(wireweed_is_valid_turf(blob_turf))
				return blob_turf
	return null

/proc/wireweed_try_get_valid_turf(area_list)
	for(var/attempt in 1 to 16)
		var/area/candidate_area = pick(area_list)
		var/list/candidate_turfs = get_area_turfs(candidate_area)
		for(var/turf_attempt in 1 to 8)
			var/turf/turf_to_try = pick(candidate_turfs)
			if(wireweed_is_valid_turf(turf_to_try))
				return turf_to_try
			candidate_turfs -= turf_to_try
	return null

/// Copied from line 150 of code/modules/antagonists/blob/overmind.dm
/proc/wireweed_is_valid_turf(turf/tile)
	if(isnull(tile))
		return FALSE
	var/area/area = get_area(tile)
	if((area && !(area.area_flags & BLOBS_ALLOWED)) || !is_station_level(tile.z) || isgroundlessturf(tile) || tile.density)
		return FALSE
	if(tile.surrounding_has_player(16))
		return FALSE
	return TRUE

/turf/proc/surrounding_has_player(range = 16)
	for(var/mob/living/blocked_mob in range(range, src))
		if(blocked_mob.client)
			return TRUE
	return FALSE
