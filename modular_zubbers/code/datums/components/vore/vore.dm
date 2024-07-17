/datum/action/innate/vore
	name = "Vore Grabbed"

/datum/action/innate/vore/panel
	name = "Vore Panel"

/datum/component/vore
	var/obj/vore_belly/selected_belly = null
	var/list/obj/vore_belly/vore_bellies = null
	var/datum/action/innate/vore/vore_action = null
	var/datum/action/innate/vore/panel/panel_action = null

/datum/component/vore/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	load_bellies_from_prefs(parent)
	vore_action = new(src)
	panel_action = new(src)
	RegisterSignal(vore_action, COMSIG_ACTION_TRIGGER, PROC_REF(vore))
	RegisterSignal(panel_action, COMSIG_ACTION_TRIGGER, PROC_REF(open_ui))
	vore_action.Grant(parent)
	panel_action.Grant(parent)

/datum/component/vore/Destroy(force)
	selected_belly = null
	QDEL_LIST(vore_bellies)
	QDEL_NULL(vore_action)
	QDEL_NULL(panel_action)
	return ..()

/datum/component/vore/proc/load_bellies_from_prefs(mob/living/parent)
	// TODO: actually make prefs
	// if(parent.prefs.vore)
	//	something
	// else
	selected_belly = new /obj/vore_belly/default(parent, src)

/datum/component/vore/proc/vore()
	SIGNAL_HANDLER
	var/mob/living/pred = parent
	if(!isliving(pred.pulling))
		to_chat(pred, span_warning("You need an aggressive grab to vore someone."))
		return
	var/mob/living/prey = pred.pulling
	if(pred.grab_state < GRAB_AGGRESSIVE)
		to_chat(pred, span_warning("You need an aggressive grab to vore someone."))
		return
	if(!selected_belly)
		to_chat(pred, span_warning("You must have a belly selected to vore someone."))
		return
	pred.visible_message(span_danger("[pred] devours [prey] whole!"), span_notice("You devour [prey] into your [selected_belly]."))
	prey.forceMove(selected_belly)
	// TODO: Maybe this should be in belly/Entered?
	to_chat(prey, examine_block(selected_belly.desc))
	// TODO: Squelch

/datum/component/vore/proc/open_ui()
	// SIGNAL_HANDLER // We do call a blocking proc, ui_interact, but it's brief
	ui_interact(parent)
