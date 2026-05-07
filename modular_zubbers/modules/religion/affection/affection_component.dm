/datum/component/affection_favor
	var/datum/religion_sect/affection/favor_destination

/datum/component/affection_favor/Initialize(datum/religion_sect/affection/destination)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	favor_destination = destination
	RegisterSignal(parent, COMSIG_CARBON_HELP_ACT, PROC_REF(received_affection))
	RegisterSignal(parent, COMSIG_INTERACTION_PANEL_ACT, PROC_REF(interaction_paneled))

/datum/component/affection_favor/proc/received_affection(mob/living/receiver, mob/living/helper)
	SIGNAL_HANDLER

	if(receiver == helper)
		return

	if(receiver.body_position == LYING_DOWN)
		return

	favor_destination.adjust_favor(5, parent)

/datum/component/affection_favor/proc/interaction_paneled(mob/living/receiver, mob/living/helper)
	SIGNAL_HANDLER

	if(receiver == helper)
		return

	favor_destination.adjust_favor(5, parent)
