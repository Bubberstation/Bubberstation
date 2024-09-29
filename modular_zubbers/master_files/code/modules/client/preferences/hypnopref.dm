/datum/preference/choiced/erp_status_hypno
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_hypnosis"

/datum/preference/choiced/erp_status_hypno/init_possible_values()
	return list("Yes - Switch", "Yes - Dom", "Yes - Sub", "Check OOC", "Ask", "No", "Yes")

/datum/preference/choiced/erp_status_hypno/create_default_value()
	return "Ask"

/datum/preference/choiced/erp_status_hypno/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_hypno/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"

	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_hypno/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
