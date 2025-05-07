///see modular_zubbers\code\modules\quirks\neutral_quirks\unique_blood_color.dm
/datum/preference/color/unique_blood_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "unique_blood_color"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/unique_blood_color/create_default_value()
	return BLOOD_COLOR_RED

/datum/preference/color/unique_blood_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return /datum/quirk/unique_blood_color::name in preferences.all_quirks

/datum/preference/color/unique_blood_color/apply_to_human(mob/living/carbon/human/target, value)
	return
