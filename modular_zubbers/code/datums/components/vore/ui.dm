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
	data["max_vore_message_length"] = MAX_VORE_MESSAGE_LENGTH
	data["min_vore_message_length"] = MIN_VORE_MESSAGE_LENGTH

	data["max_burn_damage"] = MAX_BURN_DAMAGE
	data["max_brute_damage"] = MAX_BRUTE_DAMAGE
	data["max_escape_time"] = MAX_ESCAPE_TIME
	data["min_escape_time"] = MIN_ESCAPE_TIME

	data["character_slots"] = null
	data["vore_slots"] = null
	data["lookup_table"] = null

	var/list/overlay_data = list()
	for(var/atom/movable/screen/fullscreen/carrier/vore/type as anything in subtypesof(/atom/movable/screen/fullscreen/carrier/vore))
		UNTYPED_LIST_ADD(overlay_data, list(
			"path" = type,
			"name" = initial(type.name),
			"icon" = initial(type.icon),
			"icon_state" = initial(type.icon_state),
			"recolorable" = initial(type.recolorable),
		))
	data["available_overlays"] = overlay_data

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
	if(usr != living_parent)
		stack_trace("Vore component ui_act triggered by [key_name(usr)] who IS NOT OUR PARENT [key_name(living_parent)]")
		return

	switch(action)
		if("create_belly")
			if(!COOLDOWN_FINISHED(src, rate_limit_belly_creation))
				to_chat(living_parent, span_warning("You cannot create more bellies right now, please try again in [COOLDOWN_TIMELEFT(src, rate_limit_belly_creation) / 10] seconds."))
				return
			if(LAZYLEN(vore_bellies) >= MAX_BELLIES)
				to_chat(living_parent, span_warning("You can only have [MAX_BELLIES] bellies."))
				return TRUE
			create_default_belly()
			COOLDOWN_START(src, rate_limit_belly_creation, BELLY_CREATION_COOLDOWN)
			. = TRUE
		if("select_belly")
			var/obj/vore_belly/new_selected = locate(params["ref"])
			if(istype(new_selected) && new_selected.owner == src)
				selected_belly = new_selected
				to_chat(living_parent, span_notice("Prey will now go into [selected_belly]."))
			. = TRUE
		if("click_prey")
			var/mob/prey = locate(params["ref"])
			if(istype(prey))
				click_prey(prey)
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
					SEND_SOUND(living_parent, sound(target.get_insert_sound()))
				if("release_sound")
					SEND_SOUND(living_parent, sound(target.get_release_sound()))
		if("set_pref")
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				to_chat(living_parent, span_danger("You cannot save your vore preferences as they cannot be loaded."))
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
				to_chat(living_parent, span_danger("You can't delete your last belly, modify it or make a new one to take it's place."))
				return

			qdel(target)
			save_bellies()
			. = TRUE
		if("belly_backups")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			download_belly_backup()
			. = TRUE
		if("load_slot")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return

			// returns true if the user doesn't decline to load a slot
			if(vore_prefs.load_slot())
				clear_bellies()
				load_bellies_from_prefs()
			. = TRUE
		if("set_slot_name")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return

			var/name = permissive_sanitize_name(params["name"])
			vore_prefs.set_slot_name(name)
			. = TRUE
		if("copy_to_slot")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return

			var/slot_to_save_over = vore_prefs.copy_to_slot()
			if(slot_to_save_over != null)
				save_bellies(slot_to_save_over)
				to_chat(living_parent, span_notice("Copied belly loadout to slot [slot_to_save_over]."))
			. = TRUE
		if("toggle_lookup_data")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			ui_editing_lookuptable = !ui_editing_lookuptable
			update_static_data(living_parent, ui)
			. = TRUE
		if("set_lookup_table_entry")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return
			var/from_slot = params["from"]
			var/to_slot = text2num(params["to"])
			if(isnull(to_slot))
				return

			var/list/lookup_table = vore_prefs.get_lookup_table()
			lookup_table["[from_slot]"] = to_slot
			vore_prefs.set_lookup_table(lookup_table)
			update_static_data(living_parent, ui)

			. = TRUE
		if("delete_lookup_table_entry")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = living_parent.get_vore_prefs()
			if(!vore_prefs)
				return
			var/slot_to_delete = "[params["slot_to_delete"]]"

			var/list/lookup_table = vore_prefs.get_lookup_table()
			lookup_table -= slot_to_delete
			vore_prefs.set_lookup_table(lookup_table)
			update_static_data(living_parent, ui)

			. = TRUE
		if("import_bellies")
			if(!COOLDOWN_FINISHED(src, rate_limit_belly_creation))
				to_chat(living_parent, span_warning("You cannot create more bellies right now, please try again in [COOLDOWN_TIMELEFT(src, rate_limit_belly_creation) / 10] seconds."))
				return

			// Nearly straight from CHOMP
			var/panel_choice = tgui_input_list(living_parent, "Belly Import (NOTE: VRDB Is Barely Supported)", "Pick an option", list("Import all bellies from JSON", "Import one belly from JSON"))
			if(!panel_choice)
				return
			var/pickOne = FALSE
			if(panel_choice == "Import one belly from JSON")
				pickOne = TRUE
			var/input_file = input(living_parent, "Please choose a valid JSON file to import from.", "Belly Import") as file
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
					to_chat(living_parent, span_danger("WARNING: This file will be parsed as a VRDB file. This conversion is best-effort only, and may not produce satisfactory results."))
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
					var/picked = tgui_input_list(living_parent, "Belly Import", "Which belly?", choices)
					if(picked)
						bellies_to_import = list(bellies_to_import[choices[picked]])

				var/current_belly_count = LAZYLEN(vore_bellies)
				var/amount_to_import = min(LAZYLEN(bellies_to_import), MAX_BELLIES - LAZYLEN(current_belly_count))
				if(amount_to_import != LAZYLEN(bellies_to_import))
					to_chat(living_parent, span_warning("You have selected too many bellies to import. Only the first [amount_to_import] will be imported."))

				for(var/i in 1 to amount_to_import)
					var/list/belly = bellies_to_import[i]
					var/obj/vore_belly/new_belly = new /obj/vore_belly(parent, src)
					new_belly.deserialize(belly)
					CHECK_TICK

				// Directly scale cooldown with how much they're creating
				COOLDOWN_START(src, rate_limit_belly_creation, BELLY_CREATION_COOLDOWN * amount_to_import)
				to_chat(living_parent, span_notice("All done importing bellies!"))
				save_bellies()
			catch(var/exception/e)
				tgui_alert(living_parent, "The supplied file contains errors: [e]", "Error!")
				return FALSE

			. = TRUE
		if("export_bellies")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return
			var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
			if(!vore_prefs)
				return
			vore_prefs.export_slot()
			. = TRUE
		if("test_fullscreen")
			if(living_parent.screens["vore"])
				to_chat(living_parent, span_warning("You can't preview belly fullscreens when you already have one visible."))
				return
			if(!living_parent.wants_vore_fullscreen())
				to_chat(living_parent, span_warning("You can't preview belly fullscreens when your preference is turned off."))
				return
			// We need a belly for this to be relative to, for recoloring
			var/obj/vore_belly/target = locate(params["ref"])
			if(!istype(target))
				return
			if(target.owner != src)
				return
			target.show_fullscreen(living_parent)
			addtimer(CALLBACK(src, PROC_REF(reset_vore_fullscreen)), 2 SECONDS)
			. = TRUE

/datum/component/vore/proc/reset_vore_fullscreen()
	var/mob/living/living_parent = parent
	living_parent.clear_fullscreen("vore", 1 SECONDS)

/datum/component/vore/proc/click_prey(mob/living/prey)
	var/mob/living/living_parent = parent

	if(prey == living_parent)
		living_parent.examinate(living_parent)
		return

	var/obj/vore_belly/prey_loc = prey.loc
	if(!istype(prey_loc))
		return

	// We are prey next to them
	if(prey_loc == living_parent.loc)
		click_fellow_prey(prey)
	// We ate them
	else if(prey_loc.owner == src)
		click_our_prey(prey)

/datum/component/vore/proc/click_fellow_prey(mob/living/prey)
	var/obj/vore_belly/prey_loc = prey.loc
	var/mob/living/pred = prey_loc.owner.parent
	var/mob/living/living_parent = parent

	var/list/options = list("Examine")

	// If not absorbed, able to do these
	if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE) && !HAS_TRAIT_FROM(living_parent, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		options += list("Interact", "Help Out")

	var/what_to_do = tgui_alert(living_parent, "What do you want to do to [prey]?", "Prey Options", options)
	// We have to check all of the conditions inside each of these branches because things could have changed while the
	// dialog was open.
	switch(what_to_do)
		if("Examine")
			living_parent.examinate(prey)
		if("Interact")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "[prey] is absorbed, you can't help them.")
				return
			if(HAS_TRAIT_FROM(living_parent, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "You're absorbed, you can't help someone out.")
				return
			living_parent.CtrlShiftClickOn(prey)
		if("Help Out")
			if(HAS_TRAIT_FROM(living_parent, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "You're absorbed, you can't help someone out.")
				return
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, "[prey] is absorbed, you can't help them.")
				return
			// If they're otherwise incapacitated
			if(living_parent.incapacitated)
				return

			to_chat(living_parent, span_notice(span_green("You begin to push [prey] to freedom!")))
			to_chat(prey, span_notice("[living_parent] begins to push you to freedom!"))
			to_chat(pred, span_warning("Someone is trying to escape from inside you!"))

			if(do_after(living_parent, 5 SECONDS, pred, timed_action_flags = IGNORE_TARGET_LOC_CHANGE) && prob(33))
				if(prey.loc != prey_loc)
					return
				prey_loc.release(prey)
				to_chat(living_parent, span_notice(span_green("You manage to help [prey] to safety!")))
				to_chat(prey,  span_notice(span_green("[living_parent] pushes you free!")))
				to_chat(pred, span_alert("[prey] forces free of the confines of your body!"))
			else
				to_chat(living_parent, span_alert("[prey] slips back down inside despite your efforts."))
				to_chat(prey, span_alert("Even with [living_parent]'s help, you slip back inside again."))
				to_chat(pred, span_notice(span_green("Your body efficiently shoves [prey] back where they belong.")))

/datum/component/vore/proc/click_our_prey(mob/living/prey)
	var/obj/vore_belly/prey_loc = prey.loc
	var/mob/living/living_parent = parent

	var/list/options = list("Examine")

	if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
		options += list("Eject", "Transfer", "Digest", "Absorb")
	else
		options += "Unabsorb"
		if(living_parent.ckey == our_owner_ckey)
			options += "Put In Charge"

	var/what_to_do = tgui_input_list(living_parent, "What do you want to do to [prey]?", "Prey Options", options)
	// We have to check all of the conditions inside each of these branches because things could have changed while the
	// dialog was open.
	switch(what_to_do)
		if("Examine")
			living_parent.examinate(prey)
		if("Eject")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("You cannot eject absorbed prey."))
				return
			#ifdef VORE_EJECT_DELAY
			to_chat(living_parent, span_notice("You start to work [prey] out of your [lowertext(prey_loc.name)]..."))
			to_chat(prey, span_notice("[living_parent] starts to work you out of their [lowertext(prey_loc.name)]..."))
			if(!do_after(living_parent, VORE_EJECT_DELAY, interaction_key = "vore_eject"))
				return
			#endif
			prey_loc.release(prey)
		if("Transfer")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("You cannot transfer absorbed prey."))
				return
			var/obj/vore_belly/which_belly = tgui_input_list(living_parent, "Which belly do you want to transfer them to?", "Belly Transfer", vore_bellies)
			if(which_belly && prey.loc == prey_loc)
				prey.forceMove(which_belly)
		if("Digest")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("You cannot digest absorbed prey."))
				return
			#if !REQUIRES_PLAYER
			if(!prey.mind)
				prey_loc.digestion_death(prey)
				return
			#endif
			var/datum/vore_preferences/prey_vore_prefs = prey.get_vore_prefs()
			if(!prey_vore_prefs)
				to_chat(living_parent, span_warning("[prey] isn't interested in being digested."))
				return
			if(!prey_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion) || !prey_vore_prefs.read_preference(/datum/vore_pref/toggle/digestion_qdel))
				to_chat(living_parent, span_warning("[prey] isn't interested in being digested."))
				return

			var/consents = tgui_alert(prey, "[living_parent] wants to instantly digest you, is this okay?", "Instant Gurgle", list("No", "Yes"))
			if(consents == "Yes")
				if(!prey_loc.digestion_death(prey))
					to_chat(living_parent, span_warning("[prey] isn't interested in being fully digested."))
			else
				to_chat(living_parent, span_warning("[prey] did not consent to the popup."))
		if("Absorb")
			if(HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("[prey] is already absorbed!"))
				return
			if(!prey.vore_can_absorb())
				to_chat(living_parent, "[prey] isn't interested in absorption.")
				return
			var/consents = tgui_alert(prey, "[living_parent] wants to instantly absorb you, is this okay?", "Instant Absorb", list("No", "Yes"))
			if(consents == "Yes")
				// Get the nutrition
				var/nutrition = prey.nutrition - ABSORB_NUTRITION_BARRIER
				if(nutrition > 0)
					prey.set_nutrition(ABSORB_NUTRITION_BARRIER)
					living_parent.adjust_nutrition(nutrition)
				if(!prey_loc.absorb(prey))
					to_chat(living_parent, "[prey] isn't interested in absorption.")
			else
				to_chat(living_parent, span_warning("[prey] did not consent to the popup."))
		if("Unabsorb")
			if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("[prey] is not absorbed!"))
				return
			if(living_parent.nutrition < ABSORB_NUTRITION_BARRIER)
				to_chat(living_parent, span_warning("You are too hungry to reform [prey]."))
				return
			living_parent.adjust_nutrition(-ABSORB_NUTRITION_BARRIER)
			prey_loc.unabsorb(prey)
		if("Put In Charge")
			if(living_parent.ckey != our_owner_ckey)
				to_chat(living_parent, span_warning("This is not available on vore components you do not own."))
				return

			if(!HAS_TRAIT_FROM(prey, TRAIT_RESTRAINED, TRAIT_SOURCE_VORE))
				to_chat(living_parent, span_warning("[prey] must be absorbed to be able to be put in control."))
				return

			var/consents = tgui_alert(prey, "[living_parent] wants to let you take control of their body, is this okay?", "Prey Control", list("No", "Yes"))
			if(consents == "Yes")
				living_parent.AddComponent(/datum/component/absorb_control, prey)
