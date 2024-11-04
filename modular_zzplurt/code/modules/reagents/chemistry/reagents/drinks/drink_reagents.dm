/datum/reagent/consumable/milk/breast_milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Check for Incubus quirk
	if(HAS_TRAIT(affected_mob, TRAIT_CONCUBUS))
		// Add nutrition
		affected_mob.adjust_nutrition(nutriment_factor)

		// Continue processing
		current_cycle++

// Nuka Cola metabolize
/datum/reagent/consumable/nuka_cola/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	// Check for Rad Fiend
	if(HAS_TRAIT(affected_mob, TRAIT_RAD_FIEND))
		// Add mood bonus
		affected_mob.add_mood_event("fav_food", /datum/mood_event/favorite_food)
