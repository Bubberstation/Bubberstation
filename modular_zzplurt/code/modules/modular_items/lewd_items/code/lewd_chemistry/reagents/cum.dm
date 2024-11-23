// Default type cum
/datum/reagent/consumable/cum/on_mob_add(mob/living/affected_mob, amount)
	. = ..()

	/*
	// Send signals for adding reagent
	SEND_SIGNAL(affected_mob, COMSIG_QUIRK_D4C_CONSUME)
	SEND_SIGNAL(affected_mob, COMSIG_QUIRK_CONCUBUS_CONSUME, src, amount)
	*/

	// Send signals for adding reagent
	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_ADD_CUM, src, amount)

// Female type cum
/datum/reagent/consumable/femcum/on_mob_add(mob/living/affected_mob, amount)
	. = ..()

	/*
	// Send signals for adding reagent
	SEND_SIGNAL(affected_mob, COMSIG_QUIRK_D4C_CONSUME)
	SEND_SIGNAL(affected_mob, COMSIG_QUIRK_CONCUBUS_CONSUME, src, amount)
	*/

	// Send signals for adding reagent
	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_ADD_CUM, src, amount)
