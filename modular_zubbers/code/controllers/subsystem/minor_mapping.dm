/datum/controller/subsystem/minor_mapping/
	var/list/placed_satchel_turfs = list() //For debugging purposes. Or if you're a badmin and you're trying to cheat.

/datum/controller/subsystem/minor_mapping/place_satchels(satchel_amount)

	var/start_time = REALTIMEOFDAY

	var/list/possible_satchel_turfs_maint = list() //First priority. This is maintenance and prison.
	var/list/possible_satchel_turfs = list() //Second priority. This is everywhere else on the station.

	for(var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		for(var/turf/open/floor/detected_turf as anything in Z_TURFS(z))
			if(!isfloorturf(detected_turf))
				continue
			if(!detected_turf.floor_tile) //Make sure it is actually a floor tile.
				continue
			if(detected_turf.planetary_atmos) //Make sure it is actually on station.
				continue
			if(detected_turf.initial_gas_mix == OPENTURF_DEFAULT_ATMOS) //Make sure it's actually accessible.
				continue
			if(detected_turf.underfloor_accessibility > UNDERFLOOR_HIDDEN) //Make sure it can have an underfloor.
				continue
			var/bad_turf = FALSE
			var/good_turf = FALSE
			for(var/atom/movable/M as anything in detected_turf.contents) //Place under dense unanchored objects
				if(!M.density)
					continue
				if(M.anchored) //There might be some machine that cannot be disassembled here.
					bad_turf = TRUE
				else
					good_turf = TRUE
					break
			if(good_turf && !bad_turf)
				var/area/A = detected_turf.loc
				if(A.area_flags & PERSISTENT_ENGRAVINGS) //This is maintenance and prison.
					possible_satchel_turfs_maint += detected_turf
				else
					possible_satchel_turfs += detected_turf


	var/list/blacklisted_turfs = list()
	for(var/i=1,i<=satchel_amount,i++)

		var/list/list_to_use

		if(length(possible_satchel_turfs_maint))
			list_to_use = possible_satchel_turfs_maint
		else if(length(possible_satchel_turfs))
			list_to_use = possible_satchel_turfs
		else
			var/warning_message = "Error placing the required [satchel_amount] smuggler satchels. Is the map too small?"
			to_chat(world, span_boldannounce(warning_message))
			log_world(warning_message)
			break //Something went wrong.

		var/turf/picked_turf = pick(list_to_use)
		list_to_use -= picked_turf

		var/has_bad_turf = FALSE
		for(var/turf/bad_turf in blacklisted_turfs)
			if(bad_turf.z != picked_turf.z)
				continue
			if(get_dist(bad_turf,picked_turf) < 12) //Too close!
				has_bad_turf = TRUE
				break

		if(has_bad_turf)
			continue

		blacklisted_turfs += picked_turf

		//Place the more obvious Syndicate Decal
		var/obj/effect/decal/cleanable/crayon/syndicate/lambda = new(picked_turf)
		lambda.icon_state = "cat"
		lambda.add_atom_colour(COLOR_SYNDIE_RED, FIXED_COLOUR_PRIORITY)
		SEND_SIGNAL(lambda, COMSIG_OBJ_HIDE, picked_turf.underfloor_accessibility)

		//Place the satchel itself.
		var/obj/item/storage/backpack/satchel/flat/flat_satchel = new(picked_turf)
		SEND_SIGNAL(flat_satchel, COMSIG_OBJ_HIDE, picked_turf.underfloor_accessibility)
		placed_satchel_turfs += picked_turf


	if(!isnull(start_time))
		var/tracked_time = (REALTIMEOFDAY - start_time) / 10
		var/complete_message = "Placed [length(placed_satchel_turfs)] smuggler satchels in [tracked_time] second[tracked_time == 1 ? "" : "s"]!"
		to_chat(world, span_boldannounce(complete_message))
		log_world(complete_message)
