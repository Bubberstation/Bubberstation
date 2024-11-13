/datum/preference/toggle/mutant_toggle/horns
	savefile_key = "horns_toggle"
	relevant_mutant_bodypart = "horns"

/datum/preference/choiced/mutant/horns
	savefile_key = "feature_horns"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns

/datum/preference/mutant_color/horns
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "horns_color"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns

/datum/preference/emissive_toggle/horns
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "horns_emissive"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns
