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
		for(var/id_key in SSstorytellers.goals_by_id)
			var/datum/storyteller_goal/G = SSstorytellers.goals_by_id[id_key]
			if(G.is_available(ctl.inputs.vault, ctl.inputs, ctl))
				goals += list(list(
					"id" = G.id,
					"name" = G.name || G.id,
					"weight" = G.get_weight(ctl.inputs.vault, ctl.inputs, ctl),
				))
	data["available_goals"] = goals
	return data

/datum/storyteller_admin_ui/ui_data(mob/user)
	var/list/data = list()
	ctl = SSstorytellers?.active
	if(!ctl)
		data["name"] = "No storyteller"
		return data

	data["name"] = ctl.name
	data["desc"] = ctl.desc
	if(ctl.mood)
		data["mood"] = list(
			"id" = "[ctl.mood.type]",
			"name" = ctl.mood.name,
			"pace" = ctl.mood.pace,
			"threat" = ctl.mood.get_threat_multiplier(),
		)
	var/list/upcoming = ctl.planner.get_upcoming_goals(10)
	data["upcoming_goals"] = list()
	for(var/offset in upcoming)
		var/list/entry = ctl.planner.timeline[offset]
		var/datum/storyteller_goal/goal = entry["goal"]
		if(!goal)
			continue
		data["upcoming_goals"] += list(list(
			"id" = goal.id,
			"name" = goal.name || goal.id,
			"fire_time" = entry["fire_time"],
			"category" = entry["category"],
			"status" = entry["status"],
			"weight" = goal.get_weight(ctl.inputs.vault, ctl.inputs, ctl),
			"progress" = goal.get_progress(ctl.inputs.vault, ctl.inputs, ctl),
		))
	data["effective_threat_level"] = ctl.get_effective_threat()
	data["target_tension"] = ctl.target_tension
	data["round_progression"] = ctl.round_progression
	data["threat_level"] = ctl.threat_points
	data["next_think_time"] = ctl.next_think_time
	data["base_think_delay"] = ctl.base_think_delay
	data["min_event_interval"] = ctl.min_event_interval
	data["max_event_interval"] = ctl.max_event_interval
	data["player_count"] = ctl.get_active_player_count()
	data["antag_count"] = ctl.get_active_antagonist_count()
	data["player_antag_balance"] = ctl.player_antag_balance
	data["difficulty_multiplier"] = ctl.difficulty_multiplier
	data["event_difficulty_modifier"] = ctl.difficulty_multiplier
	data["can_force_event"] = TRUE
	data["current_world_time"] = world.time
	var/list/events = list()
	for(var/id in ctl.recent_events)
		var/list/details = ctl.recent_events[id]
		if(!details || !length(details))
			continue
		var/list/event_data = details[1]
		events += list(list(
			"time" = text2num(splittext(event_data["fired_at"], " ")[1]) * 1 MINUTES,  // Parse back to ticks approx
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
	for(var/id in SSstorytellers.goals_by_id)
		var/datum/storyteller_goal/G = SSstorytellers.goals_by_id[id]
		data["available_goals"] += list(list(
			"id" = G.id,
			"name" = G.name || G.id,
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
				ctl.planner.reschedule_goal(fire_time, new_fire_time)
			return TRUE
		if("reschedule_chain")
			ctl.planner.recalculate_plan(ctl, ctl.inputs, ctl.balancer.make_snapshot(ctl.inputs), TRUE)
			return TRUE
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
			ctl.analyzer.scan_station()
			ctl.inputs = ctl.analyzer.get_inputs()
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
		if("set_event_intervals")
			var/minv = max(0, round(text2num(params["min"])) )
			var/maxv = max(minv, round(text2num(params["max"])) )
			ctl.min_event_interval = minv
			ctl.max_event_interval = maxv
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
			var/datum/storyteller_goal/G = SSstorytellers.goals_by_id[id]
			if(istype(G))
				// Schedule at end of chain with default offset
				var/fire_offset = ctl.get_event_interval() * (length(ctl.planner.timeline) + 1)
				ctl.planner.try_plan_goal(G, fire_offset)
			return TRUE
		if("trigger_goal")
			var/fire_offset = params["offset"]
			if(!fire_offset)
				return TRUE
			ctl.planner.reschedule_goal(fire_offset, world.time + 1 SECONDS)
			return TRUE
		if("remove_goal")
			var/fire_offset = params["offset"]
			if(!fire_offset)
				return TRUE
			ctl.planner.cancel_goal(fire_offset)
			return TRUE
		if("toggle_debug")
			SSstorytellers.hard_debug = !SSstorytellers.hard_debug
			message_admins("Stortyteller debug mode: [SSstorytellers.hard_debug ? "ENABLED" : "DISABLED"]")
			return TRUE
	return FALSE
