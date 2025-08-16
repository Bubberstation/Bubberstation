/// Ears

/datum/preference/toggle/mutant_toggle/ears/lycan
	savefile_key = "lycan_ears_toggle"
	relevant_inherent_trait = TRAIT_LYCAN


// /datum/preference/choiced/mutant_choice/is_part_enabled(datum/preferences/preferences)
// 	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
// 	if(istype(species_type, /datum/species/cursekin/lycan))
// 		return TRUE
// 	return ..()


// /datum/preference/toggle/mutant_toggle/ears/lycan/has_relevant_feature(datum/preferences/preferences)
// 	var/datum/species/cursekin/species_type = preferences.read_preference(/datum/preference/choiced/species)
// 	if(istype(species_type))
// 		return TRUE
// 	// Skips checks for relevant_organ, relevant trait etc. because ethereal color is tied directly to species (atm)
// 	return current_species_has_savekey(preferences)

/datum/preference/choiced/mutant_choice/ears/lycan
	savefile_key = "feature_lycan_ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/lycan
	sprite_accessory_category = "ears"
	relevant_inherent_trait = TRAIT_LYCAN

/datum/preference/tri_color/ears/lycan
	savefile_key = "lycan_ears_color"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/lycan
	relevant_inherent_trait = TRAIT_LYCAN

/datum/preference/tri_bool/ears/lycan
	savefile_key = "lycan_ears_emissive"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears/lycan
	relevant_inherent_trait = TRAIT_LYCAN

/// Tails

/datum/preference/toggle/mutant_toggle/tail/lycan
	savefile_key = "lycan_tail_toggle"
	relevant_inherent_trait = TRAIT_LYCAN

/datum/preference/choiced/mutant_choice/tail/lycan
	savefile_key = "feature_lycan_tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/lycan
	sprite_accessory_category = "tail"
	relevant_inherent_trait = TRAIT_LYCAN

/datum/preference/tri_color/tail/lycan
	savefile_key = "lycan_tail_color"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/lycan
	relevant_inherent_trait = TRAIT_LYCAN

/datum/preference/tri_bool/tail/lycan
	savefile_key = "lycan_tail_emissive"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail/lycan
	relevant_inherent_trait = TRAIT_LYCAN
