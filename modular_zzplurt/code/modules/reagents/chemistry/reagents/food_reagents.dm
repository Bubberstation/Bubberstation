// Prevent processing for TRAIT_NO_PROCESS_FOOD
/datum/reagent/consumable/on_mob_life(mob/living/carbon/M)
	// Check for trait
	if(HAS_TRAIT(M, TRAIT_NO_PROCESS_FOOD))
		// Do nothing!
		return

	// Continue normally
	. = ..()

// Salt start metabolizing for Sodium Sensitivity
/datum/reagent/consumable/salt/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()

	// Check for Sodium Sensitivity
	if(HAS_TRAIT(affected_mob, TRAIT_SALT_SENSITIVE))
		// Warn user
		to_chat(affected_mob, span_warning("You feel a familiar sensation burning you from the inside!"))

// Salt end metabolizing for Sodium Sensitivity
/datum/reagent/consumable/salt/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()

	// Check for Sodium Sensitivity
	if(HAS_TRAIT(affected_mob, TRAIT_SALT_SENSITIVE))
		// Warn user
		to_chat(affected_mob, span_warning("The burning sensation fades away again."))

/datum/reagent/consumable/salt/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	// Check for Sodium Sensitivity
	if(HAS_TRAIT(affected_mob, TRAIT_SALT_SENSITIVE))
		// Play burning sound
		playsound(affected_mob, SFX_SEAR, 30, TRUE)

		// Do minor burn damage
		affected_mob.adjustFireLoss(2 * REM * seconds_per_tick)

// Salt touch effect for Sodium Sensitivity
/datum/reagent/consumable/salt/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()

	// Check for Sodium Sensitivity
	if(HAS_TRAIT(affected_mob, TRAIT_SALT_SENSITIVE))
		// Play burning sound
		playsound(affected_mob, SFX_SEAR, 30, TRUE)

		// Damage cap taken from bugkiller
		// Intended to prevent instant crit from beaker splash
		var/damage = min(round(0.4 * reac_volume, 0.1), 20)
		if(damage < 1)
			return

		// Cause burn damage based on amount
		affected_mob.adjustFireLoss(damage)
