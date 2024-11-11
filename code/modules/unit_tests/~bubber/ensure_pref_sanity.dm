/// Tests to make sure every pref has a valid preference constant.
/// This is because of some relatively big changes.
/datum/unit_test/bubber/ensure_pref_sanity
	var/list/valid_categories = list(
		PREFERENCE_CATEGORY_BUBBER_APPEARANCE,
		PREFERENCE_CATEGORY_BUBBER_OOC,
		PREFERENCE_CATEGORY_BUBBER_MISC,
		PREFERENCE_CATEGORY_BUBBER_INSPECTION_TEXT,
		PREFERENCE_CATEGORY_BUBBER_RECORDS,
		PREFERENCE_CATEGORY_BUBBER_CONTENT,
		PREFERENCE_CATEGORY_GAME_PREFERENCES,
		PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES,
		PREFERENCE_CATEGORY_MANUALLY_RENDERED,
	)

/datum/unit_test/bubber/ensure_pref_sanity/Run()
	for (var/datum/preference/preference as anything in subtypesof(/datum/preference))
		if (preference.abstract_type == preference) // You're safe... for now.
			continue

		if (!(initial(preference.category) in valid_categories))
			TEST_FAIL("[preference] has an invalid category ([initial(preference.category)]) set!")

