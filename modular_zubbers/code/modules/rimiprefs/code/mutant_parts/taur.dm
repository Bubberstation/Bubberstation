/datum/preference/toggle/mutant_toggle/taur
	savefile_key = "taur_toggle"
	relevant_mutant_bodypart = "taur"

/datum/preference/choiced/mutant/taur
	main_feature_name = "Taur Body"
	savefile_key = "feature_taur"
	relevant_mutant_bodypart = "taur"
	type_to_check = /datum/preference/toggle/mutant_toggle/taur
	greyscale_color = COLOR_DARK_BROWN
	sprite_direction = EAST

/datum/preference/choiced/mutant/taur/generate_icon_states(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if(icon_exists(sprite_accessory.icon, "m_taur_[original_icon_state]_ADJ[suffix]"))
		return "m_taur_[original_icon_state]_ADJ[suffix]"

	if(icon_exists(sprite_accessory.icon, "m_taur_[original_icon_state]_FRONT_UNDER[suffix]"))
		return "m_taur_[original_icon_state]_FRONT_UNDER[suffix]"

	return "m_taur_[original_icon_state]_BEHIND[suffix]"

/datum/preference/mutant_color/taur
	savefile_key = "taur_color"
	relevant_mutant_bodypart = "taur"
	type_to_check = /datum/preference/toggle/mutant_toggle/taur

/datum/preference/emissive_toggle/taur
	savefile_key = "taur_emissive"
	relevant_mutant_bodypart = "taur"
	type_to_check = /datum/preference/toggle/mutant_toggle/taur
