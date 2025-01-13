/datum/preference/toggle/mutant_toggle/spines
	savefile_key = "spines_toggle"
	relevant_mutant_bodypart = "spines"

/datum/preference/choiced/mutant/spines
	main_feature_name = "Spines"
	savefile_key = "feature_spines"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	sprite_direction = NORTH
	should_generate_icons = FALSE
	supplemental_features = list()

/datum/preference/mutant_color/spines
	savefile_key = "spines_color"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/emissive_toggle/spines
	savefile_key = "spines_emissive"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
