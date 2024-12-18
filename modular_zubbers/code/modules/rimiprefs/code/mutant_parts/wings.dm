/datum/preference/toggle/mutant_toggle/wings
	savefile_key = "wings_toggle"
	relevant_mutant_bodypart = "wings"

/datum/preference/choiced/mutant/wings
	savefile_key = "feature_wings"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings
	greyscale_color = COLOR_AMETHYST
	sprite_direction = NORTH
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	supplemental_features = list()
	should_generate_icons =  FALSE // YOU FUCKERS BREAK IN TWO DIFFERENT WAYS. I'M AT MY WIT'S END. FUCK YOU. - Rimi

// Dead code. If you want to try making wings work, be my guest. You will lose hours to this bullshit.
/datum/preference/choiced/mutant/wings/generate_icon_states(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if(icon_exists(sprite_accessory.icon, "m_wingsopen_[original_icon_state]_FRONT[suffix]"))
		return "m_wingsopen_[original_icon_state]_FRONT[suffix]"

	if(icon_exists(sprite_accessory.icon, "m_wingsopen_[original_icon_state]_ADJ[suffix]"))
		return "m_wingsopen_[original_icon_state]_ADJ[suffix]"

	if(icon_exists(sprite_accessory.icon, "m_wings_[original_icon_state]_ADJ[suffix]"))
		return "m_wingsopen_[original_icon_state]_ADJ[suffix]"

	return "m_wings_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/wings
	savefile_key = "wings_color"
	relevant_mutant_bodypart = "wings"
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	type_to_check = /datum/preference/toggle/mutant_toggle/wings

/datum/preference/emissive_toggle/wings
	savefile_key = "wings_emissive"
	relevant_mutant_bodypart = "wings"
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	type_to_check = /datum/preference/toggle/mutant_toggle/wings
