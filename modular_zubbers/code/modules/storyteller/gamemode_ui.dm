// Open the ui, nothing special here
// Maybe make it update static data?
/datum/controller/subsystem/gamemode/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ZubbersStoryteller", "Storyteller control panel")
		ui.open()

/datum/controller/subsystem/gamemode/ui_data(mob/user)
	var/list/data = list()
	data["storyteller_name"] = storyteller ? storyteller.name : "None"
	data["storyteller_halt"] = storyteller_halted
	data["antag_count"] = GLOB.current_living_antags.len // Switch this up if the calculation for the cap changes (It probably will)
	data["antag_cap"] = get_antag_cap()

	data["pop_data"] = get_ui_pop_data()
	data["tracks_data"] = get_ui_track_data()
	data["scheduled_data"] = get_ui_scheduled_data()
	return data

/datum/controller/subsystem/gamemode/proc/get_ui_pop_data()
	var/list/pop_data = list(
		"active" = get_correct_popcount(),
		"head" = head_crew,
		"sec" = sec_crew,
		"eng" = eng_crew,
		"med" = med_crew,
	)
	return pop_data

/datum/controller/subsystem/gamemode/proc/get_ui_track_data()
	var/list/track_data = list()
	for(var/track in event_tracks)
		var/last_points = last_point_gains[track]
		var/lower = event_track_points[track]
		var/upper = point_thresholds[track]
		var/next = last_points ? round((upper - lower) / last_points / STORYTELLER_WAIT_TIME * 40 / 6) / 10 : 0
		var/datum/round_event_control/forced = forced_next_events[track]
		track_data[track] = list(
			"name" = "[track]",
			"current" = lower,
			"max" = upper,
			"next" = next,
			"forced" = forced ? forced.generate_ui_data() : null
		)
	return track_data

/datum/controller/subsystem/gamemode/proc/get_ui_scheduled_data()
	var/list/scheduled_data = list()
	var/list/sorted_scheduled = list()
	for(var/datum/scheduled_event/scheduled as anything in scheduled_events)
		sorted_scheduled[scheduled] = scheduled.start_time
	sortTim(sorted_scheduled, cmp=/proc/cmp_numeric_asc, associative = TRUE)
	for(var/datum/scheduled_event/scheduled as anything in sorted_scheduled)
		var/time = (scheduled.event.roundstart) ? null : ((scheduled.start_time - world.time) / (1 SECONDS))
		scheduled_data[scheduled.event.name] = list(
			"track" = scheduled.event.track,
			"time" = time,
			"event_type" = scheduled.event.type,
		)
	return scheduled_data

// God has abandoned us
/datum/controller/subsystem/gamemode/ui_static_data(mob/user)
	var/list/static_data = list()
	// Events are static because we don't need to update them as often, only on storyteller ticks
	static_data["events"] = list()
	for(var/event_category as anything in event_pools)
		var/list/event_list = event_pools[event_category]
		static_data["events"][event_category] = list("name" = event_category, "events" = list())
		for(var/datum/round_event_control/event as anything in event_list)
			static_data["events"][event_category]["events"][event.type] = event.generate_ui_data()
	// Uncategorized shit
	static_data["events"]["Uncategorized"] = list("name" = "Uncategorized", "events" = list())
	for(var/datum/round_event_control/event as anything in uncategorized)
		static_data["events"]["Uncategorized"]["events"][event.type] = event.generate_ui_data()
	return static_data

/datum/controller/subsystem/gamemode/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/gamemode/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("set_storyteller")
			// Todo: Replace with tgui_input
			var/list/name_list = list()
			for(var/storyteller_type in storytellers)
				var/datum/storyteller/storyboy = storytellers[storyteller_type]
				name_list[storyboy.name] = storyboy.type
			var/new_storyteller_name = input(usr, "Choose new storyteller (circumvents voted one):", "Storyteller")  as null|anything in name_list
			if(!new_storyteller_name)
				return
			message_admins("[key_name_admin(usr)] has changed the Storyteller to [new_storyteller_name].")
			var/new_storyteller_type = name_list[new_storyteller_name]
			set_storyteller(new_storyteller_type, TRUE, usr.ckey)
		if("halt_storyteller")
			halt_storyteller(usr)
		if("track_action")
			switch(params["action"])
				if("set_pnts")
					var/track_to_adjust = params["track"]
					var/num = tgui_input_number(\
					usr, \
					"Set [track_to_adjust] track points",
					title = "Track points", \
					default = event_track_points[track_to_adjust], \
					max_value = point_thresholds[track_to_adjust]*5, \
					)
					if(isnull(num))
						return
					event_track_points[track_to_adjust] = num
				if("force_next")
					var/forced_track = params["track"]
					force_next_event(forced_track, usr)
		if("event_action")
			var/datum/scheduled_event/sch_event = get_scheduled_by_event_type(params["type"])
			if(isnull(sch_event))
				return
			switch(params["action"])
				if("cancel")
					message_admins("[key_name_admin(usr)] cancelled scheduled event [sch_event.event.name].")
					log_admin_private("[key_name(usr)] cancelled scheduled event [sch_event.event.name].")
					SSgamemode.remove_scheduled_event(sch_event)
				if("refund")
					message_admins("[key_name_admin(usr)] refunded scheduled event [sch_event.event.name].")
					log_admin_private("[key_name(usr)] refunded scheduled event [sch_event.event.name].")
					SSgamemode.refund_scheduled_event(sch_event)
				if("reschedule")
					var/new_schedule = tgui_input_number(usr, "Set time in seconds in which to fire event", "Rescheduling event", 0, 3600, 0)
					if(isnull(new_schedule) || QDELETED(sch_event))
						return
					sch_event.start_time = world.time + (new_schedule SECONDS)
					message_admins("[key_name_admin(usr)] rescheduled event [sch_event.event.name] to [new_schedule] seconds.")
					log_admin_private("[key_name(usr)] rescheduled event [sch_event.event.name] to [new_schedule] seconds.")
				if("fire")
					if(!SSticker.HasRoundStarted())
						return
					message_admins("[key_name_admin(usr)] has fired scheduled event [sch_event.event.name].")
					log_admin_private("[key_name(usr)] has fired scheduled event [sch_event.event.name].")
					sch_event.try_fire()
		if("panel_action")
			var/datum/round_event_control/event = get_event_by_track_and_type(params["track"], params["type"])
			if(isnull(event))
				return
			switch(params["action"])
				if("fire")
					message_admins("[key_name_admin(usr)] has fired event [src.name].")
					log_admin_private("[key_name(usr)] has fired event [src.name].")
					SSgamemode.TriggerEvent(event)
				if("force_next")
					message_admins("[key_name_admin(usr)] has forced scheduled event [src.name].")
					log_admin_private("[key_name(usr)] has forced scheduled event [src.name].")
					SSgamemode.force_event(event)
		if("panel_update")
			if(storyteller)
				storyteller.calculate_weights_all()
