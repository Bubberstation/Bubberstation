/datum/action/innate/vore

/datum/action/innate/vore/panel
	name = "Vore Panel"

/datum/action/innate/vore/vore_mode
	name = "Vore Mode"
	click_action = TRUE
	ranged_mousepointer = 'modular_zubbers/icons/effects/mouse_pointers/vore.dmi'

/datum/action/innate/vore/vore_mode/do_ability(mob/living/caller, atom/clicked_on)
	var/datum/component/vore/V = target
	return V.on_voremode_click(caller, clicked_on)

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

	var/datum/vore_preferences/vore_prefs

	var/obj/vore_belly/selected_belly = null
	var/list/obj/vore_belly/vore_bellies = null
	var/datum/action/innate/vore/panel/panel_action = null
	var/datum/action/innate/vore/vore_mode/vore_mode_action = null
	var/vore_mode = FALSE
	var/atom/movable/screen/secret_appearance_holder/appearance_holder = null

/datum/component/vore/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	load_vore_prefs(parent)

	panel_action = new(src)
	RegisterSignal(panel_action, COMSIG_ACTION_TRIGGER, PROC_REF(open_ui))
	vore_mode_action = new(src)

	appearance_holder = new()

/datum/component/vore/RegisterWithParent()
	panel_action.Grant(parent)
	vore_mode_action.Grant(parent)

	var/mob/living/L = parent
	if(L.client)
		L.client.screen += appearance_holder

/datum/component/vore/UnregisterFromParent()
	panel_action.Remove(parent)
	vore_mode_action.Remove(parent)

	var/mob/living/L = parent
	if(L.client)
		L.client.screen += appearance_holder

/datum/component/vore/Destroy(force)
	if(isliving(parent))
		var/mob/living/pred = parent
		pred.client?.screen -= appearance_holder
	selected_belly = null
	QDEL_NULL(appearance_holder)
	QDEL_LIST(vore_bellies)
	QDEL_NULL(panel_action)
	QDEL_NULL(vore_mode_action)
	return ..()

/datum/component/vore/proc/load_vore_prefs(mob/living/living_parent)
	if(living_parent.client?.prefs?.savefile)
		vore_prefs = new(living_parent.client.prefs.savefile)

		var/list/pref_tree = living_parent.client.prefs.get_save_data_for_savefile_identifier(PREFERENCE_CHARACTER)
		var/list/vore_tree = pref_tree["vore"]
		if(!LAZYLEN(vore_tree))
			return create_default_belly()

		var/list/belly_tree = vore_tree["bellies"]
		if(!LAZYLEN(belly_tree))
			return create_default_belly()

		for(var/belly in belly_tree)
			var/obj/vore_belly/new_belly = new /obj/vore_belly(parent, src)
			if(!selected_belly)
				selected_belly = new_belly
			new_belly.deserialize(belly)
		return

	return create_default_belly()


/datum/component/vore/proc/create_default_belly()
	selected_belly = new /obj/vore_belly(parent, src)
	save_bellies()

/// Returns TRUE if any of our bellies have prey in them
/datum/component/vore/proc/has_prey()
	for(var/obj/vore_belly/B in vore_bellies)
		if(length(B.contents))
			return TRUE
	return FALSE

/datum/component/vore/proc/save_bellies()
	var/mob/living/living_parent = parent
	if(living_parent.client)
		var/datum/preferences/prefs = living_parent.client.prefs
		var/list/current_prefs = prefs.get_save_data_for_savefile_identifier(PREFERENCE_CHARACTER)

		var/list/bellies = list()
		for(var/obj/vore_belly/B in vore_bellies)
			UNTYPED_LIST_ADD(bellies, B.serialize())

		if(!("vore" in current_prefs))
			current_prefs["vore"] = list()
		var/list/vore = current_prefs["vore"]
		vore["bellies"] = bellies

		current_prefs["vore"] = vore

		prefs.save_preferences()

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


/datum/component/vore/proc/open_ui()
	SIGNAL_HANDLER // We do call a blocking proc, ui_interact, but it's brief
	INVOKE_ASYNC(src, PROC_REF(ui_interact), parent)

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
	// TODO: Limit how many prey fit in a pred
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
	if(!is_type_in_typecache(pred, GLOB.vore_allowed_mob_types))
		return FALSE
	if(!is_type_in_typecache(prey, GLOB.vore_allowed_mob_types))
		return FALSE

	// Check pred prefs
	if(pred_component.vore_prefs)
		var/allowed_to_pred = FALSE

		var/pred_trinary = pred_component.vore_prefs.read_preference(/datum/vore_pref/trinary/pred)
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
	if(prey_component.vore_prefs)
		var/allowed_to_prey = FALSE

		var/prey_trinary = prey_component.vore_prefs.read_preference(/datum/vore_pref/trinary/prey)
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
	if(grabber.grab_state < GRAB_AGGRESSIVE)
		return FALSE
	return TRUE

/datum/component/vore/proc/vore_other()
	var/mob/living/pred = parent
	if(!check_vore_grab(pred))
		to_chat(parent, span_danger("You must have an aggressive grab to eat someone."))
		return
	var/mob/living/prey = pred.pulling
	if(!check_vore_preferences(parent, pred, prey))
		return
	#ifdef VORE_DELAY
	pred.visible_message(span_danger("[pred] starts to devour [prey] whole!"), span_danger("You start devouring [prey] into your [selected_belly]!"))
	if(!do_after(pred, VORE_DELAY, prey))
		pred.visible_message(span_notice("[pred] fails to devour [prey]."), span_notice("You fail to devour [prey]."))
		return
	if(!check_vore_grab(pred) || !check_vore_preferences(parent, pred, prey, assume_active_consent = TRUE))
		return
	#endif
	pred.visible_message(span_danger("[pred] devours [prey] whole!"), span_notice("You devour [prey] into your [selected_belly]."))
	complete_vore(prey)

/datum/component/vore/proc/feed_self_to_other()
	var/mob/living/prey = parent
	if(!check_vore_grab(prey))
		to_chat(parent, span_danger("You must have an aggressive grab to feed yourself to someone."))
		return
	var/mob/living/pred = prey.pulling
	if(!check_vore_preferences(parent, pred, prey))
		return
	// check_vore_preferences asserts this exists
	var/datum/component/vore/pred_component = pred.GetComponent(/datum/component/vore)
	#ifdef VORE_DELAY
	prey.visible_message(span_danger("[prey] starts to feed themselves to [pred]!"), span_notice("You start feeding yourself to [pred]."))
	if(!do_after(prey, VORE_DELAY, pred))
		prey.visible_message(span_notice("[prey] fails to feed themselves to [pred]."), span_notice("You fail to feed yourself to [pred]."))
		return
	if(!check_vore_grab(prey) || !check_vore_preferences(parent, pred, prey, assume_active_consent = TRUE))
		return
	#endif
	prey.visible_message(span_danger("[prey] feeds themselves to [pred]!"), span_notice("You feed yourself to [pred]."))
	pred_component.complete_vore(prey)

/datum/component/vore/proc/feed_other_to_other(mob/living/pred)
	var/mob/living/feeder = parent
	if(!check_vore_grab(feeder))
		to_chat(feeder, span_danger("You must have an aggressive grab to feed someone to someone else."))
		return
	if(!feeder.can_perform_action(pred, pred.interaction_flags_click | FORBID_TELEKINESIS_REACH))
		return
	var/mob/living/prey = feeder.pulling
	if(!check_vore_preferences(feeder, pred, prey))
		return
	// check_vore_preferences asserts this exists
	var/datum/component/vore/pred_component = pred.GetComponent(/datum/component/vore)
	#ifdef VORE_DELAY
	feeder.visible_message(span_danger("[feeder] starts to feed [prey] to [pred]!"), span_notice("You start feeding [prey] to [pred]."))
	if(!do_after(feeder, VORE_DELAY, pred))
		feeder.visible_message(span_notice("[feeder] fails to feed [prey] to [pred]."), span_notice("You fail to feed [prey] to [pred]."))
		return
	if(!check_vore_grab(feeder) || !check_vore_preferences(feeder, pred, prey, assume_active_consent = TRUE))
		return
	if(!feeder.can_perform_action(pred, pred.interaction_flags_click | FORBID_TELEKINESIS_REACH))
		return
	#endif
	feeder.visible_message(span_danger("[feeder] feeds [prey] to [pred]!"), span_notice("You feed [prey] to [pred]."))
	pred_component.complete_vore(prey)

/datum/component/vore/proc/complete_vore(mob/living/prey)
	prey.forceMove(selected_belly)
