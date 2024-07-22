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

	data["max_burn_damage"] = MAX_BURN_DAMAGE
	data["max_brute_damage"] = MAX_BRUTE_DAMAGE

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

	data["inside"] = null
	if(istype(user.loc, /obj/vore_belly))
		var/obj/vore_belly/tummy = user.loc
		data["inside"] = tummy.ui_data(user)

	return data

/datum/component/vore/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/living/living_parent = parent
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
		if("click_prey")
			var/mob/prey = locate(params["ref"])
			if(prey == living_parent)
				living_parent.examinate(living_parent)
			else if(istype(prey))
				// We are prey next to them
				if(istype(living_parent.loc, /obj/vore_belly) && prey.loc == living_parent.loc)
					var/what_to_do = tgui_alert(usr, "What do you want to do to [prey]?", "Prey Options", list("Examine", "Interact", "Help Out"))
					switch(what_to_do)
						if("Examine")
							living_parent.examinate(prey)
						if("Interact")
							living_parent.CtrlShiftClickOn(prey)
						// if("Eat") // Not implemented on Bubbers at all
						if("Help Out")
							to_chat(living_parent, "Not implemented yet :)")
				// We ate them
				else if(living_parent.contains(prey))
					var/what_to_do = tgui_alert(usr, "What do you want to do to [prey]?", "Prey Options", list("Examine", "Eject", "Transfer"))
					switch(what_to_do)
						if("Examine")
							living_parent.examinate(prey)
						if("Eject")
							prey.forceMove(living_parent.loc)
							// TODO: custom exit messages
							living_parent.visible_message(span_danger("[living_parent] squelches out [prey]!"), span_notice("You squelch out [prey]."))
							// TODO: noise
						if("Transfer")
							// TODO: Transfers
							to_chat(living_parent, "Not implemented yet :)")
			. = TRUE
		if("edit_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			target.ui_modify_var(params["var"], params["value"])
			save_bellies()
			. = TRUE
		if("test_sound")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			switch(params["sound"])
				if("insert_sound")
					SEND_SOUND(usr, sound(target.get_insert_sound()))
				if("release_sound")
					SEND_SOUND(usr, sound(target.get_release_sound()))
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
		if("move_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			var/index = vore_bellies.Find(target)
			if(!index)
				return

			var/dir = params["dir"]
			if(dir == "up" && index > 1)
				vore_bellies.Swap(index - 1, index)
			else if(index < LAZYLEN(vore_bellies))
				vore_bellies.Swap(index, index + 1)

			save_bellies()
			. = TRUE
		if("delete_belly")
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			if(LAZYLEN(vore_bellies) == 1)
				to_chat(usr, span_danger("You can't delete your last belly, modify it or make a new one to take it's place."))
				return

			qdel(target)
			save_bellies()
			. = TRUE
		if("belly_backups")
			download_belly_backup()
			. = TRUE
