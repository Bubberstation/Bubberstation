// Prevent processing for TRAIT_NO_PROCESS_FOOD
/datum/reagent/consumable/on_mob_life(mob/living/carbon/M)
	// Check for trait
	if(HAS_TRAIT(M, TRAIT_NO_PROCESS_FOOD))
		// Do nothing!
		return

	// Continue normally
	. = ..()
