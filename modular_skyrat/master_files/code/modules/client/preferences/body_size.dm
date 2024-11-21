/datum/preference/numeric/body_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "body_size"
	//SPLURT EDIT CHANGE - Sizecode
	/*
	minimum = BODY_SIZE_MIN
	maximum = BODY_SIZE_MAX
	*/
	//SPLURT EDIT END
	step = 0.01

/datum/preference/numeric/body_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	return passed_initial_check

/datum/preference/numeric/body_size/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["body_size"] = value

/datum/preference/numeric/body_size/create_default_value()
	return BODY_SIZE_NORMAL
