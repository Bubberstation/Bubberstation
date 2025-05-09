///see modular_zubbers\code\modules\quirks\neutral_quirks\unique_blood_color.dm

///manual colour input
/datum/preference/color/input_blood_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "input_blood_color"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/input_blood_color/create_default_value()
	return BLOOD_COLOR_RED

/datum/preference/color/input_blood_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return /datum/quirk/unique_blood_color::name in preferences.all_quirks

/datum/preference/color/input_blood_color/apply_to_human(mob/living/carbon/human/target, value)
	return

///bool for using the colour presets instead of manual input
/datum/preference/toggle/preset_blood_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "preset_blood_color"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/toggle/preset_blood_color/create_default_value()
	return FALSE

/datum/preference/toggle/preset_blood_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return /datum/quirk/unique_blood_color::name in preferences.all_quirks

/datum/preference/toggle/preset_blood_color/apply_to_human(mob/living/carbon/human/target, value)
	return

///colour preset selection
/datum/preference/choiced/select_blood_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "select_blood_color"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/select_blood_color/create_default_value()
	return "Red/Human"

/datum/preference/choiced/select_blood_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return /datum/quirk/unique_blood_color::name in preferences.all_quirks

/datum/preference/choiced/select_blood_color/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/choiced/select_blood_color/init_possible_values()
	return list(
		"Red/Human",
		"D.Green/Lizard", uncomment when green blood is downstreamed
		"Green/alt-Lizard",
		"Lime/Xeno",
		"Violet/Avali",
		"Cyan/Vox",
		"White/Synth",
	)
