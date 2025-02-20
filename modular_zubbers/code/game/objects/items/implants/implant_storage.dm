//Prevents super and normal cats from having storage implants. Normal cats don't have hands anyways!
/obj/item/implant/storage/can_be_implanted_in(mob/living/target)
	. = ..()
	if(iscat(target))
		return FALSE
