/datum/round_event_control/proc/generate_ui_data()
	return list(
				"name" = name,
				"desc" = description,
				"tags" = tags,
				"occurences" = get_occurences(),
				"occurences_shared" = !isnull(shared_occurence_type),
				"min_pop" = min_players,
				"start" = (earliest_start / 600),
				"can_run" = can_spawn_event(),
				"weight" = calculated_weight,
				"weight_raw" = weight,
				"track" = track,
				"roundstart" = roundstart,
			)
