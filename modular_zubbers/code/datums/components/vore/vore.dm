/datum/action/innate/vore_mode
	name = "Vore Mode"
	desc = "<b>Left Click</b> to switch into vore mode<br><b>Right click</b> to see the vore UI<br>When aggressively grabbing someone in vore mode:<br><ul><li>Click on <b>yourself</b> to eat them</li><li>Click on <b>them</b> to feed yourself to them</li><li>Click on <b>someone else</b> to feed them who you're holding</li></ul>"
	click_action = TRUE
	ranged_mousepointer = 'modular_zubbers/icons/effects/mouse_pointers/vore.dmi'
	default_button_position = "EAST-4:6,SOUTH+1:5" // We're bottom left, it's bottom right, it's perfect

	background_icon = 'modular_zubbers/icons/mob/actions/vore.dmi'
	background_icon_state = "bg"
	button_icon = 'modular_zubbers/icons/mob/actions/vore.dmi'
	button_icon_state = "nom"

// This is here so that we can use our custom background with support for bg_active
/datum/action/innate/vore_mode/apply_button_background(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	// Determine which icon to use
	background_icon_state = is_action_active(current_button) ? "bg_active" : "bg"

	if(current_button.active_underlay_icon_state == background_icon_state && !force)
		return

	// Make the underlay
	current_button.underlays.Cut()
	current_button.underlays += image(icon = background_icon, icon_state = background_icon_state)
	current_button.active_underlay_icon_state = background_icon_state

/datum/action/innate/vore_mode/Trigger(trigger_flags)
	var/datum/component/vore/V = target
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		V.ui_interact(owner)
		return TRUE
	return ..()

/datum/action/innate/vore_mode/do_ability(mob/living/caller, atom/clicked_on)
	var/datum/component/vore/V = target
	return V.on_voremode_click(caller, clicked_on)

/datum/action/innate/vore_mode/create_button()
	var/atom/movable/screen/movable/action_button/button = ..()
	button.mouse_drag_pointer = 'modular_zubbers/icons/effects/mouse_pointers/vore_drag.dmi'
	return button

/// This is a tricky little thing to guarantee that `\ref[prey.appearance]` works in the vore panel
/// Basically, we force the pred to load the prey's appearance by putting the prey in this screen object's vis_contents
/atom/movable/screen/secret_appearance_holder
	invisibility = INVISIBILITY_MAXIMUM

/// REMINDER: This component serves triple duty!
/// Everyone participating in mechanical vore must have this component for the UI
/// Preds must have this component to handle their bellies
/// Prey must have this component to handle the prey panel
/// Feeders must have this component to handle feeding preys to preds
/datum/component/vore
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/obj/vore_belly/selected_belly = null
	var/list/obj/vore_belly/vore_bellies = null

	// Save backups
	var/backup_number = 0
	var/our_owner_ckey = null
	var/non_owner_modified_settings = null

	var/vore_mode = FALSE
	var/datum/action/innate/vore_mode/vore_mode_action = null
	var/atom/movable/screen/secret_appearance_holder/appearance_holder = null

/datum/component/vore/Initialize(...)
	. = ..()
	if(!is_type_in_typecache(parent, GLOB.vore_allowed_mob_types))
		return COMPONENT_INCOMPATIBLE
	load_vore_prefs(parent)
	vore_mode_action = new(src)
	// Set screen_loc
	if(issilicon(parent))
		vore_mode_action.default_button_position = "CENTER+4:-30,SOUTH+1:6"
	if(isanimal_or_basicmob(parent))
		vore_mode_action.default_button_position = "EAST-2:-8,SOUTH+1:6"
	appearance_holder = new()
	var/mob/living/living_parent = parent
	our_owner_ckey = living_parent.ckey

/datum/component/vore/RegisterWithParent()
	vore_mode_action?.Grant(parent)
	add_appearance_holder()
	// Add the appearance holder back every time they login
	RegisterSignal(parent, COMSIG_MOB_LOGIN, PROC_REF(add_appearance_holder))

/datum/component/vore/proc/add_appearance_holder()
	var/mob/living/L = parent
	if(L.client && appearance_holder)
		L.client.screen += appearance_holder

// This has to be careful because it's called as a result of COMPONENT_INCOMPATIBLE
/datum/component/vore/UnregisterFromParent()
	vore_mode_action?.Remove(parent)
	var/mob/living/L = parent
	if(L.client && appearance_holder)
		L.client.screen -= appearance_holder
	UnregisterSignal(parent, COMSIG_MOB_LOGIN)

/datum/component/vore/Destroy(force)
	if(isliving(parent))
		var/mob/living/pred = parent
		pred.client?.screen -= appearance_holder
	selected_belly = null
	QDEL_LAZYLIST(vore_bellies)
	QDEL_NULL(appearance_holder)
	QDEL_NULL(vore_mode_action)
	return ..()

/datum/component/vore/proc/load_vore_prefs(mob/living/living_parent)
	if(living_parent.client)
		// Used for when people infect a second mob with vore, like aghosting
		var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
		vore_prefs?.reset_belly_layout_slot()
		load_bellies_from_prefs(living_parent.client)
		return

	return create_default_belly()

/datum/component/vore/proc/get_parent_vore_prefs()
	var/mob/living/living_parent = parent
	if(living_parent.client)
		return living_parent.get_vore_prefs()
	return null

/datum/component/vore/proc/load_bellies_from_prefs()
	var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
	if(!vore_prefs)
		return create_default_belly() // We always have to have our default belly
	var/list/belly_tree = vore_prefs.get_bellies()
	if(!LAZYLEN(belly_tree))
		return create_default_belly()

	for(var/belly in belly_tree)
		var/obj/vore_belly/new_belly = new /obj/vore_belly(parent, src)
		new_belly.deserialize(belly)
		if(!selected_belly)
			selected_belly = new_belly

/datum/component/vore/proc/clear_bellies()
	selected_belly = null
	QDEL_LAZYLIST(vore_bellies)

/datum/component/vore/proc/create_default_belly()
	selected_belly = new /obj/vore_belly(parent, src)
	save_bellies()

/// Returns TRUE if any of our bellies have prey in them
/datum/component/vore/proc/has_prey()
	for(var/obj/vore_belly/B as anything in vore_bellies)
		if(length(B.contents))
			return TRUE
	return FALSE

/datum/component/vore/proc/count_prey()
	var/count = 0
	for(var/obj/vore_belly/B as anything in vore_bellies)
		// Note: this must be changed if object vore is ever a thing
		count += LAZYLEN(B.contents)
	return count

/datum/component/vore/proc/download_belly_backup()
	var/mob/living/living_parent = parent
	if(living_parent.ckey)
		var/full_path = get_player_save_folder(living_parent.ckey)
		var/list/all_savefiles = flist("[full_path]/")

		var/list/entries_to_show = list()
		for(var/name in all_savefiles)
			if(findtext(name, "vore_backup_"))
				entries_to_show += "[name] - [time2text(ftime("[full_path]/[name]"))]"

		var/selected = tgui_input_list(usr, "Select a backup to download", "Vore Backups", entries_to_show)
		if(selected)
			var/filename = splittext(selected, " - ")[1]
			usr << ftp(file("[full_path]/[filename]"))
			to_chat(usr, "Attempting to send [selected], this may take a few minutes.")

/datum/component/vore/proc/save_belly_backup(special_name)
	var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
	if(!vore_prefs)
		return
	var/mob/living/living_parent = parent
	if(living_parent.ckey)
		backup_number = (backup_number + 1) % BELLY_BACKUP_COUNT
		var/savefile_path = "[get_player_save_folder(living_parent.ckey)]/vore_backup_[backup_number].json"
		if(special_name)
			savefile_path = "[get_player_save_folder(living_parent.ckey)]/vore_backup_[special_name].json"
		rustg_file_write(json_encode(vore_prefs.get_belly_export(), JSON_PRETTY_PRINT), savefile_path)

/// Slot argument allows you to forcibly save to a different slot
/datum/component/vore/proc/save_bellies(slot)
	// No usr, no save
	if(!usr?.ckey)
		return

	// Do not save if they are not our owner
	if(usr.ckey != our_owner_ckey)
		non_owner_modified_settings = usr.real_name
		return

	if(non_owner_modified_settings)
		var/confirmation = tgui_alert(usr, "Warning: Your bellies were changed by [non_owner_modified_settings]. Do you want to save these changes permanently?", "Dirty Belly Prefs", list("No", "Yes"))
		if(confirmation != "Yes")
			var/restore = tgui_alert(usr, "Do you want to undo all changes by [non_owner_modified_settings] and revert to your preferences? A backup of their changes will be created.", "Revert?", list("No", "Yes"))
			if(restore == "Yes")
				save_belly_backup("modified_[sanitize_filename(non_owner_modified_settings)]")
				clear_bellies()
				load_bellies_from_prefs()
			return
		save_belly_backup("modified_[sanitize_filename(non_owner_modified_settings)]")
		non_owner_modified_settings = null

	var/datum/vore_preferences/vore_prefs = get_parent_vore_prefs()
	if(!vore_prefs)
		return
	save_belly_backup()

	var/list/bellies = list()
	for(var/obj/vore_belly/B in vore_bellies)
		UNTYPED_LIST_ADD(bellies, B.serialize())

	vore_prefs.set_bellies(bellies, slot)

/datum/component/vore/proc/on_voremode_click(mob/living/user, mob/living/clicked_on)
	if(user != parent)
		return FALSE

	if(!istype(clicked_on))
		return FALSE

	if(!user.can_perform_action(clicked_on, clicked_on.interaction_flags_click | FORBID_TELEKINESIS_REACH))
		return

	if(user.click_intercept == vore_mode_action)
		vore_mode_action.unset_ranged_ability(user)
		vore_mode_action.build_all_button_icons(UPDATE_BUTTON_BACKGROUND | UPDATE_BUTTON_STATUS)

	if(!check_vore_grab(user))
		to_chat(user, span_danger("You must have an aggressive grab to do vore."))
		return TRUE
	var/mob/living/pulled = user.pulling

	if(clicked_on == user) // Parent wants to eat pulled
		vore_other()
	else if(clicked_on == pulled) // Parent wants to feed themselves to pulled
		feed_self_to_other()
	else // Parent wants to feed pulled to clicked_on
		feed_other_to_other(clicked_on)
	return TRUE

/// This is so complicated because we have to support three distinct use cases all in one proc:
/// 1. Pred eating prey, user = pred
/// 2. Prey feeding themselves to pred, user = prey
/// 3. A feeder feeding prey to pred, user = feeder
/// assume_active_consent is used for the secondary check after the do_after to avoid prompting prey/preds twice
/proc/check_vore_preferences(mob/living/user, mob/living/pred, mob/living/prey, assume_active_consent = FALSE)
	if(!istype(pred) || !istype(prey))
		return FALSE
	var/datum/component/vore/pred_component = pred.GetComponent(/datum/component/vore)
	if(!pred_component)
		log_game("[user] tried to feed [prey] to [pred] but pred had vore disabled")
		to_chat(user, span_danger("[pred] isn't interested in mechanical vore."))
		return FALSE
	if(!pred_component.selected_belly)
		to_chat(user, span_danger("[pred] doesn't have a belly selected."))
		return FALSE
	if(pred_component.count_prey() >= MAX_PREY)
		to_chat(user, span_danger("[pred] is too full to eat more."))
		return FALSE
	var/datum/component/vore/prey_component = prey.GetComponent(/datum/component/vore)
	if(!prey_component)
		log_game("[user] tried to feed [prey] to [pred] but prey had vore disabled")
		to_chat(user, span_danger("[prey] isn't interested in mechanical vore."))
		return FALSE
	#if MATRYOSHKA_BANNED
	if(prey_component.has_prey())
		return FALSE
	#endif
	#if REQUIRES_PLAYER
	if(!pred.client)
		log_game("[user] tried to feed [prey] to [pred] but pred was logged off")
		to_chat(user, span_danger("[pred] isn't logged on."))
		return FALSE
	if(!prey.client)
		log_game("[user] tried to feed [prey] to [pred] but prey was logged off")
		to_chat(user, span_danger("[prey] isn't logged on."))
		return FALSE
	#endif
	#if NO_DEAD
	if(pred.stat)
		to_chat(user, span_danger("[pred] doesn't look healthy enough to feed."))
		return FALSE
	if(prey.stat)
		to_chat(user, span_danger("[prey] doesn't look healthy enough to eat."))
		return FALSE
	#endif
	if(!is_type_in_typecache(pred, GLOB.vore_allowed_mob_types))
		return FALSE
	if(!is_type_in_typecache(prey, GLOB.vore_allowed_mob_types))
		return FALSE

	if(prey.buckled)
		to_chat(user, span_danger("[prey] is buckled."))
		return FALSE
	if(prey.has_buckled_mobs())
		to_chat(user, span_danger("[prey] has buckled mobs."))
		return FALSE

	// Check pred prefs
	// These are structured like this so that we automatically succeed for components without a client
	// REQUIRES_PLAYER is checked above
	var/datum/vore_preferences/pred_prefs = pred.get_vore_prefs()
	if(pred_prefs)
		var/allowed_to_pred = FALSE

		var/pred_trinary = pred_prefs.read_preference(/datum/vore_pref/trinary/pred)
		switch(pred_trinary)
			if(PREF_TRINARY_NEVER)
				allowed_to_pred = FALSE
			if(PREF_TRINARY_PROMPT)
				// presumably they consent to what they're doing if they initiated it
				if(assume_active_consent || pred == user)
					allowed_to_pred = TRUE
				else
					to_chat(user, span_warning("Please wait, [pred] is deciding if they want to eat [prey]..."))
					if(tgui_alert(pred, "[user] is trying to feed [prey] to you, are you okay with this?", "Pred Pref", list("Yes", "No")) == "Yes")
						allowed_to_pred = TRUE
			if(PREF_TRINARY_ALWAYS)
				allowed_to_pred = TRUE

		if(!allowed_to_pred)
			log_game("[key_name(user)] tried to feed [key_name(prey)] to [key_name(pred)] and was rejected by pred [key_name(pred)]")
			to_chat(user, span_warning("[pred] isn't interested in being a pred."))
			return FALSE

	// Check prey prefs
	var/datum/vore_preferences/prey_prefs = prey.get_vore_prefs()
	if(prey_prefs)
		var/allowed_to_prey = FALSE

		var/prey_trinary = prey_prefs.read_preference(/datum/vore_pref/trinary/prey)
		switch(prey_trinary)
			if(PREF_TRINARY_NEVER)
				allowed_to_prey = FALSE
			if(PREF_TRINARY_PROMPT)
				// presumably they consent to what they're doing if they initiated it
				if(assume_active_consent || prey == user)
					allowed_to_prey = TRUE
				else
					to_chat(user, span_warning("Please wait, [prey] is deciding if they want to be fed to [pred]..."))
					if(tgui_alert(prey, "[user] is trying to feed you to [pred], are you okay with this?", "Prey Pref", list("Yes", "No")) == "Yes")
						allowed_to_prey = TRUE
			if(PREF_TRINARY_ALWAYS)
				allowed_to_prey = TRUE

		if(!allowed_to_prey)
			log_game("[key_name(user)] tried to feed [key_name(prey)] to [key_name(pred)] and was rejected by prey [key_name(prey)]")
			to_chat(user, span_warning("[prey] isn't interested in being prey."))
			return FALSE

	return TRUE

/proc/check_vore_grab(mob/living/grabber)
	var/mob/living/grabee = grabber.pulling
	if(!istype(grabee))
		return FALSE
	if(ishuman(grabber) && grabber.grab_state < GRAB_AGGRESSIVE)
		return FALSE
	return TRUE

/datum/component/vore/proc/vore_other(mob/living/prey)
	var/mob/living/pred = parent
	if(!prey)
		prey = pred.pulling
	if(!check_vore_grab(pred) && !istype(prey.loc, /obj/item/clothing/head/mob_holder))
		to_chat(parent, span_danger("You must have a[ishuman(pred) ? "n aggressive" : ""] grab to eat someone."))
		return
	if(!check_vore_preferences(parent, pred, prey))
		return
	#ifdef VORE_DELAY
	pred.visible_message(span_danger("[pred] is attempting to [lowertext(selected_belly.insert_verb)] [prey] into their [lowertext(selected_belly.name)]!"), pref_to_check = /datum/preference/toggle/erp/vore_enable)
	if(!do_after(pred, VORE_DELAY, prey))
		return
	if((!check_vore_grab(pred) && !istype(prey.loc, /obj/item/clothing/head/mob_holder)) || !check_vore_preferences(parent, pred, prey, assume_active_consent = TRUE))
		return
	#endif
	pred.visible_message(span_danger("[pred] manages to [lowertext(selected_belly.insert_verb)] [prey] into their [lowertext(selected_belly.name)]!"), pref_to_check = /datum/preference/toggle/erp/vore_enable)
	complete_vore(prey)

/datum/component/vore/proc/feed_self_to_other()
	var/mob/living/prey = parent
	if(!check_vore_grab(prey))
		to_chat(parent, span_danger("You must have a[ishuman(prey) ? "n aggressive" : ""] grab to feed yourself to someone."))
		return
	var/mob/living/pred = prey.pulling
	if(!check_vore_preferences(parent, pred, prey))
		return
	// check_vore_preferences asserts this exists
	var/datum/component/vore/pred_component = pred.GetComponent(/datum/component/vore)
	#ifdef VORE_DELAY
	prey.visible_message(span_danger("[prey] is attempting to make [pred] [lowertext(pred_component.selected_belly.insert_verb)] [prey] into their [lowertext(pred_component.selected_belly.name)]!"), pref_to_check = /datum/preference/toggle/erp/vore_enable)
	if(!do_after(prey, VORE_DELAY, pred))
		return
	if(!check_vore_grab(prey) || !check_vore_preferences(parent, pred, prey, assume_active_consent = TRUE))
		return
	#endif
	prey.visible_message(span_danger("[prey] manages to make [pred] [lowertext(pred_component.selected_belly.insert_verb)] [prey] into their [lowertext(pred_component.selected_belly.name)]!"), pref_to_check = /datum/preference/toggle/erp/vore_enable)
	pred_component.complete_vore(prey)

/datum/component/vore/proc/feed_other_to_other(mob/living/pred, mob/living/prey)
	var/mob/living/feeder = parent
	if(!prey)
		prey = feeder.pulling
	if(!check_vore_grab(feeder) && !istype(prey.loc, /obj/item/clothing/head/mob_holder))
		to_chat(feeder, span_danger("You must have a[ishuman(feeder) ? "n aggressive" : ""] grab to feed someone to someone else."))
		return
	if(!feeder.can_perform_action(pred, pred.interaction_flags_click | FORBID_TELEKINESIS_REACH))
		return
	if(!check_vore_preferences(feeder, pred, prey))
		return
	// check_vore_preferences asserts this exists
	var/datum/component/vore/pred_component = pred.GetComponent(/datum/component/vore)
	#ifdef VORE_DELAY
	feeder.visible_message(span_danger("[feeder] is attempting to make [pred] [lowertext(pred_component.selected_belly.insert_verb)] [prey] into their [lowertext(pred_component.selected_belly.name)]!"), pref_to_check = /datum/preference/toggle/erp/vore_enable)
	if(!do_after(feeder, VORE_DELAY, pred))
		return
	if((!check_vore_grab(pred) && !istype(prey.loc, /obj/item/clothing/head/mob_holder)) || !check_vore_preferences(feeder, pred, prey, assume_active_consent = TRUE))
		return
	if(!feeder.can_perform_action(pred, pred.interaction_flags_click | FORBID_TELEKINESIS_REACH))
		return
	#endif
	feeder.visible_message(span_danger("[feeder] manages to make [pred] [lowertext(pred_component.selected_belly.insert_verb)] [prey] into their [lowertext(pred_component.selected_belly.name)]!"), pref_to_check = /datum/preference/toggle/erp/vore_enable)
	pred_component.complete_vore(prey)

/datum/component/vore/proc/complete_vore(mob/living/prey)
	prey.forceMove(selected_belly)


/************/
/*  Sounds  */
/************/
/// Plays a different prey and pred sound to our owner and ALL of our prey
/datum/component/vore/proc/play_vore_sound_preypred(preysound, predsound, volume = VORE_SOUND_VOLUME, range = 2, vary = FALSE, pref = /datum/vore_pref/toggle/eating_noises)
	var/turf/turf_source = get_turf(parent)
	var/sound/prey_sound = isdatum(preysound) ? preysound : sound(get_vore_sfx(preysound))
	var/sound/pred_sound = isdatum(predsound) ? predsound : sound(get_vore_sfx(predsound))

	// We never go through walls so get_hearers_in_view is fine
	// It'll also cover our parent and their belly contents via spatial_grid
	var/list/listeners = get_hearers_in_view(range, parent)

	// Note: because ghosts can't have vore prefs, we can't send sounds to them :(
	for(var/mob/living/listening_mob in listeners)
		if(get_dist(listening_mob, turf_source) > range)
			continue
		var/datum/vore_preferences/listener_vore_prefs = listening_mob.get_vore_prefs()
		if(!listener_vore_prefs)
			continue
		var/pref_enabled = listener_vore_prefs.read_preference(pref)
		if(!pref_enabled)
			continue

		// Needed because playsound_local runtimes at range = 1
		var/range_to_use = range
		if(range_to_use < 2)
			range_to_use = 0

		if(istype(listening_mob.loc, /obj/vore_belly))
			listening_mob.playsound_local(
				turf_source, preysound, volume, vary,
				sound_to_use = prey_sound,
				max_distance = range,
			)
		else
			listening_mob.playsound_local(
				turf_source, predsound, volume, vary,
				sound_to_use = pred_sound,
				max_distance = range,
			)

/datum/component/vore/proc/play_vore_sound(soundin, volume = VORE_SOUND_VOLUME, range = 2, vary = FALSE, pref = /datum/vore_pref/toggle/eating_noises)
	var/turf/turf_source = get_turf(parent)
	var/sound/S = isdatum(soundin) ? soundin : sound(get_vore_sfx(soundin))

	// We never go through walls so get_hearers_in_view is fine
	// It'll also cover our parent and their belly contents via spatial_grid
	var/list/listeners = get_hearers_in_view(range, parent)

	// Note: because ghosts can't have vore prefs, we can't send sounds to them :(
	for(var/mob/living/listening_mob in listeners)
		if(get_dist(listening_mob, turf_source) > range)
			continue
		var/datum/vore_preferences/listener_vore_prefs = listening_mob.get_vore_prefs()
		if(!listener_vore_prefs)
			continue
		var/pref_enabled = listener_vore_prefs.read_preference(pref)
		if(!pref_enabled)
			continue

		// Needed because playsound_local runtimes at range = 1
		var/range_to_use = range
		if(range_to_use < 2)
			range_to_use = 0

		listening_mob.playsound_local(
			turf_source, soundin, volume, vary,
			sound_to_use = S,
			max_distance = range,
		)

/proc/get_vore_sfx(soundin)
	switch(soundin)
		if("vore_sounds_death_fancy")
			return pick(GLOB.vore_sounds_death_fancy)
		if("vore_sounds_death_fancy_prey")
			return pick(GLOB.vore_sounds_death_fancy_prey)
		if("vore_sounds_death_classic")
			return pick(GLOB.vore_sounds_death_classic)
		if("vore_sounds_digestion_classic")
			return pick(GLOB.vore_sounds_digestion_classic)
		if("vore_sounds_digestion_fancy")
			return pick(GLOB.vore_sounds_digestion_fancy)
		if("vore_sounds_digestion_fancy_prey")
			return pick(GLOB.vore_sounds_digestion_fancy_prey)
		if("vore_sounds_struggle_fancy")
			return pick(GLOB.vore_sounds_struggle_fancy)
		if("vore_sounds_struggle_classic")
			return pick(GLOB.vore_sounds_struggle_classic)
		if("rustle")
			return get_sfx(SFX_RUSTLE)
	return soundin
