/datum/preference/toggle/eyes_opacity
	savefile_key = "feature_eyes_opacity_toggle"
	relevant_mutant_bodypart = EYE_COLOR
	default_value = FALSE

/datum/preference/numeric/eyes_opacity
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "feature_eyes_opacity"
	relevant_mutant_bodypart = EYE_COLOR
	maximum = 255
	minimum = 0

/datum/preference/numeric/eyes_opacity/create_default_value()
	return maximum

/datum/preference/numeric/eyes_opacity/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts) && preferences.read_preference(/datum/preference/toggle/mutant_toggle/eyes_opacity)
	return passed_initial_check || allowed

/**
 * Actually applied. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns TRUE if feature is visible.
 *
 * Arguments:
 * * target - The character this is being applied to.
 * * preferences - The relevant character preferences.
 */
/datum/preference/numeric/eyes_opacity/proc/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
	if(!preferences.read_preference(/datum/preference/toggle/mutant_toggle/eyes_opacity))
		return FALSE

	if(preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts))
		return TRUE

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	species = new species

	return (savefile_key in species.get_features())

/datum/preference/numeric/eyes_opacity/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences || !is_visible(target, preferences))
		return FALSE

	target.eyes_alpha = value
	return TRUE
