/datum/action/innate/vore
	name = "Vore Grabbed"

/datum/action/innate/vore/panel
	name = "Vore Panel"

/atom/movable/screen/secret_appearance_holder
	invisibility = INVISIBILITY_MAXIMUM

/datum/component/vore
	var/obj/vore_belly/selected_belly = null
	var/list/obj/vore_belly/vore_bellies = null
	var/datum/action/innate/vore/vore_action = null
	var/datum/action/innate/vore/panel/panel_action = null
	var/atom/movable/screen/secret_appearance_holder/appearance_holder = null

/datum/component/vore/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/pred = parent
	load_bellies_from_prefs(pred)
	vore_action = new(src)
	panel_action = new(src)
	RegisterSignal(vore_action, COMSIG_ACTION_TRIGGER, PROC_REF(vore))
	RegisterSignal(panel_action, COMSIG_ACTION_TRIGGER, PROC_REF(open_ui))
	vore_action.Grant(pred)
	panel_action.Grant(pred)
	appearance_holder = new()
	pred.client.screen += appearance_holder

/datum/component/vore/Destroy(force)
	if(isliving(parent))
		var/mob/living/pred = parent
		pred.client?.screen -= appearance_holder
	selected_belly = null
	QDEL_NULL(appearance_holder)
	QDEL_LIST(vore_bellies)
	QDEL_NULL(vore_action)
	QDEL_NULL(panel_action)
	return ..()

/datum/component/vore/proc/load_bellies_from_prefs(mob/living/parent)
	// TODO: actually make prefs
	// if(parent.prefs.vore)
	//	something
	// else
	selected_belly = new /obj/vore_belly(parent, src)

/datum/component/vore/proc/check_can_vore(mob/living/prey)
	var/mob/living/pred = parent
	if(!selected_belly)
		to_chat(pred, span_warning("You must have a belly selected to vore someone."))
		return FALSE
	if(pred.grab_state < GRAB_AGGRESSIVE)
		to_chat(pred, span_warning("You need an aggressive grab to vore someone."))
		return FALSE
	if(!istype(prey))
		to_chat(pred, span_warning("You need an aggressive grab to vore someone."))
		return FALSE
	#if REQUIRES_PLAYER
	if(!prey.ckey)
		return FALSE
	#endif
	#if HUMAN_ONLY
	if(!ishuman(prey))
		return FALSE
	#endif
	return TRUE


/datum/component/vore/proc/vore()
	SIGNAL_HANDLER
	var/mob/living/pred = parent
	var/mob/living/prey = pred.pulling
	addtimer(CALLBACK(src, PROC_REF(do_the_vore), prey), 1)

/datum/component/vore/proc/do_the_vore(mob/living/prey)
	if(!prey)
		return
	var/mob/living/pred = parent
	if(!check_can_vore(prey))
		return
	#ifdef VORE_DELAY
	pred.visible_message(span_danger("[pred] starts to devour [prey] whole!"), span_danger("You start devouring [prey] into your [selected_belly]!"))
	if(!do_after(pred, VORE_DELAY, prey) || !check_can_vore(prey))
		pred.visible_message(span_notice("[pred] fails to devour [prey]."), span_notice("You fail to devour [prey]."))
		return
	#endif
	pred.visible_message(span_danger("[pred] devours [prey] whole!"), span_notice("You devour [prey] into your [selected_belly]."))
	prey.forceMove(selected_belly)
	// TODO: Maybe this should be in belly/Entered?
	to_chat(prey, examine_block(selected_belly.desc))
	// TODO: Squelch

/datum/component/vore/proc/open_ui()
	// SIGNAL_HANDLER // We do call a blocking proc, ui_interact, but it's brief
	ui_interact(parent)
