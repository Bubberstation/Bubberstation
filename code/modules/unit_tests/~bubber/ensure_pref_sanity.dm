/datum/unit_test/bubber_ensure_pref_sanity

/datum/unit_test/bubber_ensure_pref_sanity/Run()
	for (var/datum/preference/preference as anything in GLOB.preference_entries)
		preference = GLOB.preference_entries[preference]
		if (preference.abstract_type == preference.type) // You're safe... for now.
			continue

		var/supplementals_failed = FALSE
		var/list/data = preference.compile_constant_data()
		if (data && !isnull(data[SUPPLEMENTAL_FEATURE_KEY]) && !islist(data[SUPPLEMENTAL_FEATURE_KEY]))
			TEST_FAIL("[preference.type] : Supplemental feature list isn't actually a list!")
			supplementals_failed = TRUE

		if (istype(preference, /datum/preference/choiced/mutant))
			mutant_checks(preference, supplementals_failed)

		if (istype(preference, /datum/preference/mutant_color))
			color_checks(preference, supplementals_failed)

		if (istype(preference, /datum/preference/emissive_toggle))
			emissive_checks(preference, supplementals_failed)

/datum/unit_test/bubber_ensure_pref_sanity/proc/color_checks(datum/preference/mutant_color/mutant, supplementals_failed)
	if (ispath(mutant.type_to_check, /datum/preference/choiced/mutant))
		var/datum/preference/choiced/mutant/choice = GLOB.preference_entries[mutant.type_to_check]
		if((choice.category == PREFERENCE_CATEGORY_FEATURES || choice.category == PREFERENCE_CATEGORY_BUBBER_MUTANT_FEATURE) && mutant.check_mode == TRICOLOR_CHECK_ACCESSORY)
			TEST_FAIL("[mutant.type] : Check mode is TRICOLOR_CHECK_ACCESSORY when the preference to check is a main feature! This WILL cause TGUI BSODs!")

/datum/unit_test/bubber_ensure_pref_sanity/proc/emissive_checks(datum/preference/emissive_toggle/mutant, supplementals_failed)
	if (ispath(mutant.type_to_check, /datum/preference/choiced/mutant))
		var/datum/preference/choiced/mutant/choice = GLOB.preference_entries[mutant.type_to_check]
		if((choice.category == PREFERENCE_CATEGORY_FEATURES || choice.category == PREFERENCE_CATEGORY_BUBBER_MUTANT_FEATURE) && mutant.check_mode == TRICOLOR_CHECK_ACCESSORY)
			TEST_FAIL("[mutant.type] : Check mode is TRICOLOR_CHECK_ACCESSORY when the preference to check is a main feature! This WILL cause TGUI BSODs!")

/datum/unit_test/bubber_ensure_pref_sanity/proc/mutant_checks(datum/preference/choiced/mutant/mutant, supplementals_failed)
	if (mutant.should_generate_icons && !mutant.main_feature_name)
		TEST_FAIL("[mutant.type] : Missing a main feature name!")
	var/static/list/valid_icon_categories = list(PREFERENCE_CATEGORY_FEATURES, PREFERENCE_CATEGORY_BUBBER_MUTANT_FEATURE)
	if (mutant.should_generate_icons && !(mutant.category in valid_icon_categories))
		TEST_FAIL("[mutant.type] : Category isn't set correctly! Should be a feature, or a bubber mutant feature!")
	else if (!mutant.should_generate_icons && (mutant.category in valid_icon_categories))
		TEST_FAIL("[mutant.type] : Category isn't set correctly! Should be a list-able feature (secondary/supplemental/etc)!")

	if(supplementals_failed)
		return // Supplementals format is wrong, so don't bother trying to test them

	for (var/supplemental_feature in mutant.supplemental_features)
		var/datum/preference/found_pref = GLOB.preference_entries_by_key[supplemental_feature]
		if (found_pref?.category != PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES)
			TEST_FAIL("[mutant.type] : Invalid supplemental feature \"[supplemental_feature]\" ([found_pref ? "bad category" : "non existent"])!")

