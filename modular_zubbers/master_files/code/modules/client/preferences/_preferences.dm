/datum/preference
	/// Shortcut var for adding supplemental features to your preference
	var/list/supplemental_features

/datum/preference/choiced/compile_constant_data()
	var/list/data = ..()

	if (supplemental_features)
		data[SUPPLEMENTAL_FEATURE_KEY] = supplemental_features

	return data
