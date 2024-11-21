/datum/controller/subsystem/map_vote/finalize_map_vote(datum/vote/map_vote/map_vote)
	if(already_voted)
		message_admins("Attempted to finalize a map vote after a map vote has already been finalized.")
		return
	already_voted = TRUE

	var/flat = CONFIG_GET(number/map_vote_flat_bonus)
	previous_cache = map_vote_cache.Copy()
	for(var/map_id in map_vote.choices)
		var/datum/map_config/map = config.maplist[map_id]
		map_vote_cache[map_id] += (map_vote.choices[map_id] * map.voteweight) + flat
	sanitize_cache()
	write_cache()
	update_tally_printout()

	var/list/message_data = list()
	for(var/map_id in map_vote.choices)
		var/datum/map_config/map = config.maplist[map_id]
		message_data += "[map.map_name] - [map_vote_cache[map_id]]"
	var/filtered_vote_results = "[span_bold("Vote Results (Including Carryover)")]\n\n[message_data.Join("\n")]"

	if(admin_override)
		send_map_vote_notice("Admin Override is in effect. Map will not be changed.", "Tallies are recorded and saved.")
		return

	var/list/valid_maps = filter_cache_to_valid_maps()
	if(!length(valid_maps))
		send_map_vote_notice("No valid maps.")
		return

	var/winner
	var/winner_amount = 0
	for(var/map in valid_maps)
		if(!winner_amount)
			winner = map
			winner_amount = map_vote_cache[map]
			continue
		if(map_vote_cache[map] <= winner_amount)
			continue
		winner = map
		winner_amount = map_vote_cache[map]

	ASSERT(winner, "No winner found in map vote.")
	set_next_map(config.maplist[winner])
	var/list/vote_result_message = list(filtered_vote_results)
	vote_result_message += list("<hr>Next Map: [span_cyan(span_bold(next_map_config.map_name))]")
	var/carryover_percentage = CONFIG_GET(number/map_vote_tally_carryover_percentage)
	if(carryover_percentage)
		vote_result_message += list("\n[CONFIG_GET(number/map_vote_tally_carryover_percentage)]% of votes from the losing maps will be carried over and applied to the next map vote.")

	// do not reset tallies if only one map is even possible
	if(length(valid_maps) > 1)
		map_vote_cache[winner] = CONFIG_GET(number/map_vote_minimum_tallies)
		write_cache()
		update_tally_printout()
	else
		vote_result_message += "Only one map was possible, tallies were not reset."

	send_map_vote_notice(arglist(vote_result_message))

/datum/controller/subsystem/map_vote/send_map_vote_notice(...)
	var/static/last_message_at
	if(last_message_at == world.time)
		message_admins("Call to send_map_vote_notice twice in one game tick. Yell at someone to condense messages.")
	last_message_at = world.time

	var/list/messages = args.Copy()
	to_chat(world, examine_block(vote_font("[span_bold("Map Vote")]\n<hr>[messages.Join("\n")]")))

/datum/controller/subsystem/map_vote/update_tally_printout()
	var/list/data = list()
	for(var/map_id in map_vote_cache)
		var/datum/map_config/map = config.maplist[map_id]
		data += "[map.map_name] - [map_vote_cache[map_id]]"
	tally_printout = "[span_bold("Current Map Tallies (Including Carryover)")]\n\n[data.Join("\n")]"
