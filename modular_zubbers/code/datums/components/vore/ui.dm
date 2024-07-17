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
			new /obj/vore_belly(pred, src)
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
