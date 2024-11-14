/datum/unit_test/bubber/ensure_pref_sanity

/datum/unit_test/bubber/ensure_pref_sanity/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human/consistent)

	for (var/datum/preference/preference as anything in GLOB.preference_entries)
		preference = GLOB.preference_entries[preference]
		if (preference.abstract_type == preference.type) // You're safe... for now.
			continue

		var/supplementals_failed = FALSE
		var/list/data = preference.compile_constant_data()
		if (!data && !isnull(data[SUPPLEMENTAL_FEATURE_KEY]) && !islist(data[SUPPLEMENTAL_FEATURE_KEY]))
			TEST_FAIL("[preference] : Supplemental feature list isn't actually a list!")
			supplementals_failed = TRUE

		if (!istype(preference, /datum/preference/choiced/mutant))
			continue

		var/datum/preference/choiced/mutant/mutant = preference

		if (mutant.should_generate_icons && !mutant.main_feature_name)
			TEST_FAIL("[preference] : Missing a main feature name!")

		if(supplementals_failed)
			continue // Supplementals format is wrong, so don't bother trying to test them

		for (var/supplemental_feature in mutant.supplemental_features)
			var/datum/preference/found_pref = GLOB.preference_entries_by_key[supplemental_feature]
			if (found_pref?.category != PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES)
				TEST_FAIL("[preference] : Invalid supplemental feature \"[supplemental_feature]\" ([found_pref ? "bad category" : "non existent"])!")

