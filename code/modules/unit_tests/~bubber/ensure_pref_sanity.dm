/datum/unit_test/bubber/ensure_pref_sanity

/datum/unit_test/bubber/ensure_pref_sanity/Run()
	for (var/datum/preference/preference as anything in GLOB.preference_entries)
		preference = GLOB.preference_entries[preference]
		if (preference.abstract_type == preference.type) // You're safe... for now.
			continue

		if (!istype(preference, /datum/preference/choiced/mutant))
			continue

		var/datum/preference/choiced/mutant/mutant = preference
		for (var/supplemental_feature in mutant.supplemental_features)
			var/datum/preference/found_pref = GLOB.preference_entries_by_key[supplemental_feature]
			if (found_pref?.category != PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES)
				TEST_FAIL("[preference] has invalid supplemental feature \"[supplemental_feature]\" ([found_pref ? "bad category" : "non existent"])!")

		if (mutant.should_generate_icons && !mutant.main_feature_name)
			TEST_FAIL("[preference] is missing a main feature name!")

