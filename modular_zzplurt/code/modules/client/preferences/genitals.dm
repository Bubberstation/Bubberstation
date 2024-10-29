//butthole
/datum/preference/choiced/genital/anus
	savefile_key = "feature_anus"
	relevant_mutant_bodypart = ORGAN_SLOT_ANUS
	default_accessory_type = /datum/sprite_accessory/genital/anus/none

/datum/preference/choiced/genital/anus/is_accessible(datum/preferences/preferences)
	return ..() && preferences.read_preference(/datum/preference/choiced/genital/butt) != "None"

/datum/preference/toggle/genital_skin_tone/anus
	savefile_key = "anus_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_ANUS
	genital_pref_type = /datum/preference/choiced/genital/anus

/datum/preference/toggle/genital_skin_tone/anus/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["anus_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/anus
	savefile_key = "anus_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_ANUS
	genital_pref_type = /datum/preference/choiced/genital/anus

/datum/preference/toggle/genital_skin_color/anus/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["anus_uses_skincolor"] = value


/datum/preference/tri_color/genital/anus
	savefile_key = "anus_color"
	relevant_mutant_bodypart = ORGAN_SLOT_ANUS
	type_to_check = /datum/preference/choiced/genital/anus
	skin_color_type = /datum/preference/toggle/genital_skin_color/anus

/datum/preference/tri_bool/genital/anus
	savefile_key = "anus_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_ANUS
	type_to_check = /datum/preference/choiced/genital/anus
	skin_color_type = /datum/preference/toggle/genital_skin_color/anus
