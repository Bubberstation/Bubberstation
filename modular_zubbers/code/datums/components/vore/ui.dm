/datum/component/vore/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VorePanel", "Vore Panel")
		ui.open()

/datum/component/vore/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	// Only parent can edit us
	if(user != parent)
		. = min(., UI_UPDATE)

/datum/component/vore/ui_state(mob/user)
	return GLOB.conscious_state

/datum/component/vore/ui_static_data(mob/user)
	var/list/data = list()

	data["max_bellies"] = MAX_BELLIES
	data["max_prey"] = MAX_PREY

	return data

/datum/component/vore/ui_data(mob/user)
	var/list/data = list()

	data["selected_belly"] = vore_bellies.Find(selected_belly)

	var/list/bellies = list()

	var/index = 0
	for(var/obj/vore_belly/belly as anything in vore_bellies)
		index++
		UNTYPED_LIST_ADD(bellies, list("index" = index) + belly.ui_data(user))

	data["bellies"] = bellies

	if(vore_prefs)
		data += vore_prefs.ui_data(user)

	return data

/datum/component/vore/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/living/pred = parent
	switch(action)
		if("create_belly")
			if(LAZYLEN(vore_bellies) >= MAX_BELLIES)
				to_chat(usr, span_warning("You can only have [MAX_BELLIES] bellies."))
				return TRUE
			// TODO: Rate limit this
			create_default_belly()
			. = TRUE
		if("select_belly")
			var/obj/vore_belly/new_selected = locate(params["ref"])
			if(istype(new_selected) && new_selected.owner == src)
				selected_belly = new_selected
				to_chat(usr, span_notice("Prey will now go into [selected_belly]."))
			. = TRUE
		if("eject")
			var/mob/prey = locate(params["ref"])
			if(istype(prey) && pred.contains(prey))
				prey.forceMove(pred.loc)
				// TODO: custom exit messages
				pred.visible_message(span_danger("[pred] squelches out [prey]!"), span_notice("You squelch out [prey]."))
				// TODO: noise
			. = TRUE
		if("edit_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return

			switch(params["var"])
				if("name")
					// TODO: MAX_NAME_LENGTH/sanitize
					target.name = params["value"]
				if("desc")
					// TODO: Limit/sanitize
					target.desc = params["value"]

			save_bellies()
		if("set_pref")
			if(!vore_prefs)
				to_chat(usr, span_danger("You cannot save vore preferences as your savefile was not loaded by the vore component."))
				return

			var/key = params["key"]
			var/value = params["value"]

			var/datum/vore_pref/P = GLOB.vore_preference_entries_by_key[key]
			if(!istype(P))
				CRASH("Bad pref key: [key]")

			if(!vore_prefs.write_preference(P, value))
				CRASH("Couldn't write value for [key] ([P]) ([value])")
			. = TRUE
