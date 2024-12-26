/datum/preference/choiced/erp_status_extm
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_extm"

/datum/preference/choiced/erp_status_extm/init_possible_values()
	return list("Yes - Switch", "Yes - Dom", "Yes - Sub", "Yes", "Ask (L)OOC", "Check OOC Notes", "No")

/datum/preference/choiced/erp_status_extm/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_extm/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_extm/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_extm/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_extmharm
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_extmharm"

/datum/preference/choiced/erp_status_extmharm/init_possible_values()
	return list("Yes - Switch", "Yes - Dom", "Yes - Sub", "Yes", "Ask (L)OOC", "Check OOC Notes", "No")

/datum/preference/choiced/erp_status_extmharm/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_extmharm/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/choiced/erp_status_extm) != "No"

/datum/preference/choiced/erp_status_extmharm/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences) || !(preferences.read_preference(/datum/preference/choiced/erp_status_extm) != "No"))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_extmharm/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_unholy
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_unholy"

/datum/preference/choiced/erp_status_unholy/init_possible_values()
	return list("Yes - Switch", "Yes - Dom", "Yes - Sub", "Yes", "Ask (L)OOC", "Check OOC Notes", "No")

/datum/preference/choiced/erp_status_unholy/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_unholy/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_unholy/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_unholy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/erp_lust_tolerance
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "erp_lust_tolerance_pref"
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = 0.5
	maximum = 2.0
	step = 0.01

/datum/preference/numeric/erp_lust_tolerance/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["lust_tolerance"] = value

/datum/preference/numeric/erp_lust_tolerance/create_informed_default_value(datum/preferences/preferences)
	return 1.0

/datum/preference/numeric/erp_lust_tolerance/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/numeric/erp_sexual_potency
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "erp_sexual_potency_pref"
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = 0.5
	maximum = 2.0
	step = 0.01

/datum/preference/numeric/erp_sexual_potency/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["sexual_potency"] = value

/datum/preference/numeric/erp_sexual_potency/create_informed_default_value(datum/preferences/preferences)
	return 1.0

/datum/preference/numeric/erp_sexual_potency/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/toggle/erp/butt_enlargement
	savefile_key = "butt_enlargement_pref"

/datum/preference/toggle/erp/butt_shrinkage
	savefile_key = "butt_shrinkage_pref"

/datum/preference/toggle/erp/belly_enlargement
	savefile_key = "belly_enlargement_pref"

/datum/preference/toggle/erp/belly_shrinkage
	savefile_key = "belly_shrinkage_pref"

/datum/preference/toggle/erp/forced_neverboner
	savefile_key = "forced_neverboner_pref"
