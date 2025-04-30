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

	if(admin_override)
		send_map_vote_notice("Admin Override is in effect. Map will not be changed.", "Tallies are recorded and saved.")
		return

	var/list/winner_list = map_vote.get_vote_result()
	var/winner = winner_list[1]
	set_next_map(config.maplist[winner])
	var/list/vote_result_message = list("Method: Ranked Vote<br/ >Next Map: [span_vote_notice(span_bold(winner))]")
	send_map_vote_notice(arglist(vote_result_message))

/datum/controller/subsystem/map_vote/send_map_vote_notice(...)
	var/static/last_message_at
	if(last_message_at == world.time)
		message_admins("Call to send_map_vote_notice twice in one game tick. Yell at someone to condense messages.")
	last_message_at = world.time

	var/list/messages = args.Copy()
	to_chat(world, vote_font(fieldset_block("Map Vote - Results", "[messages.Join("\n")]", "boxed_message purple_box")))

/datum/controller/subsystem/map_vote/update_tally_printout()
	var/list/data = list()
	for(var/map_id in map_vote_cache)
		var/datum/map_config/map = config.maplist[map_id]
		data += "[map.map_name] - [map_vote_cache[map_id]]"
	tally_printout = "[span_bold("Current Map Tallies (Including Carryover)")]\n\n[data.Join("\n")]"
