/datum/preference/toggle/mutant_toggle/wings
	savefile_key = "wings_toggle"
	relevant_mutant_bodypart = "wings"

/datum/preference/choiced/mutant/wings
	savefile_key = "feature_wings"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings
	sprite_direction = NORTH


/datum/preference/choiced/mutant/lizard_tail/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	return "m_wingsopen_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/wings
	savefile_key = "wings_color"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings

/datum/preference/emissive_toggle/wings
	savefile_key = "wings_emissive"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings
