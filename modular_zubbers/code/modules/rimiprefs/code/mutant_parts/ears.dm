/datum/preference/toggle/mutant_toggle/ears
	savefile_key = "ears_toggle"
	relevant_mutant_bodypart = "ears"

/datum/preference/choiced/mutant/ears
	savefile_key = "feature_ears"
	relevant_mutant_bodypart = "ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears
	greyscale_color = COLOR_DARK_BROWN
	crop_area = list(11, 22, 21, 32) // We want just the head area.

/datum/preference/choiced/mutant/ears/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if(icon_exists(sprite_accessory.icon, "m_ears_[original_icon_state]_ADJ[suffix]") && !findtext(sprite_accessory.icon_state, "bigwolf")) // Look, don't judge me, this was the easiest way to do it, and I've been dealing with fucking ear code for nearly 4 hours now - Rimi
		return "m_ears_[original_icon_state]_ADJ[suffix]"

	return "m_ears_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/ears
	savefile_key = "ears_color"
	relevant_mutant_bodypart = "ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears

/datum/preference/emissive_toggle/ears
	savefile_key = "ears_emissive"
	relevant_mutant_bodypart = "ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears
