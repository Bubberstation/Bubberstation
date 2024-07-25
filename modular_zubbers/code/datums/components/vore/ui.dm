/datum/component/vore
	var/ui_editing_lookuptable = FALSE
	var/rate_limit_belly_creation = 0

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

	data["character_slots"] = null
	data["vore_slots"] = null
	data["lookup_table"] = null

	if(ui_editing_lookuptable)
		var/datum/vore_preferences/vore_prefs = user.client.get_vore_prefs()
		if(!vore_prefs)
			return data

		data["character_slots"] = user.client.prefs.create_character_profiles()
		data["vore_slots"] = vore_prefs.generate_slot_choice_list()
		data["lookup_table"] = vore_prefs.get_lookup_table()

	return data

/datum/component/vore/ui_data(mob/user)
	var/list/data = list()

	data["selected_belly"] = LAZYFIND(vore_bellies, selected_belly)

	var/list/bellies = list()

	var/index = 0
	for(var/obj/vore_belly/belly as anything in vore_bellies)
		index++
		UNTYPED_LIST_ADD(bellies, list("index" = index) + belly.ui_data(user))

	data["bellies"] = bellies

	// Always their own prefs
	var/datum/vore_preferences/vore_prefs = user.get_vore_prefs()
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
			if(!COOLDOWN_FINISHED(src, rate_limit_belly_creation))
				to_chat(usr, span_warning("You cannot create more bellies right now, please try again in [COOLDOWN_TIMELEFT(src, rate_limit_belly_creation) / 10] seconds."))
				return
			if(LAZYLEN(vore_bellies) >= MAX_BELLIES)
				to_chat(usr, span_warning("You can only have [MAX_BELLIES] bellies."))
				return TRUE
			create_default_belly()
			COOLDOWN_START(src, rate_limit_belly_creation, BELLY_CREATION_COOLDOWN)
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
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
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
		if("load_slot")
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return

			// returns true if the user doesn't decline to load a slot
			if(vore_prefs.load_slot())
				clear_bellies()
				load_bellies_from_prefs()
			. = TRUE
		if("set_slot_name")
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return

			var/name = permissive_sanitize_name(params["name"])
			vore_prefs.set_slot_name(name)
			. = TRUE
		if("copy_to_slot")
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return

			var/slot_to_save_over = vore_prefs.copy_to_slot()
			if(slot_to_save_over != null)
				save_bellies(slot_to_save_over)
				to_chat(usr, span_notice("Copied belly loadout to slot [slot_to_save_over]."))
			. = TRUE
		if("toggle_lookup_data")
			ui_editing_lookuptable = !ui_editing_lookuptable
			update_static_data(usr, ui)
			. = TRUE
		if("set_lookup_table_entry")
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return
			var/from_slot = params["from"]
			var/to_slot = text2num(params["to"])
			if(isnull(to_slot))
				return

			var/list/lookup_table = vore_prefs.get_lookup_table()
			lookup_table["[from_slot]"] = to_slot
			vore_prefs.set_lookup_table(lookup_table)
			update_static_data(usr, ui)

			. = TRUE
		if("delete_lookup_table_entry")
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return
			var/slot_to_delete = "[params["slot_to_delete"]]"

			var/list/lookup_table = vore_prefs.get_lookup_table()
			lookup_table -= slot_to_delete
			vore_prefs.set_lookup_table(lookup_table)
			update_static_data(usr, ui)

			. = TRUE
		if("import_bellies")
			if(!COOLDOWN_FINISHED(src, rate_limit_belly_creation))
				to_chat(usr, span_warning("You cannot create more bellies right now, please try again in [COOLDOWN_TIMELEFT(src, rate_limit_belly_creation) / 10] seconds."))
				return

			// Nearly straight from CHOMP
			var/panel_choice = tgui_input_list(usr, "Belly Import (NOTE: VRDB Is Not Supported)", "Pick an option", list("Import all bellies from JSON", "Import one belly from JSON"))
			if(!panel_choice)
				return
			var/pickOne = FALSE
			if(panel_choice == "Import one belly from JSON")
				pickOne = TRUE
			var/input_file = input(usr, "Please choose a valid JSON file to import from.", "Belly Import") as file
			var/input_data
			try
				input_data = json_decode(file2text(input_file))

				if(!islist(input_data))
					CRASH("The supplied file was not a valid JSON file!")

				if(input_data["db_repo"] != VORE_DB_REPO)
					CRASH("Unable to load file - db_repo was expected to be '[VORE_DB_REPO]' but was '[input_data["db_repo"]]'")

				if(input_data["db_version"] != VORE_DB_VERSION)
					CRASH("Unable to load file - db_version was expected to be '[VORE_DB_VERSION]' but was '[input_data["db_version"]]'")

				var/list/bellies_to_import = input_data["bellies"]

				if(LAZYLEN(bellies_to_import) < 1)
					CRASH("No bellies found!")

				if(pickOne)
					var/list/choices = list()
					var/index = 0
					var/list/repeat_items = list()
					for(var/list/V in bellies_to_import)
						index++
						var/name = V["name"]
						if(!istext(name))
							name = "<unnamed>"
						name = avoid_assoc_duplicate_keys(name, repeat_items)
						choices[name] = index
					var/picked = tgui_input_list(usr, "Belly Import", "Which belly?", choices)
					if(picked)
						bellies_to_import = list(bellies_to_import[choices[picked]])

				var/current_belly_count = LAZYLEN(vore_bellies)
				var/amount_to_import = min(LAZYLEN(bellies_to_import), MAX_BELLIES - LAZYLEN(current_belly_count))
				if(amount_to_import != LAZYLEN(bellies_to_import))
					to_chat(usr, span_warning("You have selected too many bellies to import. Only the first [amount_to_import] will be imported."))

				for(var/i in 1 to amount_to_import)
					var/list/belly = bellies_to_import[i]
					var/obj/vore_belly/new_belly = new /obj/vore_belly(parent, src)
					new_belly.deserialize(belly)
					CHECK_TICK

				// Directly scale cooldown with how much they're creating
				COOLDOWN_START(src, rate_limit_belly_creation, BELLY_CREATION_COOLDOWN * amount_to_import)

			catch(var/exception/e)
				tgui_alert(usr, "The supplied file contains errors: [e]", "Error!")
				return FALSE

			. = TRUE
		if("export_bellies")
			var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
			if(!vore_prefs)
				return
			vore_prefs.export_slot()
			. = TRUE
