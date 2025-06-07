/datum/preference/numeric/starting_fatness
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "starting_fatness"
	minimum = FATNESS_LEVEL_NONE
	maximum = FATNESS_LEVEL_BLOB

/datum/preference/numeric/starting_fatness/create_default_value()
	return FATNESS_LEVEL_NONE

/datum/preference/numeric/starting_fatness/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.fatness_real += value
