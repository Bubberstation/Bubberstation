/datum/preference/choiced/permanent_limp
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "permanent_limp"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/permanent_limp/init_possible_values()
	return GLOB.permanent_limp_choice

/datum/preference/choiced/permanent_limp/create_default_value()
	return "Left, minor"

/datum/preference/choiced/permanent_limp/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Permanent Limp" in preferences.all_quirks

/datum/preference/choiced/permanent_limp/apply_to_human(mob/living/carbon/human/target, value)
	return
