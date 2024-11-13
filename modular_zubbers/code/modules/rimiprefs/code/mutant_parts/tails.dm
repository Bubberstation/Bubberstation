/// Tails

/datum/preference/toggle/mutant_toggle/tail
	savefile_key = "tail_toggle"
	relevant_mutant_bodypart = "tail"

/datum/preference/choiced/mutant/tail
	savefile_key = "feature_tail"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail

/datum/preference/mutant_color/tail
	savefile_key = "tail_color"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail

/datum/preference/emissive_toggle/tail
	savefile_key = "tail_emissive"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail
