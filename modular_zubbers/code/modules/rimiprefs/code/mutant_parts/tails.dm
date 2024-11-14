/// Tails

/datum/preference/toggle/mutant_toggle/tail
	savefile_key = "tail_toggle"
	relevant_mutant_bodypart = "tail"

/datum/preference/choiced/mutant/tail
	savefile_key = "feature_tail"
	relevant_mutant_bodypart = "tail"
// 	type_to_check = /datum/preference/toggle/mutant_toggle/tail
	sprite_direction = NORTH
	greyscale_color = COLOR_VIBRANT_LIME
	crop_area = list(1, 1, 20, 20) // We want just the lower+mid left legs+torso area.

/datum/preference/choiced/mutant/tail/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if (icon_exists(sprite_accessory.icon, "m_snout_[original_icon_state]_ADJ[suffix]"))
		return "m_tail_[original_icon_state]_ADJ[suffix]"

	return "m_tail_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/tail
	savefile_key = "tail_color"
	relevant_mutant_bodypart = "tail"
// 	type_to_check = /datum/preference/toggle/mutant_toggle/tail

/datum/preference/emissive_toggle/tail
	savefile_key = "tail_emissive"
	relevant_mutant_bodypart = "tail"
// 	type_to_check = /datum/preference/toggle/mutant_toggle/tail
