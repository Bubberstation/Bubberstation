/datum/preference/choiced/health_analyzer_theme
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "health_analyzer_themes"

/datum/preference/choiced/health_analyzer_theme/init_possible_values()
	return GLOB.analyzerthemes

/datum/preference/choiced/health_analyzer_theme/create_default_value()
	return "default"

/datum/preference/choiced/health_analyzer_theme/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
