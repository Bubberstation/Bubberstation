/obj/item/organ/internal/cyberimp/chest/nutriment/on_life()
	// Check if this user can process nutriment
	if(HAS_TRAIT(owner, TRAIT_NO_PROCESS_FOOD))
		return

	// Continue normally
	. = ..()
