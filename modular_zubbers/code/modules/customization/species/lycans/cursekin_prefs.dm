/datum/preference/numeric/cursekin_char_slot
	category = PREFERENCE_CATEGORY_CHARACTER_BASICS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "cursekin_char_slot"
	can_randomize = FALSE
	minimum = 0
	maximum = /datum/preferences::max_save_slots

/datum/preference/numeric/cursekin_char_slot/has_relevant_feature(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return ispath(preferences.read_preference(/datum/preference/choiced/species), /datum/species/human/cursekin)

/datum/preference/numeric/cursekin_char_slot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/cursekin_char_slot/create_default_value()
	return 0
