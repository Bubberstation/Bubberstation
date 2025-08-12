/// Ears

/datum/preference/toggle/mutant_toggle/ears/lycan
	savefile_key = "lycan_ears_toggle"
	relevant_mutant_bodypart = "lupine ears"

/datum/preference/choiced/mutant_choice/ears/lycan
	savefile_key = "feature_lycan_ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/lycan
	relevant_mutant_bodypart = "lupine ears"
	sprite_accessory_category = "ears"

/datum/preference/tri_color/ears/lycan
	savefile_key = "lycan_ears_color"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/lycan
	relevant_mutant_bodypart = "lupine ears"

/datum/preference/tri_bool/ears/lycan
	savefile_key = "lycan_ears_emissive"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/lycan
	relevant_mutant_bodypart = "lupine ears"

/// Tails

/datum/preference/toggle/mutant_toggle/tail/lycan
	savefile_key = "lycan_tail_toggle"
	relevant_mutant_bodypart = "lupine tail"


/datum/preference/choiced/mutant_choice/tail/lycan
	savefile_key = "feature_lycan_tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/lycan
	relevant_mutant_bodypart = "lupine tail"
	sprite_accessory_category = "tail"

/datum/preference/tri_color/tail/lycan
	savefile_key = "lycan_tail_color"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/lycan
	relevant_mutant_bodypart = "lupine tail"

/datum/preference/tri_bool/tail/lycan
	savefile_key = "lycan_tail_emissive"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/lycan
	relevant_mutant_bodypart = "lupine tail"
