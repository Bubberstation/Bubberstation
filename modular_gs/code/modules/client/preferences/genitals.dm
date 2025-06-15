//Modular Genital prefs, butts, bellies, stuff like that

//the butt itself
/datum/preference/choiced/genital/butt
	savefile_key = "feature_butt"
	relevant_mutant_bodypart = ORGAN_SLOT_BUTT
	default_accessory_type = /datum/sprite_accessory/genital/butt/none

/datum/preference/toggle/genital_skin_tone/butt
	savefile_key = "butt_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_BUTT
	genital_pref_type = /datum/preference/choiced/genital/butt

/datum/preference/toggle/genital_skin_tone/butt/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["butt_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/butt
	savefile_key = "butt_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_BUTT
	genital_pref_type = /datum/preference/choiced/genital/butt

/datum/preference/toggle/genital_skin_color/butt/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["butt_uses_skincolor"] = value

/datum/preference/numeric/butt_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "butt_size"
	relevant_mutant_bodypart = ORGAN_SLOT_BUTT
	minimum = BUTT_MIN_SIZE
	maximum = BUTT_MAX_SIZE

/datum/preference/numeric/butt_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/butt))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/butt_size/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["butt_size"] = value

/datum/preference/numeric/butt_size/create_default_value()
	return BUTT_MIN_SIZE

/datum/preference/tri_color/genital/butt
	savefile_key = "butt_color"
	relevant_mutant_bodypart = ORGAN_SLOT_BUTT
	type_to_check = /datum/preference/choiced/genital/butt
	skin_color_type = /datum/preference/toggle/genital_skin_color/butt

/datum/preference/tri_bool/genital/butt
	savefile_key = "butt_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_BUTT
	type_to_check = /datum/preference/choiced/genital/butt
	skin_color_type = /datum/preference/toggle/genital_skin_color/butt

//tummy
/datum/preference/choiced/genital/belly
	savefile_key = "feature_belly"
	relevant_mutant_bodypart = ORGAN_SLOT_BELLY
	default_accessory_type = /datum/sprite_accessory/genital/belly/none

/datum/preference/numeric/belly_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "belly_size"
	relevant_mutant_bodypart = ORGAN_SLOT_BELLY
	minimum = BELLY_MIN_SIZE
	maximum = BELLY_MAX_SIZE

/datum/preference/numeric/belly_size/create_default_value()
	return 1

/datum/preference/numeric/belly_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/belly))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/belly_size/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["belly_size"] = value

/datum/preference/toggle/genital_skin_tone/belly
	savefile_key = "belly_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_BELLY
	genital_pref_type = /datum/preference/choiced/genital/belly

/datum/preference/toggle/genital_skin_tone/belly/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["belly_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/belly
	savefile_key = "belly_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_BELLY
	genital_pref_type = /datum/preference/choiced/genital/belly

/datum/preference/toggle/genital_skin_color/belly/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["belly_uses_skincolor"] = value

/datum/preference/tri_color/genital/belly
	savefile_key = "belly_color"
	relevant_mutant_bodypart = ORGAN_SLOT_BELLY
	type_to_check = /datum/preference/choiced/genital/belly
	skin_color_type = /datum/preference/toggle/genital_skin_color/belly

/datum/preference/tri_bool/genital/belly
	savefile_key = "belly_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_BELLY
	type_to_check = /datum/preference/choiced/genital/belly
	skin_color_type = /datum/preference/toggle/genital_skin_color/belly
