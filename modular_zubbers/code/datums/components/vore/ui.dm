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
	data["max_verb_length"] = MAX_VERB_LENGTH

	data["max_burn_damage"] = MAX_BURN_DAMAGE
	data["max_brute_damage"] = MAX_BRUTE_DAMAGE
	data["max_escape_time"] = MAX_ESCAPE_TIME
	data["min_escape_time"] = MIN_ESCAPE_TIME

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

	data["not_our_owner"] = (user.ckey != our_owner_ckey)

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
				var/obj/vore_belly/prey_loc = prey.loc
				// We are prey next to them
				if(istype(living_parent.loc, /obj/vore_belly) && prey_loc == living_parent.loc)
					var/what_to_do = tgui_alert(usr, "What do you want to do to [prey]?", "Prey Options", list("Examine", "Interact", "Help Out"))
					switch(what_to_do)
						if("Examine")
							living_parent.examinate(prey)
						if("Interact")
							living_parent.CtrlShiftClickOn(prey)
						// if("Eat") // Not implemented on Bubbers at all
						if("Help Out")
							// TODO: check if absorbed
							if(living_parent.incapacitated())
								return

							to_chat(living_parent, span_notice(span_green("You begin to push [prey] to freedom!")))
							to_chat(prey, span_notice("[living_parent] begins to push you to freedom!"))
							to_chat(prey_loc.owner.parent, span_warning("Someone is trying to escape from inside you!"))

							if(do_after(living_parent, 5 SECONDS, prey_loc.owner.parent, timed_action_flags = IGNORE_TARGET_LOC_CHANGE) && prob(33))
								if(prey.loc != prey_loc)
									return
								prey_loc.release(prey)
								to_chat(living_parent, span_notice(span_green("You manage to help [prey] to safety!")))
								to_chat(prey,  span_notice(span_green("[living_parent] pushes you free!")))
								to_chat(prey_loc.owner.parent, span_alert("[prey] forces free of the confines of your body!"))
							else
								to_chat(living_parent, span_alert("[prey] slips back down inside despite your efforts."))
								to_chat(prey, span_alert("Even with [living_parent]'s help, you slip back inside again."))
								to_chat(prey_loc.owner.parent, span_notice(span_green("Your body efficiently shoves [prey] back where they belong.")))
				// We ate them
				else if(prey_loc.owner == src)
					var/what_to_do = tgui_input_list(usr, "What do you want to do to [prey]?", "Prey Options", list("Examine", "Eject", "Transfer", "Digest", "Put In Charge"))
					switch(what_to_do)
						if("Examine")
							living_parent.examinate(prey)
						if("Eject")
							#ifdef VORE_EJECT_DELAY
							to_chat(living_parent, span_notice("You start to work [prey] out of your [lowertext(prey_loc.name)]..."))
							to_chat(prey, span_notice("[living_parent] starts to work you out of their [lowertext(prey_loc.name)]..."))
							if(!do_after(living_parent, VORE_EJECT_DELAY, interaction_key = "vore_eject"))
								return
							#endif
							prey_loc.release(prey)
						if("Transfer")
							var/obj/vore_belly/which_belly = tgui_input_list(usr, "Which belly do you want to transfer them to?", "Belly Transfer", vore_bellies)
							if(which_belly && prey.loc == prey_loc)
								prey.forceMove(which_belly)
						if("Digest")
							#if !REQUIRES_PLAYER
							if(!prey.mind)
								prey_loc.digestion_death(prey)
								return
							#endif
							var/datum/vore_preferences/prey_vore_prefs = prey.get_vore_prefs()
							if(!prey_vore_prefs)
								to_chat(usr, span_warning("[prey] isn't interested in being digested."))
								return
							if(!prey_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion) || !prey_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion_qdel))
								to_chat(usr, span_warning("[prey] isn't interested in being digested."))
								return

							var/consents = tgui_alert(prey, "[living_parent] wants to instantly digest you, is this okay?", "Instant Gurgle", list("No", "Yes"))
							if(consents == "Yes")
								if(!prey_loc.digestion_death(prey))
									to_chat(living_parent, span_warning("[prey] isn't interested in being fully digested."))
							else
								to_chat(living_parent, span_warning("[prey] did not consent to the popup."))
						// TODO: Require absorbed
						if("Put In Charge")
							if(usr.ckey != our_owner_ckey)
								to_chat(usr, span_warning("This is not available on vore components you do not own."))
								return

							if(!prey.mind)
								return

							var/consents = tgui_alert(prey, "[living_parent] wants to let you take control of their body, is this okay?", "Prey Control", list("No", "Yes"))
							if(consents == "Yes")
								living_parent.AddComponent(/datum/component/absorb_control, prey)

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
				to_chat(usr, span_danger("You cannot save your vore preferences as they cannot be loaded."))
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
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
			download_belly_backup()
			. = TRUE
		if("load_slot")
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return

			// returns true if the user doesn't decline to load a slot
			if(vore_prefs.load_slot())
				clear_bellies()
				load_bellies_from_prefs()
			. = TRUE
		if("set_slot_name")
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return

			var/name = permissive_sanitize_name(params["name"])
			vore_prefs.set_slot_name(name)
			. = TRUE
		if("copy_to_slot")
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = usr.get_vore_prefs()
			if(!vore_prefs)
				return

			var/slot_to_save_over = vore_prefs.copy_to_slot()
			if(slot_to_save_over != null)
				save_bellies(slot_to_save_over)
				to_chat(usr, span_notice("Copied belly loadout to slot [slot_to_save_over]."))
			. = TRUE
		if("toggle_lookup_data")
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
			ui_editing_lookuptable = !ui_editing_lookuptable
			update_static_data(usr, ui)
			. = TRUE
		if("set_lookup_table_entry")
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
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
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
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
			var/panel_choice = tgui_input_list(usr, "Belly Import (NOTE: VRDB Is Barely Supported)", "Pick an option", list("Import all bellies from JSON", "Import one belly from JSON"))
			if(!panel_choice)
				return
			var/pickOne = FALSE
			if(panel_choice == "Import one belly from JSON")
				pickOne = TRUE
			var/input_file = input(usr, "Please choose a valid JSON file to import from.", "Belly Import") as file
			var/input_data
			try
				var/text = file2text(input_file)

				if(LAZYLEN(text) > MAX_JSON_CHARACTERS)
					CRASH("The supplied file is too large and cannot be parsed.")

				input_data = json_decode(text)

				if(!islist(input_data))
					CRASH("The supplied file was not a valid JSON file!")

				if(LAZYLEN(input_data) > MAX_JSON_ENTRIES)
					CRASH("The supplied file is too large and cannot be parsed.")

				var/is_vrdb = detect_vrdb(input_data)
				if(is_vrdb)
					to_chat(usr, span_danger("WARNING: This file will be parsed as a VRDB file. This conversion is best-effort only, and may not produce satisfactory results."))
				else
					if(input_data["db_repo"] != VORE_DB_REPO)
						CRASH("Unable to load file - db_repo was expected to be '[VORE_DB_REPO]' but was '[input_data["db_repo"]]'")

					if(input_data["db_version"] != VORE_DB_VERSION)
						CRASH("Unable to load file - db_version was expected to be '[VORE_DB_VERSION]' but was '[input_data["db_version"]]'")

				var/list/bellies_to_import = is_vrdb ? input_data : input_data["bellies"]

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
				to_chat(usr, span_notice("All done importing bellies!"))
				save_bellies()
			catch(var/exception/e)
				tgui_alert(usr, "The supplied file contains errors: [e]", "Error!")
				return FALSE

			. = TRUE
		if("export_bellies")
			if(usr.ckey != our_owner_ckey)
				to_chat(usr, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
			if(!vore_prefs)
				return
			vore_prefs.export_slot()
			. = TRUE
