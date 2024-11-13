/datum/preference/toggle/mutant_toggle/horns
	savefile_key = "horns_toggle"
	relevant_mutant_bodypart = "horns"

/datum/preference/choiced/mutant/horns
	savefile_key = "feature_horns"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns
	crop_area = list(11, 22, 21, 32) // We want just the head area.

/datum/preference/choiced/mutant/horns/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if(icon_exists(sprite_accessory.icon, "m_ears_[original_icon_state]_ADJ[suffix]"))
		return "m_horns_[original_icon_state]_ADJ[suffix]"

	return "m_horns_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/horns
	savefile_key = "horns_color"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns

/datum/preference/emissive_toggle/horns
	savefile_key = "horns_emissive"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns
