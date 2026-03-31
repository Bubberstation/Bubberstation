/obj/item/mining_stabilizer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isorgan(interacting_with))
		return NONE
	var/obj/item/organ/monster_core/target_core = interacting_with
	if (!istype(target_core))
		balloon_alert(user, "invalid target!")
		return ITEM_INTERACT_BLOCKING

	if (isnull(target_core.decay_timer))
		balloon_alert(user, "already stable!")
		return ITEM_INTERACT_BLOCKING

	if (!target_core.preserve())
		balloon_alert(user, "organ decayed!")
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "organ stabilized")
	qdel(src)
	return ITEM_INTERACT_SUCCESS
