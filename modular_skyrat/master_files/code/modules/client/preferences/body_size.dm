/datum/preference/numeric/body_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "body_size"
	minimum = RESIZE_DEFAULT_SIZE * 0.8
	maximum = RESIZE_DEFAULT_SIZE * 1.5
	step = 0.01

/datum/preference/numeric/body_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	return passed_initial_check

/datum/preference/numeric/body_size/apply_to_human(mob/living/carbon/human/target, value)
	target.update_transform(value / target.current_size)

/datum/preference/numeric/body_size/create_default_value()
	return RESIZE_DEFAULT_SIZE
