// Lavaland ash storms
/datum/weather/ash_storm/weather_act(mob/living/victim)
	// Check for resistance quirk
	if(HAS_TRAIT(victim, TRAIT_ASHRESISTANCE))
		// Do stamina damage instead
		victim.adjustStaminaLoss(4)

		// No other effects
		return

	// Run normally
	. = ..()
