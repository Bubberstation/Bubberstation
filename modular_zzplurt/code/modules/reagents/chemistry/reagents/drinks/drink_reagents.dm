// Reagent add: Breast Milk
/datum/reagent/consumable/breast_milk/on_mob_add(mob/living/affected_mob, amount)
	. = ..()

	// Send signal for adding reagent
	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_ADD_BREASTMILK, src, amount)

// Reagent metabolize: Nuka Cola
/datum/reagent/consumable/nuka_cola/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	// Send signal for adding reagent
	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_METABOLIZE_NUKACOLA)
