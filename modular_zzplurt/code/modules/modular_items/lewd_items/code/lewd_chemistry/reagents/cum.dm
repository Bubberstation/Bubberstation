// Default type
/datum/reagent/consumable/cum/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Check for Succubus quirk
	if(HAS_TRAIT(affected_mob, TRAIT_SUCCUBUS))
		// Add nutrition
		affected_mob.adjust_nutrition(nutriment_factor)

		// Continue processing
		current_cycle++

// Female type
/datum/reagent/consumable/femcum/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Check for Succubus quirk
	if(HAS_TRAIT(affected_mob, TRAIT_SUCCUBUS))
		// Add nutrition
		affected_mob.adjust_nutrition(nutriment_factor)

		// Continue processing
		current_cycle++
