/// IPC Screens

/datum/preference/choiced/mutant/ipc_screen
	savefile_key = "feature_ipc_screen"
	main_feature_name = "IPC Screen"
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	relevant_mutant_bodypart = MUTANT_SYNTH_SCREEN
	should_generate_icons = TRUE
	crop_area = list(11, 22, 21, 32) // We want just the head.
	greyscale_color = DEFAULT_SYNTH_SCREEN_COLOR

/datum/preference/choiced/mutant/ipc_screen/is_part_enabled(datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/mutant/ipc_screen/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state)
	return "m_ipc_screen_[original_icon_state]_FRONT_UNDER"

/datum/preference/choiced/mutant/ipc_screen/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "ipc_screen_color"

	return data

/datum/preference/choiced/mutant/ipc_screen/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/species_path = preferences?.read_preference(/datum/preference/choiced/species)
	if(!ispath(species_path, /datum/species/synthetic)) // This is what we do so it doesn't show up on non-synthetics.
		return

	return ..()


/datum/preference/mutant_color/ipc_screen_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_screen_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_SCREEN

/datum/preference/emissive_toggle/ipc_screen_emissive
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_screen_emissive"
	relevant_mutant_bodypart = MUTANT_SYNTH_SCREEN
	check_mode = TRICOLOR_CHECK_ACCESSORY
	type_to_check = /datum/preference/choiced/mutant/ipc_screen

/// IPC Antennas

/datum/preference/choiced/mutant/synth_antenna
	savefile_key = "feature_ipc_antenna"
	relevant_mutant_bodypart = MUTANT_SYNTH_ANTENNA

/datum/preference/choiced/mutant/synth_antenna/is_part_enabled(datum/preferences/preferences)
	return TRUE

/datum/preference/mutant_color/synth_antenna
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_antenna_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_ANTENNA
	check_mode = TRICOLOR_CHECK_ACCESSORY
	type_to_check = /datum/preference/choiced/mutant/synth_antenna

/datum/preference/emissive_toggle/synth_antenna_emissive
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_antenna_emissive"
	relevant_mutant_bodypart = MUTANT_SYNTH_ANTENNA
	check_mode = TRICOLOR_CHECK_ACCESSORY
	type_to_check = /datum/preference/choiced/mutant/synth_antenna

/// IPC Chassis

/datum/preference/choiced/mutant/synth_chassis
	savefile_key = "feature_ipc_chassis"
	main_feature_name = "Chassis Appearance"
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	relevant_mutant_bodypart = MUTANT_SYNTH_CHASSIS
	default_accessory_name = "Default Chassis"
	should_generate_icons = TRUE
	crop_area = list(8, 8, 24, 24) // We want just the body.
	greyscale_color = DEFAULT_SYNTH_PART_COLOR

/datum/preference/choiced/mutant/synth_chassis/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state)
	// If this isn't the right type, we have much bigger problems.
	var/datum/sprite_accessory/synth_chassis/chassis = sprite_accessory
	return "[original_icon_state]_chest[chassis.dimorphic ? "_m" : ""]"

/datum/preference/choiced/mutant/synth_chassis/is_part_enabled(datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/mutant/synth_chassis/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "ipc_chassis_color"

	return data

/datum/preference/mutant_color/synth_chassis
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_chassis_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_CHASSIS

/// IPC Head

/datum/preference/choiced/mutant/synth_head
	savefile_key = "feature_ipc_head"
	main_feature_name = "Head Appearance"
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	relevant_mutant_bodypart = MUTANT_SYNTH_HEAD
	default_accessory_name = "Default Head"
	should_generate_icons = TRUE
	crop_area = list(11, 22, 21, 32) // We want just the head.
	greyscale_color = DEFAULT_SYNTH_PART_COLOR

/datum/preference/choiced/mutant/synth_head/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state)
	// If this isn't the right type, we have much bigger problems.
	var/datum/sprite_accessory/synth_head/head = sprite_accessory
	return "[original_icon_state]_head[head.dimorphic ? "_m" : ""]"

/datum/preference/choiced/mutant/synth_head/is_part_enabled(datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/mutant/synth_head/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "ipc_head_color"

	return data

/datum/preference/mutant_color/synth_head
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_head_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_HEAD
