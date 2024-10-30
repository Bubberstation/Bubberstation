/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Check for Incubus quirk
	if(HAS_TRAIT(affected_mob, TRAIT_CONCUBUS))
		// Add nutrition
		affected_mob.adjust_nutrition(nutriment_factor)

		// Continue processing
		current_cycle++
