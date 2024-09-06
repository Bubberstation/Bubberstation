/obj/item/fugu_gland/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. == ITEM_INTERACT_SUCCESS)
		animal.update_size(2)
