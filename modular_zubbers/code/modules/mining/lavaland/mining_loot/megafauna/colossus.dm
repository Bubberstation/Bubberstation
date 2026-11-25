/obj/item/organ/vocal_cords/colossus/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/silicon/robot/robot = interacting_with
	if(!istype(robot))
		return NONE
	if(!robot.opened)
		to_chat(user, span_warning("[robot] must be opened to insert this item."))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("You insert [src] into [robot]."))
	var/datum/action/cooldown/spell/voice_of_god/voice = new
	voice.Grant(robot)
	if(!user.dropItemToGround(src, TRUE, TRUE))
		to_chat(user, span_notice("You are unable to drop [src]."))
		return ITEM_INTERACT_BLOCKING
	forceMove(robot)
	RegisterSignal(robot, COMSIG_BORG_SAFE_DECONSTRUCT, PROC_REF(on_silicon_decon))
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/vocal_cords/colossus/proc/on_silicon_decon()
	forceMove(get_turf(loc))
