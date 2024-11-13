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
	for (var/datum/preference/preference as anything in GLOB.preference_entries)
		preference = GLOB.preference_entries[preference]
		if (preference.abstract_type == preference) // You're safe... for now.
			continue

		if (!(preference.category in valid_categories))
			TEST_FAIL("[preference] has an invalid category ([preference.category]) set!")

		if (istype(preference, /datum/preference/choiced/mutant))
			var/datum/preference/choiced/mutant/mutant = preference
			for (var/supplemental_feature in mutant.supplemental_features)
				var/datum/preference/found_pref = GLOB.preference_entries_by_key[supplemental_feature]
				if (found_pref?.category != PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES)
					TEST_FAIL("[preference] has invalid supplemental feature \"[supplemental_feature]\" ([found_pref ? "bad category" : "non existent"])!")

			if (mutant.should_generate_icons && !mutant.main_feature_name)
				TEST_FAIL("[preference] is missing a main feature name!")

