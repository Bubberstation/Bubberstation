/datum/preference/toggle/mutant_toggle/frills
	savefile_key = "frills_toggle"
	relevant_mutant_bodypart = "frills"

/datum/preference/choiced/mutant/frills
	savefile_key = "feature_frills"
	relevant_mutant_bodypart = "frills"
	type_to_check = /datum/preference/toggle/mutant_toggle/frills
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	should_generate_icons = FALSE
	supplemental_features = list()

/datum/preference/mutant_color/frills
	savefile_key = "frills_color"
	relevant_mutant_bodypart = "frills"
	type_to_check = /datum/preference/toggle/mutant_toggle/frills
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/emissive_toggle/frills
	savefile_key = "frills_emissive"
	relevant_mutant_bodypart = "frills"
	type_to_check = /datum/preference/toggle/mutant_toggle/frills
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
