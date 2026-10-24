///see modular_zubbers\code\modules\quirks\neutral_quirks\moist_skin.dm

///manual colour input
/datum/preference/color/input_dripping_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "input_dripping_color"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/input_dripping_color/create_default_value()
	return COLOR_WATERDROP_DEFAULT

/datum/preference/color/input_dripping_color/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return /datum/quirk/moist_skin::name in preferences.all_quirks

/datum/preference/color/input_dripping_color/apply_to_human(mob/living/carbon/human/target, value)
	return
