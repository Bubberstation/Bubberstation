/// Ears

/datum/preference/toggle/mutant_toggle/ears/werewolf
	savefile_key = "werewolf_ears_toggle"
	relevant_mutant_bodypart = "lupine ears"

/datum/preference/choiced/mutant_choice/ears/werewolf
	savefile_key = "feature_werewolf_ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/werewolf
	relevant_mutant_bodypart = "lupine ears"

/datum/preference/tri_color/ears/werewolf
	savefile_key = "werewolf_ears_color"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/werewolf
	relevant_mutant_bodypart = "lupine ears"

/datum/preference/tri_bool/ears/werewolf
	savefile_key = "werewolf_ears_emissive"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/werewolf
	relevant_mutant_bodypart = "lupine ears"

/// Tails

/datum/preference/toggle/mutant_toggle/tail/werewolf
	savefile_key = "werewolf_tail_toggle"
	relevant_mutant_bodypart = "lupine tail"

/datum/preference/choiced/mutant_choice/tail/werewolf
	savefile_key = "feature_werewolf_tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/werewolf
	relevant_mutant_bodypart = "lupine tail"

/datum/preference/tri_color/tail/werewolf
	savefile_key = "werewolf_tail_color"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/werewolf
	relevant_mutant_bodypart = "lupine tail"

/datum/preference/tri_bool/tail/werewolf
	savefile_key = "werewolf_tail_emissive"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/werewolf
	relevant_mutant_bodypart = "lupine tail"
