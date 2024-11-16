/// Xenodorsal

/datum/preference/toggle/mutant_toggle/xenodorsal
	savefile_key = "xenodorsal_toggle"
	relevant_mutant_bodypart = "xenodorsal"

/datum/preference/choiced/mutant/xenodorsal
	savefile_key = "feature_xenodorsal"
	relevant_mutant_bodypart = "xenodorsal"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenodorsal
	should_generate_icons = FALSE

/datum/preference/mutant_color/xenodorsal
	savefile_key = "xenodorsal_color"
	relevant_mutant_bodypart = "xenodorsal"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenodorsal

/datum/preference/emissive_toggle/xenodorsal
	savefile_key = "xenodorsal_emissive"
	relevant_mutant_bodypart = "xenodorsal"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenodorsal

/// Xeno heads

/datum/preference/toggle/mutant_toggle/xenohead
	savefile_key = "xenohead_toggle"
	relevant_mutant_bodypart = "xenohead"

/datum/preference/choiced/mutant/xenohead
	main_feature_name = "Xeno Head"
	savefile_key = "feature_xenohead"
	relevant_mutant_bodypart = "xenohead"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenohead
	crop_area = list(11, 22, 21, 32) // We want just the head area.

/datum/preference/choiced/mutant/xenohead/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	return "m_xenohead_[original_icon_state]_ADJ[suffix]"

/datum/preference/mutant_color/xenohead
	savefile_key = "xenohead_color"
	relevant_mutant_bodypart = "xenohead"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenohead

/datum/preference/emissive_toggle/xenohead
	savefile_key = "xenohead_emissive"
	relevant_mutant_bodypart = "xenohead"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenohead
