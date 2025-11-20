/datum/preference/toggle/quad_eyes
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "quad_eyes"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_BODYPARTS + 0.1
	default_value = FALSE

/datum/preference/toggle/quad_eyes/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return TRUE

/datum/preference/toggle/quad_eyes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!value)
		return
	ADD_TRAIT(target, TRAIT_QUAD_EYES, TRAIT_GENERIC)

/datum/preference/numeric/quad_eyes_offset
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "quad_eyes_offset"
	savefile_identifier = PREFERENCE_CHARACTER
	maximum = 0 // Any value higher than this and the eyes don't appear after the character is spawned in.
	minimum = -2

/datum/preference/numeric/quad_eyes_offset/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return (preferences.read_preference(/datum/preference/toggle/quad_eyes))

/datum/preference/numeric/quad_eyes_offset/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!value)
		return
	target.quad_eyes_offset = value
