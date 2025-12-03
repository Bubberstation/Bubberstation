ADMIN_VERB(storyteller_admin, R_ADMIN, "Storyteller UI", "Open the storyteller admin panel.", ADMIN_CATEGORY_STORYTELLER)
	var/datum/storyteller_admin_ui/ui = new
	ui.ui_interact(usr)


/datum/storyteller_admin_ui
	/// cached reference to storyteller
	var/datum/storyteller/ctl

/datum/storyteller_admin_ui/New()
	. = ..()
	ctl = SSstorytellers?.active

/datum/storyteller_admin_ui/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/storyteller_admin_ui/ui_interact(mob/user, datum/tgui/ui)
	ctl = SSstorytellers?.active
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Storyteller")
		ui.open()

/datum/storyteller_admin_ui/ui_static_data(mob/user)
	var/list/data = list()
	var/list/moods = list()
	for(var/mood_type in subtypesof(/datum/storyteller_mood))
		if(mood_type == /datum/storyteller_mood)
			continue
		var/datum/storyteller_mood/mood = mood_type
		moods += list(list(
			"id" = "[mood_type]",
			"name" = initial(mood.name),
			"pace" = initial(mood.pace),
			"threat" = initial(mood.aggression),
		))
	data["available_moods"] = moods

	// Available goals from the subsystem registry, filtered by availability
	var/list/goals = list()
	if(ctl)
		for(var/id_key in SSstorytellers.events_by_id)
			var/datum/round_event_control/evt = SSstorytellers.events_by_id[id_key]
			if(evt.is_avaible(ctl.inputs, ctl))
				goals += list(list(
					"id" = evt.id,
					"name" = evt.name || evt.id,
					"weight" = evt.get_story_weight(ctl.inputs, ctl),
					"is_antagonist" = (evt.story_category & STORY_GOAL_ANTAGONIST),
				))
	data["available_goals"] = goals

	var/list/candidates = list()
	for(var/id in SSstorytellers.storyteller_data)
		var/list/storyteller_data = SSstorytellers.storyteller_data[id]
		if(!storyteller_data)
			continue
		candidates += list(list(
			"name" = storyteller_data["name"],
			"id" = id,
		))
	data["candidates"] = candidates
	return data


/datum/storyteller_admin_ui/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/storyteller_portraits_icons),
	)




/datum/storyteller_admin_ui/ui_data(mob/user)
	var/list/data = list()
	ctl = SSstorytellers?.active
	if(!ctl)
		data["name"] = "No storyteller"
		return data

	data["id"] = ctl.id
	data["name"] = ctl.name
	data["desc"] = ctl.desc
	data["ooc_desc"] = ctl.ooc_desc
	data["ooc_difficulty"] = ctl.ooc_difficulty
	if(ctl.mood)
		data["mood"] = list(
			"id" = "[ctl.mood.type]",
			"name" = ctl.mood.name,
			"pace" = ctl.mood.pace,
			"threat" = ctl.mood.get_threat_multiplier(),
		)
	var/list/upcoming = ctl.planner.get_upcoming_events(10)
	data["upcoming_goals"] = list()
	for(var/offset in upcoming)
		var/list/entry = ctl.planner.get_entry_at(offset)
		if(!entry || !entry["event"])
			continue
		var/datum/round_event_control/evt = entry["event"]
		if(!evt)
			continue
		var/storyteller_implementation = FALSE
		if(evt?.typepath)
			if(istype(evt?.typepath, /datum/round_event))
				var/datum/round_event/to_check = evt?.typepath
				storyteller_implementation = to_check::storyteller_implementation
		data["upcoming_goals"] += list(list(
			"id" = evt.id,
			"name" = evt.name || evt.id,
			"desc" = evt.description,
			"fire_time" = entry["fire_time"],
			"category" = entry["category"],
			"status" = entry["status"],
			"weight" = evt.get_story_weight(ctl.inputs, ctl),
			"storyteller_implementation" = storyteller_implementation,
			"is_antagonist" = (evt.story_category & STORY_GOAL_ANTAGONIST),
		))
	data["effective_threat_level"] = ctl.get_effective_threat()
	data["target_tension"] = ctl.target_tension
	data["round_progression"] = ctl.round_progression
	data["threat_level"] = ctl.threat_points
	data["next_think_time"] = ctl.next_think_time
	data["base_think_delay"] = ctl.base_think_delay
	data["average_event_interval"] = ctl.average_event_interval
	data["player_count"] = ctl.inputs.player_count()
	data["antag_count"] = ctl.inputs.antag_count()
	data["player_antag_balance"] = ctl.player_antag_balance
	data["difficulty_multiplier"] = ctl.difficulty_multiplier
	data["event_difficulty_modifier"] = ctl.difficulty_multiplier
	data["current_tension"] = ctl.current_tension
	data["can_force_event"] = TRUE
	data["current_world_time"] = world.time
	var/list/events = list()
	for(var/id in ctl.recent_events)
		if(!id || !ctl.recent_events[id])
			continue
		var/list/details = ctl.recent_events[id]
		if(!details || !length(details))
			continue
		var/list/event_data = details[1]
		events += list(list(
			"fired_at" = event_data["desc"],
			"desc" = event_data["desc"],
			"status" = event_data["status"],
			"id" = event_data["id"],
		))

	// sortTim(events, some sorter?, "time") TODO: sort this shit by time
	data["recent_events"] = events.len ? events.Copy(1, min(20, events.len + 1)) : list()
	data["available_moods"] = list()
	for(var/path in subtypesof(/datum/storyteller_mood))
		var/datum/storyteller_mood/M = path
		data["available_moods"] += list(list(
			"id" = "[path]",
			"name" = initial(M.name),
		))
	data["available_goals"] = list()
	for(var/id in SSstorytellers.events_by_id)
		var/datum/round_event_control/evt = SSstorytellers.events_by_id[id]
		if(!evt)
			continue
		data["available_goals"] += list(list(
			"id" = evt.id,
			"name" = evt.name || evt.id,
		))
	return data

/datum/storyteller_admin_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!check_rights(R_ADMIN))
		return TRUE
	ctl = SSstorytellers?.active
	if(!ctl)
		return TRUE

	switch(action)
		if("force_think")
			message_admins("[key_name_admin(usr)] forced [ctl.name] to think now")
			ctl.next_think_time = world.time + 1 SECONDS
			return TRUE
		if("trigger_event")
			// Trigger ad-hoc random event outside chain
			ctl.trigger_random_event(ctl.inputs.vault, ctl.inputs, ctl)
			return TRUE
		if("force_fire_next")
			var/list/entry = ctl.planner.get_closest_entry()
			if(entry)
				var/fire_time = entry["fire_time"]
				var/new_fire_time = entry["fire_time"] = world.time + 1 SECONDS
				ctl.planner.reschedule_event(fire_time, new_fire_time)
			return TRUE
		if("reschedule_chain")
			message_admins("[key_name_admin(usr)] forced reschedule event chain for [ctl.name]")
			ctl.planner.recalculate_plan(ctl, ctl.inputs, ctl.balancer.make_snapshot(ctl.inputs), TRUE)
			return TRUE
		if("set_storyteller")
			var/storyteller_id = params["id"]
			if(!storyteller_id)
				return TRUE
			if(SSstorytellers.set_storyteller(storyteller_id))
				ctl = SSstorytellers.active
				message_admins("[key_name_admin(usr)] is changed storyteller to [ctl.name].")
		if("set_mood")
			var/mood_id = params["id"]
			if(mood_id)
				var/path = text2path(mood_id)
				if(ispath(path, /datum/storyteller_mood))
					ctl.mood = new path
					ctl.schedule_next_think()
			return TRUE
		if("set_pace")
			var/pace = clamp(text2num(params["pace"]), 0.1, 3.0)
			if(ctl.mood)
				ctl.mood.pace = pace
				ctl.schedule_next_think()
			return TRUE
		if("reanalyse")
			ctl.run_metrics()
			return TRUE
		if("replan")
			ctl.planner.recalculate_plan(ctl, ctl.inputs, ctl.balancer.make_snapshot(ctl.inputs), TRUE)
			return TRUE
		// Advanced setters
		if("set_difficulty")
			var/value = clamp(text2num(params["value"]), 0.1, 5.0)
			ctl.difficulty_multiplier = value
			return TRUE
		if("set_target_tension")
			var/value = clamp(text2num(params["value"]), 0, 100)
			ctl.target_tension = value
			return TRUE
		if("set_think_delay")
			var/value = max(0, round(text2num(params["value"])) )
			ctl.base_think_delay = value
			ctl.schedule_next_think()
			return TRUE
		if("set_average_event_interval")
			ctl.average_event_interval = round(text2num(params["average_event_interval"]))
			return TRUE
		if("set_grace_period")
			var/value = max(0, round(text2num(params["value"])) )
			ctl.grace_period = value
			return TRUE
		if("set_repetition_penalty")
			var/value = clamp(text2num(params["value"]), 0, 2)
			ctl.repetition_penalty = value
			return TRUE
		if("insert_goal_to_chain")
			var/id = params["id"]
			if(!id)
				return TRUE
			var/datum/round_event_control/evt = SSstorytellers.events_by_id[id]
			if(istype(evt))
				var/datum/round_event_control/new_event_control = new evt.type
				var/fire_offset = ctl.planner.get_next_event_delay(new_event_control, ctl)
				ctl.planner.try_plan_event(new_event_control, fire_offset, silence = TRUE)
				message_admins("[key_name_admin(usr)] is planned event [evt.name || evt.id] for [ctl.name]")
			return TRUE
		if("trigger_goal")
			var/fire_offset = params["offset"]
			if(!fire_offset)
				return TRUE
			var/datum/round_event_control/evt = ctl.planner.get_entry_at(fire_offset)["event"]
			ctl.planner.reschedule_event(fire_offset, world.time + 1 SECONDS)
			message_admins("[key_name_admin(usr)] triggered [ctl.name] event [evt.name || evt.id]")
			return TRUE
		if("remove_goal")
			var/fire_offset = params["offset"]
			if(!fire_offset)
				return TRUE
			if(!ctl.planner.get_entry_at(fire_offset)["event"])
				return TRUE
			var/datum/round_event_control/evt = ctl.planner.get_entry_at(fire_offset)["event"]
			ctl.planner.cancel_event(fire_offset)
			message_admins("[key_name_admin(usr)] canceled [ctl.name] event [evt.name || evt.id]")
			return TRUE
		if("toggle_debug")
			SSstorytellers.hard_debug = !SSstorytellers.hard_debug
			message_admins("[key_name_admin(usr)] toggle stortyteller debug mode: [SSstorytellers.hard_debug ? "ENABLED" : "DISABLED"]")
			return TRUE
		if("force_check_atnagoinst")
			if(HAS_TRAIT(ctl, STORYTELLER_TRAIT_NO_ANTAGS))
				var/ask = tgui_alert(usr, "[ctl.name] has the NO_ANTAGS trait! force them to spawn antags?", "Continue?", list("Confirm", "Cancel"))
				if(ask != "Confirm")
					return TRUE
			message_admins("[key_name_admin(usr)] forced antagonist spawn check for [ctl.name].")
			ctl.check_and_spawn_antagonists()
			return TRUE
		if("reload_event_config")
			SSstorytellers.load_event_config()
			message_admins("[key_name_admin(usr)] reloaded storyteller event configuration.")
		if("reload_storyteller_config")
			SSstorytellers.load_storyteller_data()
			message_admins("[key_name_admin(usr)] reloaded storyteller configuration.")
		if("reload_current_storyteller")
			SSstorytellers.create_storyteller_from_data(ctl.id, FALSE)
			message_admins("[key_name_admin(usr)] reloaded config of current storyteller ([ctl.name]).")
	return FALSE
