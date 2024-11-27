/datum/preference/toggle/mutant_toggle/caps
	savefile_key = "caps_toggle"
	relevant_mutant_bodypart = "caps"

/datum/preference/choiced/mutant/caps
	savefile_key = "feature_caps"
	relevant_mutant_bodypart = "caps"
	type_to_check = /datum/preference/toggle/mutant_toggle/caps
	should_generate_icons = FALSE
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	supplemental_features = list()

/datum/preference/mutant_color/caps
	savefile_key = "caps_color"
	relevant_mutant_bodypart = "caps"
	type_to_check = /datum/preference/toggle/mutant_toggle/caps
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/emissive_toggle/caps
	savefile_key = "caps_emissive"
	relevant_mutant_bodypart = "caps"
	type_to_check = /datum/preference/toggle/mutant_toggle/caps
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
