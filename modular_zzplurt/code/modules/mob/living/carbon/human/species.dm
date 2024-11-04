/datum/species/New()
	var/list/extra_offset_features = list(
		OFFSET_UNDERWEAR = list(0,0),
		OFFSET_SOCKS = list(0,0),
		OFFSET_SHIRT = list(0,0),
		OFFSET_WRISTS = list(0,0)
	)
	LAZYADD(offset_features, extra_offset_features)
	. = ..()

// Radiation handling
// Currently unused
/*
/datum/species/handle_radiation(mob/living/carbon/human/target_mob)
	// Check for Rad Fiend quirk
	if(HAS_TRAIT(target_mob, TRAIT_RAD_FIEND))
		// Define radiation component
		var/datum/component/irradiated/rad_effect = target_mob.GetComponent(/datum/component/irradiated)

		// Check if time threshold is met
		if(rad_effect?.beginning_of_irradiation < RADFIEND_IMMUNITY_TIME)
			// Return without effects
			return

	// Run normally
	. = ..()
*/
