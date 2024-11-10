// Breast Milk metabolize
/datum/reagent/consumable/breast_milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Check for Concubus quirk
	if(HAS_TRAIT(affected_mob, TRAIT_CONCUBUS))
		// Check if nutrition is below full
		if(affected_mob.nutrition <= NUTRITION_LEVEL_FULL)
			// Adjust nutrition
			affected_mob.adjust_nutrition((CONCUBUS_NUTRITION_AMT * REAGENTS_METABOLISM * 2) * REM)

		// Continue processing
		current_cycle++

// Nuka Cola metabolize
/datum/reagent/consumable/nuka_cola/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	// Check for Rad Fiend
	if(HAS_TRAIT(affected_mob, TRAIT_RAD_FIEND))
		// Add mood bonus
		affected_mob.add_mood_event("fav_food", /datum/mood_event/favorite_food)
