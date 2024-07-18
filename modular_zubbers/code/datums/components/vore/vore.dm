/datum/action/innate/vore

/datum/action/innate/vore/panel
	name = "Vore Panel"

/datum/action/innate/vore/pred
	name = "Vore Grabbed"

/datum/action/innate/vore/prey
	name = "Feed Self to Grabbed"

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
	var/obj/vore_belly/selected_belly = null
	var/list/obj/vore_belly/vore_bellies = null
	var/datum/action/innate/vore/panel/panel_action = null
	var/datum/action/innate/vore/pred/pred_action = null
	var/datum/action/innate/vore/prey/prey_action = null
	var/atom/movable/screen/secret_appearance_holder/appearance_holder = null

/datum/component/vore/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	load_bellies_from_prefs(parent)

	panel_action = new(src)
	RegisterSignal(panel_action, COMSIG_ACTION_TRIGGER, PROC_REF(open_ui))
	panel_action.Grant(parent)

	/// TODO: Only show pred action/appearance_holder to preds/switches
	pred_action = new(src)
	RegisterSignal(pred_action, COMSIG_ACTION_TRIGGER, PROC_REF(initiate_vore_other))
	pred_action.Grant(parent)

	appearance_holder = new()
	var/mob/living/L = parent
	if(L.client)
		L.client.screen += appearance_holder

	/// TODO: Only show pred action to preys/switches
	prey_action = new(src)
	RegisterSignal(prey_action, COMSIG_ACTION_TRIGGER, PROC_REF(initiate_feed_self_to_other))
	prey_action.Grant(parent)

/datum/component/vore/Destroy(force)
	if(isliving(parent))
		var/mob/living/pred = parent
		pred.client?.screen -= appearance_holder
	selected_belly = null
	QDEL_NULL(appearance_holder)
	QDEL_LIST(vore_bellies)
	QDEL_NULL(pred_action)
	QDEL_NULL(prey_action)
	QDEL_NULL(panel_action)
	return ..()

/datum/component/vore/proc/load_bellies_from_prefs(mob/living/parent)
	// TODO: actually make prefs
	// if(parent.prefs.vore)
	//	something
	// else
	selected_belly = new /obj/vore_belly(parent, src)

/datum/component/vore/proc/open_ui()
	SIGNAL_HANDLER // We do call a blocking proc, ui_interact, but it's brief
	INVOKE_ASYNC(src, PROC_REF(ui_interact), parent)

/// This is so complicated because we have to support three distinct use cases all in one proc:
/// 1. Pred eating prey, user = pred
/// 2. Prey feeding themselves to pred, user = prey
/// 3. A feeder feeding prey to pred, user = feeder
/proc/check_vore_preferences(mob/living/user, mob/living/pred, mob/living/prey)
	if(!istype(pred) || !istype(prey))
		return FALSE
	var/datum/component/vore/pred_component = pred.GetComponent(/datum/component/vore)
	if(!pred_component)
		to_chat(user, span_danger("[pred] isn't interested in mechanical vore."))
		return FALSE
	if(!pred_component.selected_belly)
		to_chat(user, span_danger("[pred] doesn't have a belly selected."))
		return FALSE
	// TODO: Limit how many prey fit in a pred
	var/datum/component/vore/prey_component = prey.GetComponent(/datum/component/vore)
	if(!prey_component)
		to_chat(user, span_danger("[prey] isn't interested in mechanical vore."))
		return FALSE
	#if REQUIRES_PLAYER
	if(!pred.ckey)
		to_chat(user, span_danger("[pred] isn't logged on."))
		return FALSE
	if(!prey.ckey)
		to_chat(user, span_danger("[prey] isn't logged on."))
		return FALSE
	#endif
	#if HUMAN_ONLY
	if(!ishuman(pred))
		to_chat(user, span_danger("[pred] isn't human."))
		return FALSE
	if(!ishuman(prey))
		to_chat(user, span_danger("[prey] isn't human."))
		return FALSE
	#endif
	// TODO: Check Player Prefs
	// if(!pred.is_pred && !pred.is_switch)
	// return FALSE
	// if(!prey.is_prey && !prey.is_switch)
	// return FALSE
	// TODO: Prevent Matryoshka
	return TRUE

/proc/check_vore_grab(mob/living/grabber)
	var/mob/living/grabee = grabber.pulling
	if(!istype(grabee))
		return FALSE
	if(grabber.grab_state < GRAB_AGGRESSIVE)
		return FALSE
	return TRUE

/datum/component/vore/proc/initiate_vore_other()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(vore_other))

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
	if(!check_vore_grab(pred) || !check_vore_preferences(parent, pred, prey))
		return
	#endif
	pred.visible_message(span_danger("[pred] devours [prey] whole!"), span_notice("You devour [prey] into your [selected_belly]."))
	complete_vore(prey)

/datum/component/vore/proc/initiate_feed_self_to_other()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(feed_self_to_other))

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
	if(!check_vore_grab(prey) || !check_vore_preferences(parent, pred, prey))
		return
	#endif
	prey.visible_message(span_danger("[prey] feeds themselves to [pred]!"), span_notice("You feed yourself to [pred]."))
	pred_component.complete_vore(prey)

/datum/component/vore/proc/complete_vore(mob/living/prey)
	prey.forceMove(selected_belly)
	// TODO: Maybe this should be in belly/Entered?
	to_chat(prey, examine_block(selected_belly.desc))
	// TODO: Squelch
