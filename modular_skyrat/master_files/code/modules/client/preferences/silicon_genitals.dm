// Synthetic genital toggles for cyborgs. These are character-level prefs and are
// applied to the live cyborg in transfer_silicon_prefs(), plus can be toggled in-game
// through the cyborg's Configure Synthetic Anatomy verb.

/datum/preference/toggle/silicon_vagina
	category = PREFERENCE_CATEGORY_SILICON_PREFS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_vagina"
	default_value = FALSE
	should_update_preview = FALSE

/datum/preference/toggle/silicon_vagina/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && passed_initial_check

/datum/preference/toggle/silicon_vagina/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/silicon_penis
	category = PREFERENCE_CATEGORY_SILICON_PREFS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_penis"
	default_value = FALSE
	should_update_preview = FALSE

/datum/preference/toggle/silicon_penis/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && passed_initial_check

/datum/preference/toggle/silicon_penis/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/silicon_breasts
	category = PREFERENCE_CATEGORY_SILICON_PREFS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_breasts"
	default_value = FALSE
	should_update_preview = FALSE

/datum/preference/toggle/silicon_breasts/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && passed_initial_check

/datum/preference/toggle/silicon_breasts/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/silicon_anus
	category = PREFERENCE_CATEGORY_SILICON_PREFS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_anus"
	default_value = FALSE
	should_update_preview = FALSE

/datum/preference/toggle/silicon_anus/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && passed_initial_check

/datum/preference/toggle/silicon_anus/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
