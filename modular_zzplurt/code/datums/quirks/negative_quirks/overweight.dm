// Re-implemented here to match old server
/datum/quirk/overweight
	desc = "You're particularly fond of food, and join the shift being overweight."
	value = 0
	gain_text = span_notice("You're feeling a bit chubby this shift!")
	lose_text = span_notice("Your weight returns to an average level.")
	mob_trait = TRAIT_OVERWEIGHT

/datum/quirk/overweight/add(client/client_source)
	// Set nutrition value
	quirk_holder.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)

	// Set overeat duration
	quirk_holder.overeatduration = 300 SECONDS

	// Add fat trait
	ADD_TRAIT(quirk_holder, TRAIT_FAT, OBESITY)

// Speed multiplier granted by this quirk
// Disabled because this is a neutral quirk
/datum/movespeed_modifier/overweight
	multiplicative_slowdown = 0 // Previously 0.5
