/obj/item/fugu_gland/interact_with_atom(mob/living/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. == ITEM_INTERACT_SUCCESS)
		interacting_with.update_size(2)
