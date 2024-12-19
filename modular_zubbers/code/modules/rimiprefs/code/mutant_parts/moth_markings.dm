/datum/preference/toggle/mutant_toggle/moth_markings
	savefile_key = "moth_markings_toggle"
	relevant_mutant_bodypart = "moth_markings"

/datum/preference/toggle/mutant_toggle/moth_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/choiced/mutant/moth_markings
	savefile_key = "feature_moth_markings"
	relevant_mutant_bodypart = "moth_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_markings
	should_generate_icons = FALSE
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/choiced/mutant/moth_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/choiced/mutant/moth_markings/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/mutant_color/moth_markings
	savefile_key = "moth_markings_color"
	relevant_mutant_bodypart = "moth_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_markings

/datum/preference/mutant_color/moth_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/mutant_color/moth_markings/apply_to_human(mob/living/carbon/human/target, value)
	return FALSE

/datum/preference/emissive_toggle/moth_markings
	savefile_key = "moth_markings_emissive"
	relevant_mutant_bodypart = "moth_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_markings

/datum/preference/emissive_toggle/moth_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/emissive_toggle/moth_markings/apply_to_human(mob/living/carbon/human/target, value)
	return FALSE
