/datum/preference/choiced/grasping_arms
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "grasping_arms"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/grasping_arms/init_possible_values()
	return GLOB.grasping_arms_choice

/datum/preference/choiced/grasping_arms/create_default_value()
	return "Mantis"

/datum/preference/choiced/grasping_arms/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Grasping Arms" in preferences.all_quirks

/datum/preference/choiced/grasping_arms/apply_to_human(mob/living/carbon/human/target, value)
	return
