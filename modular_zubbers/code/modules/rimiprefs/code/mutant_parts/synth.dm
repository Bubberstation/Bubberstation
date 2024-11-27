/// IPC Screens

/datum/preference/choiced/mutant/ipc_screen
	savefile_key = "feature_ipc_screen"
	main_feature_name = "IPC Screen"
	relevant_mutant_bodypart = MUTANT_SYNTH_SCREEN
	greyscale_color = DEFAULT_SYNTH_SCREEN_COLOR
	supplemental_features = list("ipc_screen_color")

/datum/preference/choiced/mutant/ipc_screen/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/species_path = preferences?.read_preference(/datum/preference/choiced/species)
	if(!ispath(species_path, /datum/species/synthetic)) // This is what we do so it doesn't show up on non-synthetics.
		return

	return ..()


/datum/preference/mutant_color/ipc_screen_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_key = "ipc_screen_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_SCREEN
	type_to_check = /datum/preference/choiced/mutant/ipc_screen

/datum/preference/emissive_toggle/ipc_screen_emissive
	savefile_key = "ipc_screen_emissive"
	relevant_mutant_bodypart = MUTANT_SYNTH_SCREEN
	type_to_check = /datum/preference/choiced/mutant/ipc_screen

/// IPC Antennas

/datum/preference/choiced/mutant/synth_antenna
	savefile_key = "feature_ipc_antenna"
	main_feature_name = "IPC Antenna"
	relevant_mutant_bodypart = MUTANT_SYNTH_ANTENNA
	supplemental_features = list("ipc_antenna_color", "ipc_antenna_emissive")

/datum/preference/mutant_color/synth_antenna
	savefile_key = "ipc_antenna_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_ANTENNA
	type_to_check = /datum/preference/choiced/mutant/synth_antenna

/datum/preference/emissive_toggle/synth_antenna_emissive
	savefile_key = "ipc_antenna_emissive"
	relevant_mutant_bodypart = MUTANT_SYNTH_ANTENNA
	type_to_check = /datum/preference/choiced/mutant/synth_antenna

/// IPC Chassis

/datum/preference/choiced/mutant/synth_chassis
	savefile_key = "feature_ipc_chassis"
	main_feature_name = "Chassis Appearance"
	relevant_mutant_bodypart = MUTANT_SYNTH_CHASSIS
	default_accessory_name = "Default Chassis"
	greyscale_color = DEFAULT_SYNTH_PART_COLOR
	supplemental_features = list("ipc_chassis_color")

/datum/preference/choiced/mutant/synth_chassis/generate_icon_states(datum/sprite_accessory/sprite_accessory, original_icon_state)
	// If this isn't the right type, we have much bigger problems.
	var/datum/sprite_accessory/synth_chassis/chassis = sprite_accessory
	return "[original_icon_state]_chest[chassis.dimorphic ? "_m" : ""]"

/datum/preference/mutant_color/synth_chassis
	savefile_key = "ipc_chassis_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_CHASSIS
	type_to_check = /datum/preference/choiced/mutant/synth_chassis

/// IPC Head

/datum/preference/choiced/mutant/synth_head
	savefile_key = "feature_ipc_head"
	main_feature_name = "Head Appearance"
	relevant_mutant_bodypart = MUTANT_SYNTH_HEAD
	default_accessory_name = "Default Head"
	should_generate_icons = TRUE
	greyscale_color = DEFAULT_SYNTH_PART_COLOR
	supplemental_features = list("ipc_head_color")

/datum/preference/choiced/mutant/synth_head/generate_icon_states(datum/sprite_accessory/sprite_accessory, original_icon_state)
	// If this isn't the right type, we have much bigger problems.
	var/datum/sprite_accessory/synth_head/head = sprite_accessory
	return "[original_icon_state]_head[head.dimorphic ? "_m" : ""]"

/datum/preference/mutant_color/synth_head
	savefile_key = "ipc_head_color"
	relevant_mutant_bodypart = MUTANT_SYNTH_HEAD
	type_to_check = /datum/preference/choiced/mutant/synth_head
