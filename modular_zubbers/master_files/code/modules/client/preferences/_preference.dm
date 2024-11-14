// Helpers that will save on if checks for better preferences.

/datum/preference/proc/get_category()
	return category

/datum/preference/choiced/get_category()
	return (should_generate_icons && category != PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES) ? "[category]_iconed" : category
