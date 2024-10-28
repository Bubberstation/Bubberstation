// UNIMPLEMENTED QUIRK!
/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the shift being overweight."
	value = 0
	gain_text = span_notice("You're feeling a bit chubby this shift!")
	lose_text = span_notice("Your weight returns to an average level.")
	medical_record_text = "Patient has an unhealthy obsession with food."
	mob_trait = TRAIT_OVERWEIGHT
	icon = FA_ICON_BURGER

// Copy pasted from old code
/*
/datum/quirk/overweight/on_spawn()
	var/mob/living/M = quirk_holder
	M.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)
	M.overeatduration = 100
	ADD_TRAIT(M, TRAIT_FAT, OBESITY)
*/
