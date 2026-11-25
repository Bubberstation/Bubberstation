/datum/preference/choiced/mutant_choice/halo
	savefile_key = "feature_halo"
	main_feature_name = "Halo"
	category = PREFERENCE_CATEGORY_FEATURES
	relevant_mutant_bodypart = "halo"
	default_accessory_type = /datum/sprite_accessory/halo/none
	should_generate_icons = TRUE

// every species gets a halo, no mismatched parts toggle needed
/datum/preference/choiced/mutant_choice/halo/has_relevant_feature(datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/mutant_choice/halo/is_part_enabled(datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/mutant_choice/halo/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/mutant_choice/halo/generate_icon(datum/sprite_accessory/sprite_accessory)
	if(!sprite_accessory.factual)
		return uni_icon('icons/mob/landmarks.dmi', "x")
	return uni_icon('modular_zubbers/icons/customization/halos_preview.dmi', "[sprite_accessory.icon_state]_preview")

/datum/preference/choiced/mutant_choice/halo/compile_constant_data()
	var/list/data = ..()
	data[SUPPLEMENTAL_FEATURE_KEY] = "halo_color"
	return data

/datum/preference/color/mutant/halo_color
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "halo_color"
	relevant_mutant_bodypart = "halo"

/datum/preference/color/mutant/halo_color/has_relevant_feature(datum/preferences/preferences)
	return TRUE

/datum/preference/color/mutant/halo_color/create_default_value()
	return "#FFFFFF"
