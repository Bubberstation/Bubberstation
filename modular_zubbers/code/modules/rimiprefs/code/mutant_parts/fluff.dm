/datum/preference/toggle/mutant_toggle/fluff
	savefile_key = "fluff_toggle"
	relevant_mutant_bodypart = "fluff"

/datum/preference/choiced/mutant/fluff
	savefile_key = "feature_fluff"
	relevant_mutant_bodypart = "fluff"
	type_to_check = /datum/preference/toggle/mutant_toggle/fluff
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	should_generate_icons = FALSE
	supplemental_features = list()

/datum/preference/mutant_color/fluff
	savefile_key = "fluff_color"
	relevant_mutant_bodypart = "fluff"
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	type_to_check = /datum/preference/toggle/mutant_toggle/fluff

/datum/preference/emissive_toggle/fluff
	savefile_key = "fluff_emissive"
	relevant_mutant_bodypart = "fluff"
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	type_to_check = /datum/preference/toggle/mutant_toggle/fluff
