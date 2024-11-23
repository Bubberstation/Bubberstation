// Handle radiation damage
// Currently unused
/*
/datum/component/irradiated/process_tox_damage(mob/living/carbon/human/target, seconds_per_tick)
	// Check for Rad Fiend quirk
	if(HAS_TRAIT(target_mob, TRAIT_RAD_FIEND))
		// Check if time threshold is met
		if(beginning_of_irradiation < RADFIEND_IMMUNITY_TIME)
			// Return without effects
			return

	// Run normally
	. = ..()
*/

// Radiation proc to check for Rad Fiend quirk
// Currently unused
/*
/datum/component/irradiated/proc/check_rad_fiend(mob/living/carbon/human/target)
	// Check if holder has Rad Fiend quirk
	if(HAS_TRAIT(parent, TRAIT_RAD_FIEND))
		return FALSE

	// Check if time threshold is met
	if((world.time - beginning_of_irradiation) < RADFIEND_IMMUNITY_TIME)
		// Quirk should protect the holder!
		return TRUE

	// Holder is not protected!
	return FALSE
*/
