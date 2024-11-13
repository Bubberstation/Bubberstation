/datum/preference/toggle/mutant_toggle/spines
	savefile_key = "spines_toggle"
	relevant_mutant_bodypart = "spines"

/datum/preference/choiced/mutant/spines
	savefile_key = "feature_spines"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines
	sprite_direction = NORTH

/datum/preference/choiced/mutant/spines/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	return "m_spines_[original_icon_state]_ADJ[suffix]"

/datum/preference/mutant_color/spines
	savefile_key = "spines_color"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines

/datum/preference/emissive_toggle/spines
	savefile_key = "spines_emissive"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines
