// Probably the only thing that isn't supidly simplified.
// Still pretty simple though.
// TODO: Look into using "none" prefs instead

/**
 * Base class for character feature togglers
 */
/datum/preference/toggle/mutant_toggle
	abstract_type = /datum/preference/toggle/mutant_toggle
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE

/datum/preference/toggle/mutant_toggle/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE // we dont actually want this to do anything

/datum/preference/toggle/mutant_toggle/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	return passed_initial_check || allowed
