/datum/preference/toggle/invisible_eyes
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "invisible_eyes"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_BODYPARTS + 0.1
	default_value = FALSE

/datum/preference/toggle/invisible_eyes/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return TRUE

/datum/preference/toggle/invisible_eyes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!value)
		return
	ADD_TRAIT(target, TRAIT_INVISIBLE_EYES, TRAIT_GENERIC)
