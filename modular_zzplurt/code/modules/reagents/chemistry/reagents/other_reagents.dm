/**
 * This is a special reagent used by 'alternative food' quirks
 * It functionally matches Nutriment, but can be processed with liverless metabolism
 * It should not be used for any other purpose outside quirks
 */
/datum/reagent/consumable/notriment
	name = "Strange Nutriment"
	description = "An exotic form of nutriment produced by unusual digestive systems."
	reagent_state = /datum/reagent/consumable/nutriment::reagent_state
	nutriment_factor = /datum/reagent/consumable/nutriment::nutriment_factor
	color = /datum/reagent/consumable/nutriment::color
	// Allow processing without a liver
	self_consuming = TRUE

// Reagent process: Hell Water
/datum/reagent/hellwater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	// Check for Cursed Blood
	if(HAS_TRAIT(affected_mob, TRAIT_CURSED_BLOOD))
		// Send signal for processing reagent
		SEND_SIGNAL(affected_mob, COMSIG_REAGENT_PROCESS_HELLWATER, src, seconds_per_tick, times_fired)

		// Block other effects
		return

	// Run normally
	. = ..()

// Reagent metabolize: Holy Water
/datum/reagent/water/holywater/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_METABOLIZE_HOLYWATER)

// Reagent end metabolize: Holy Water
/datum/reagent/water/holywater/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_METABOLIZE_END_HOLYWATER)

// Reagent process: Holy Water
/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_PROCESS_HOLYWATER, src, seconds_per_tick, times_fired)

// Reagent expose: Holy Water
/datum/reagent/water/holywater/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()

	SEND_SIGNAL(exposed_mob, COMSIG_REAGENT_EXPOSE_HOLYWATER, src, methods, reac_volume, show_message, touch_protection)

// Reagent Add: Blood
/datum/reagent/blood/on_mob_add(mob/living/affected_mob, amount)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_ADD_BLOOD, src, amount, data)

// Reagent process: Salt Water
/datum/reagent/water/salt/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_PROCESS_SALT, src, seconds_per_tick, times_fired)

// Reagent expose: Salt Water
/datum/reagent/water/salt/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()

	SEND_SIGNAL(exposed_mob, COMSIG_REAGENT_EXPOSE_SALT, src, methods, reac_volume, show_message, touch_protection)
