ADMIN_VERB(storyteller_vote, R_ADMIN | R_DEBUG, "Storyteller - Start Vote", "Start a global storyteller vote.", ADMIN_CATEGORY_STORYTELLER)
	if (tgui_alert(usr, "Start global vote?", "Storyteller Vote", "Yes", "No") == "No")
		return
	var/duration = tgui_input_number(usr, "Duration in seconds:", "Vote Duration", 60, 240, 60)
	SSstorytellers.start_vote(duration SECONDS)

ADMIN_VERB(storyteller_end_vote, R_ADMIN | R_DEBUG, "Storyteller - End Vote", "End vote early.", ADMIN_CATEGORY_STORYTELLER)
	SSstorytellers.end_vote()

/datum/controller/subsystem/storytellers/proc/start_vote(duration = 60 SECONDS)
	// Clears existing UIs to prevent duplicates or stale data
	storyteller_vote_uis = list()
	vote_active = TRUE
	to_chat(world, span_boldnotice("Storyteller voting has begun!"))
	current_vote_duration = duration
	for (var/client/C in GLOB.clients)
		var/datum/storyteller_vote_ui/ui = new(C, duration)
		ui.ui_interact(C.mob)
	addtimer(CALLBACK(src, PROC_REF(end_vote)), duration)
	log_storyteller("Storyteller vote started: duration=[duration/10]s")


/datum/controller/subsystem/storytellers/proc/end_vote()
	if(!length(storyteller_vote_uis))
		return

	vote_active = FALSE
	var/list/tallies = list()
	var/list/all_diffs = list()
	var/total_votes = 0
	for(var/client/client in storyteller_vote_uis)
		var/datum/storyteller_vote_ui/ui = storyteller_vote_uis[client]
		for(var/ckey in ui.votes)
			var/list/v = ui.votes[ckey]
			var/id_str = v["storyteller"]
			if (!id_str)
				continue
			tallies[id_str] = (tallies[id_str] || 0) + 1
			if (v["difficulty"])
				all_diffs += v["difficulty"]
			total_votes++
		SStgui.close_uis(ui.owner.mob, ui)
		qdel(ui)

	storyteller_vote_uis = list()
	var/list/best_storytellers = list()
	var/max_votes = 0
	for (var/id_str in tallies)
		var/count = tallies[id_str]
		if (count > max_votes)
			max_votes = count
			best_storytellers = list(id_str)
		else if (count == max_votes)
			best_storytellers += id_str

	if(!length(best_storytellers))
		to_chat(world, span_boldnotice("No votes were cast! Random storyteller selected."))
		selected_id = pick(list(storyteller_data))
		selected_difficulty = 1.0
		return

	var/selected_id_str
	if (best_storytellers.len == 1)
		selected_id_str = best_storytellers[1]
	else
		selected_id_str = pick(best_storytellers)
		to_chat(world, span_announce("Tie broken randomly!"))

	selected_id = selected_id_str  // Set ID from JSON
	var/avg_diff = length(all_diffs) ? get_avg(all_diffs) : 1.0
	selected_difficulty = avg_diff

	var/selected_name = find_candidate_name_global(selected_id_str)
	to_chat(world, span_boldnotice("Storyteller selected: [selected_name] at difficulty [round(avg_diff, 0.1)]."))
	log_storyteller("Storyteller vote ended: [selected_id_str] (votes=[max_votes], diff=[avg_diff]), total votes=[total_votes]")

	if(SSticker.current_state != GAME_STATE_PLAYING)
		return

	if(!storyteller_data[selected_id])
		log_storyteller("Vote failed: invalid ID [selected_id_str]")
		to_chat(world, span_boldnotice("Vote failed! Default storyteller selected."))
		if (active)
			qdel(active)
		active = new /datum/storyteller
		active.difficulty_multiplier = 1.0
		active.initialize_round()
		return

	if(active)
		qdel(active)

	active = create_storyteller_from_data(selected_id)
	active.difficulty_multiplier = clamp(avg_diff, 0.3, 5.0)
	active.initialize_round()

/datum/storyteller_vote_ui/proc/find_candidate_name(id_str)
	for (var/list/cand in candidates)
		if (cand["id"] == id_str)
			return cand["name"]
	return "Unknown"

/proc/get_avg(list/nums)
	if (!length(nums))
		return 1.0
	var/sum = 0
	for (var/n in nums)
		sum += n
	return sum / length(nums)

/proc/find_candidate_name_global(id_str)
	if(SSstorytellers.storyteller_data[id_str])
		return SSstorytellers.storyteller_data[id_str]["name"]
	return "Unknown"



/datum/storyteller_vote_ui
	var/list/candidates
	var/list/votes = list() // ckey -> list("storyteller" = id_string, "difficulty" = num)
	var/vote_end_time = 0
	var/vote_duration = 60 SECONDS
	var/client/owner

/datum/storyteller_vote_ui/New(client/C, duration = 60 SECONDS)
	. = ..()
	if (!C)
		qdel(src)
		return
	owner = C
	vote_duration = duration
	vote_end_time = world.time + duration
	candidates = list()
	// Build from JSON data instead of subtypes
	for(var/id in SSstorytellers.storyteller_data)
		var/list/data = SSstorytellers.storyteller_data[id]
		candidates += list(list(
			"id" = id,
			"name" = data["name"],
			"desc" = data["desc"],
			"portrait" = null,
		))
	SSstorytellers.storyteller_vote_uis[owner] = src

/datum/storyteller_vote_ui/Destroy()
	SSstorytellers.storyteller_vote_uis -= owner
	return ..()

/datum/storyteller_vote_ui/ui_state(mob/user)
	return GLOB.always_state

/datum/storyteller_vote_ui/ui_static_data(mob/user)
	var/list/data = list()
	data["storytellers"] = candidates
	data["min_difficulty"] = 0.3
	data["max_difficulty"] = 5.0
	return data

/datum/storyteller_vote_ui/ui_data(mob/user)
	var/ckey = owner.ckey
	var/list/personal_vote = votes[ckey] || list("storyteller" = null, "difficulty" = 1.0)

	var/list/tallies = list()
	var/list/difficulties = list()
	for (var/client/client in SSstorytellers.storyteller_vote_uis)
		var/datum/storyteller_vote_ui/ui = SSstorytellers.storyteller_vote_uis[client]

		for (var/vote_ckey in ui.votes)
			var/list/v = ui.votes[vote_ckey]
			var/id_str = v["storyteller"]
			if (!id_str)
				continue
			tallies[id_str] = (tallies[id_str] || 0) + 1
			LAZYADD(difficulties[id_str], v["difficulty"])

	var/list/top_tallies = list()
	var/list/sorted_tallies = sortTim(tallies, /proc/cmp_numeric_dsc, TRUE)
	for (var/i = 1 to min(3, length(sorted_tallies)))
		var/id_str = sorted_tallies[i]
		top_tallies += list(list(
			"name" = find_candidate_name(id_str),
			"count" = tallies[id_str],
			"avg_diff" = length(difficulties[id_str]) ? get_avg(difficulties[id_str]) : 1.0
		))

	var/list/data = list()
	data["personal_selection"] = personal_vote["storyteller"]
	data["personal_difficulty"] = personal_vote["difficulty"]
	data["total_voters"] = length(GLOB.clients)
	var/voted_count = 0
	for (var/id_str in tallies)
		voted_count += tallies[id_str]  // Fixed: voted_count as total votes cast
	data["voted_count"] = voted_count
	data["time_left"] = max(0, (vote_end_time - world.time))
	data["top_tallies"] = top_tallies
	data["is_open"] = world.time < vote_end_time
	return data

/datum/storyteller_vote_ui/ui_interact(mob/user, datum/tgui/ui)
	if (!owner)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "StorytellerVote", "Storyteller Vote")
		ui.open()

/datum/storyteller_vote_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return
	var/ckey = owner.ckey
	switch (action)
		if ("select_storyteller")
			var/id = params["id"]
			var/list/personal = votes[ckey] || list()
			personal["storyteller"] = id
			votes[ckey] = personal
			return TRUE
		if ("set_difficulty")
			var/value = text2num(params["value"])
			value = clamp(value, 0.3, 5.0)
			var/list/personal = votes[ckey] || list()
			personal["difficulty"] = value
			votes[ckey] = personal
			return TRUE
	return FALSE


/client/verb/reopen_storyteller_vote()
	set name = "Reopen Storyteller Vote"
	set category = "OOC"
	if(!SSstorytellers.vote_active)
		to_chat(src, span_warning("Voting has ended."))
		return
	var/datum/storyteller_vote_ui/ui = SSstorytellers.storyteller_vote_uis[usr.client]
	if (world.time >= ui.vote_end_time)
		to_chat(src, span_warning("Voting has ended."))
		return
	if (!ui)
		ui = new(src, SSstorytellers.current_vote_duration)
	ui.ui_interact(mob)


