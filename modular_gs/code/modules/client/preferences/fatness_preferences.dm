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


/datum/preference/numeric/weight_gain_rate
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_gain_rate"
	minimum = MIN_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	maximum = MAX_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	step = 0.01

/datum/preference/numeric/weight_gain_rate/create_default_value()
	return DEFAULT_PREFS_WEIGHT_GAIN_AND_LOSS_RATE

/datum/preference/numeric/weight_gain_rate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.weight_gain_rate = value


/datum/preference/numeric/weight_loss_rate
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_loss_rate"
	minimum = MIN_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	maximum = MAX_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	step = 0.01

/datum/preference/numeric/weight_loss_rate/create_default_value()
	return DEFAULT_PREFS_WEIGHT_GAIN_AND_LOSS_RATE

/datum/preference/numeric/weight_loss_rate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.weight_loss_rate = value


/datum/preference/numeric/max_weight
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "max_weight"
	minimum = 0

/datum/preference/numeric/max_weight/create_default_value()
	return 0

/datum/preference/numeric/max_weight/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.max_weight = value


/datum/preference/toggle/weight_gain_persistent
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_gain_persistent"
	default_value = FALSE

/datum/preference/toggle/weight_gain_persistent/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/weight_gain_permanent
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_gain_permanent"
	default_value = FALSE

/datum/preference/toggle/weight_gain_permanent/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/perma_fat_value // this is a bit cancer but if it works it works
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "perma_fat_value"
	minimum = FATNESS_LEVEL_NONE
	maximum = INFINITY

/datum/preference/numeric/perma_fat_value/create_default_value()
	return FATNESS_LEVEL_NONE

/datum/preference/numeric/perma_fat_value/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.fatness_perma += value