/datum/component/affection_favor
	var/datum/religion_sect/affection/favor_destination
	var/list/mob/cooldown_mobs = list()
	var/affection_cooldown = 1 MINUTES

/datum/component/affection_favor/Initialize(datum/religion_sect/affection/destination)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	favor_destination = destination
	RegisterSignal(parent, COMSIG_CARBON_HELP_ACT, PROC_REF(received_affection))
	RegisterSignal(parent, COMSIG_INTERACTION_PANEL_ACT, PROC_REF(interaction_paneled))

/datum/component/affection_favor/proc/received_affection(mob/living/receiver, mob/living/helper)
	SIGNAL_HANDLER

	if (helper in cooldown_mobs)
		return

	if(receiver == helper)
		return

	if(receiver.body_position == LYING_DOWN)
		return
	if(is_in_chapel())
		favor_destination.adjust_favor(favor_destination.favor_gain * favor_destination.chapel_gain_multiplier, parent)
		cooldown_mobs += helper
		addtimer(CALLBACK(src, PROC_REF(finish_cooldown), helper), affection_cooldown)
		return

	favor_destination.adjust_favor(favor_destination.favor_gain, parent)
	cooldown_mobs += helper
	addtimer(CALLBACK(src, PROC_REF(finish_cooldown), helper), affection_cooldown)

/datum/component/affection_favor/proc/interaction_paneled(mob/living/receiver, mob/living/helper)
	SIGNAL_HANDLER

	if (helper in cooldown_mobs)
		return

	if(receiver == helper)
		return
	if(is_in_chapel())
		favor_destination.adjust_favor(favor_destination.favor_gain * favor_destination.chapel_gain_multiplier, parent)
		cooldown_mobs += helper
		addtimer(CALLBACK(src, PROC_REF(finish_cooldown), helper), affection_cooldown)
		return
	favor_destination.adjust_favor(favor_destination.favor_gain, parent)
	cooldown_mobs += helper
	addtimer(CALLBACK(src, PROC_REF(finish_cooldown), helper), affection_cooldown)

/datum/component/affection_favor/proc/is_in_chapel()
	var/area/current_area = get_area(parent)
	return istype(current_area, /area/station/service/chapel)

/datum/component/affection_favor/proc/finish_cooldown(mob/uncooled)
	cooldown_mobs -= uncooled
