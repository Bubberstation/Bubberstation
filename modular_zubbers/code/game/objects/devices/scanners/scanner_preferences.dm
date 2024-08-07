/datum/preference/choiced/health_analyzer_themes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "health_analyzer_themes"

/datum/preference/choiced/health_analyzer_themes/init_possible_values()
	return GLOB.analyzerthemes

/datum/preference/choiced/health_analyzer_themes/create_default_value()
	return "default"

/datum/preference/choiced/health_analyzer_themes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE


/datum/preference/toggle/health_analyzer_toggle
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "health_analyzer_toggle"

/datum/preference/toggle/health_analyzer_toggle/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/health_analyzer_toggle/create_default_value()
	return TRUE
