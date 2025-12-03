ADMIN_VERB(storyteller_vote, R_ADMIN | R_DEBUG, "Storyteller - Start Vote", "Start a global storyteller vote.", ADMIN_CATEGORY_STORYTELLER)
	if (tgui_alert(usr, "Start global vote?", "Storyteller Vote", list("Yes", "No")) == "No")
		return
	var/duration = tgui_input_number(usr, "Duration in seconds:", "Vote Duration", 60, 240, 60)
	SSstorytellers.start_vote(duration SECONDS)

ADMIN_VERB(storyteller_end_vote, R_ADMIN | R_DEBUG, "Storyteller - End Vote", "End vote early.", ADMIN_CATEGORY_STORYTELLER)
	SSstorytellers.end_vote()

/datum/asset/simple/storyteller_logo_icons
	assets = list()

/datum/asset/simple/storyteller_logo_icons/New()
	for(var/storyteller_id in SSstorytellers.storyteller_data)
		var/list/storyteller_data = SSstorytellers.storyteller_data[storyteller_id]
		if(!storyteller_data)
			continue
		var/asset_id = storyteller_id + "_logo" + ".png"
		var/path = storyteller_data["logo_path"]
		assets[asset_id] = path
	..()



/datum/asset/simple/storyteller_portraits_icons
	assets = list()

/datum/asset/simple/storyteller_portraits_icons/New()
	GLOB.asset_datums[type] = src
	for(var/storyteller_id in SSstorytellers.storyteller_data)
		var/list/storyteller_data = SSstorytellers.storyteller_data[storyteller_id]
		if(!storyteller_data)
			continue
		var/asset_id = storyteller_id + "_portrait" + ".png"
		var/path = storyteller_data["portait_path"]
		assets[asset_id] = path
	..()

/datum/action/storyteller_vote
	name = "Vote for storyteller!"
	button_icon_state = "vote"
	show_to_observers = FALSE

/datum/action/storyteller_vote/IsAvailable(feedback = FALSE)
	return TRUE

/datum/action/storyteller_vote/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(SSstorytellers, COMSIG_STORYTELLER_VOTE_END, PROC_REF(on_vote_ended), TRUE)

/datum/action/storyteller_vote/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(!SSstorytellers.vote_active)
		Remove(owner)
		return
	var/datum/storyteller_vote_ui/ui = SSstorytellers.storyteller_vote_uis[clicker.client]
	if (!ui)
		ui = new(clicker.client, SSstorytellers.current_vote_duration)
	ui.ui_interact(clicker)

/datum/action/storyteller_vote/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["open_ui"])
		Trigger(owner)

/datum/action/storyteller_vote/proc/on_vote_ended()
	SIGNAL_HANDLER

	UnregisterSignal(SSstorytellers, COMSIG_STORYTELLER_VOTE_END)
	Remove(owner)

/datum/action/storyteller_vote/Remove(mob/removed_from)
	if(removed_from.persistent_client)
		removed_from.persistent_client.player_actions -= src

	else if(removed_from.ckey)
		var/datum/persistent_client/persistent_client = GLOB.persistent_clients_by_ckey[removed_from.ckey]
		persistent_client?.player_actions -= src

	return ..()

/datum/controller/subsystem/storytellers
	var/vote_timer_id

/datum/controller/subsystem/storytellers/proc/on_login(dcs, client/new_client)
	SIGNAL_HANDLER
	if(vote_active)
		var/datum/action/storyteller_vote/vote_action = new()
		vote_action.Grant(new_client.mob)
		new_client.persistent_client.player_actions += vote_action
		INVOKE_ASYNC(src, PROC_REF(send_vote_message), new_client, vote_action)

/datum/controller/subsystem/storytellers/proc/start_vote(duration = 60 SECONDS)
	// Clears existing UIs to prevent duplicates or stale data
	storyteller_vote_uis = list()
	vote_active = TRUE
	to_chat(world, span_boldnotice("Storyteller voting has started!"))
	current_vote_duration = duration
	for (var/client/cln in GLOB.clients)
		var/datum/action/storyteller_vote/vote_action = new()
		vote_action.Grant(cln.mob)
		cln.persistent_client.player_actions += vote_action
		INVOKE_ASYNC(src, PROC_REF(send_vote_message), cln, vote_action)

	vote_timer_id = addtimer(CALLBACK(src, PROC_REF(end_vote)), duration, TIMER_STOPPABLE)
	SEND_SIGNAL(src, COMSIG_STORYTELLER_VOTE_START)

/datum/controller/subsystem/storytellers/proc/send_vote_message(client/cln, datum/action/storyteller_vote/vote_action)
	window_flash(cln)

	// ghost poll prompt sound handling (adapted for vote)
	var/polling_sound_pref = cln.prefs.read_preference(/datum/preference/choiced/sound_ghost_poll_prompt)
	var/polling_sound_volume = cln.prefs.read_preference(/datum/preference/numeric/sound_ghost_poll_prompt_volume)
	if(polling_sound_pref != GHOST_POLL_PROMPT_DISABLED && polling_sound_volume)
		var/polling_sound
		if(polling_sound_pref == GHOST_POLL_PROMPT_1)
			polling_sound = 'sound/misc/prompt1.ogg'
		else
			polling_sound = 'sound/misc/prompt2.ogg'
		SEND_SOUND(cln.mob, sound(polling_sound, volume = polling_sound_volume))

	var/custom_link_style_start = "<style>a:visited{color:Crimson !important}</style>"
	var/custom_link_style_end = "style='color:DodgerBlue;font-weight:bold;-dm-text-outline: 1px black'"

	var/act_vote = "[custom_link_style_start]<a href='byond://?src=[REF(vote_action)];open_ui=1'[custom_link_style_end]>\[Vote Now\]</a>"

	var/surrounding_icon
	// You can set a chat_text_border_icon if desired, e.g., image('icons/hud/actions.dmi', icon_state = "vote")
	// var/chat_text_border_icon = image('icons/hud/actions.dmi', icon_state = "vote")
	// if(chat_text_border_icon)
	// 	var/image/surrounding_image = chat_text_border_icon
	// 	surrounding_icon = icon2html(surrounding_image, cln.mob, extra_classes = "bigicon")
	var/final_message = boxed_message("<span style='text-align:center;display:block'>[surrounding_icon] <span style='font-size:1.2em'>[span_ooc("Storyteller Vote Started! Vote for your preferred storyteller.")]</span> [surrounding_icon]\n[act_vote]</span>")
	to_chat(cln.mob, final_message)


/datum/controller/subsystem/storytellers/proc/end_vote()
	if(!length(storyteller_vote_uis))
		return

	vote_active = FALSE
	deltimer(vote_timer_id)
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
	SEND_SIGNAL(src, COMSIG_STORYTELLER_VOTE_END)

	if(SSticker.current_state < GAME_STATE_PLAYING)
		storyteller_vote_cache = list()
		storyteller_vote_cache += selected_id
		write_cache()

	if(SSticker.current_state != GAME_STATE_PLAYING)
		return

	if(!storyteller_data[selected_id])
		log_storyteller("Vote failed: invalid ID [selected_id_str]")
		to_chat(world, span_boldnotice("Vote failed! Default storyteller selected."))
		if (active)
			qdel(active)
		active = new /datum/storyteller
		active.difficulty_multiplier = 1.0
		active.initialize()
		return

	if(active)
		qdel(active)

	active = create_storyteller_from_data(selected_id)
	active.difficulty_multiplier = clamp(avg_diff, 0.3, 5.0)
	active.initialize()

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

/datum/storyteller_vote_ui/New(client/vote_client, duration = 60 SECONDS)
	. = ..()
	if (!vote_client)
		qdel(src)
		return
	owner = vote_client
	vote_duration = duration
	vote_end_time = world.time + duration
	candidates = list()
	var/current_id
	if(SSstorytellers.active)
		current_id = SSstorytellers.active.id

	if(SSstorytellers.last_selected_id && SSticker.current_state == GAME_STATE_PREGAME)
		current_id = SSstorytellers.last_selected_id

	for(var/id in SSstorytellers.storyteller_data)
		if(current_id)
			if(current_id == id) continue

		var/list/data = SSstorytellers.storyteller_data[id]
		candidates += list(list(
			"id" = id,
			"name" = data["name"],
			"desc" = data["desc"],
			"portrait_path" = data["portrait_path"],
			"logo_path" = data["logo_path"],
			"ooc_desc" = data["ooc_desc"],
			"ooc_diff" = data["ooc_difficulty"],
		))
	SSstorytellers.storyteller_vote_uis[owner] = src

/datum/storyteller_vote_ui/Destroy()
	SSstorytellers.storyteller_vote_uis -= owner
	return ..()

/datum/storyteller_vote_ui/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/storyteller_logo_icons),
		get_asset_datum(/datum/asset/simple/storyteller_portraits_icons),
	)


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

	var/can_vote = TRUE

	if(!isAdminObserver(user))
		if(isobserver(user))
			can_vote = FALSE
		var/area/my_area = get_area(user)
		if(istype(my_area, /area/misc/hilbertshotel) || istype(my_area, /area/misc/hilbertshotelstorage))
			can_vote = FALSE

	data["can_vote"] = can_vote
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
