/datum/preference/toggle/mutant_toggle/skrell_hair
	savefile_key = "skrell_hair_toggle"
	relevant_mutant_bodypart = "skrell_hair"

/datum/preference/choiced/mutant/skrell_hair
	savefile_key = "feature_skrell_hair"
	relevant_mutant_bodypart = "skrell_hair"
	type_to_check = /datum/preference/toggle/mutant_toggle/skrell_hair

/datum/preference/choiced/mutant/skrell_hair/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	return "m_skrell_hair_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/skrell_hair
	savefile_key = "skrell_hair_color"
	relevant_mutant_bodypart = "skrell_hair"
	type_to_check = /datum/preference/toggle/mutant_toggle/skrell_hair

/datum/preference/emissive_toggle/skrell_hair
	savefile_key = "skrell_hair_emissive"
	relevant_mutant_bodypart = "skrell_hair"
	type_to_check = /datum/preference/toggle/mutant_toggle/skrell_hair
