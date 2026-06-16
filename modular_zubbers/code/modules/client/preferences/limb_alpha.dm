/**
 * Per-limb alpha (transparency) preferences.
 */

/// Toggle that reveals the per-limb (arm/leg) alpha sliders.
/datum/preference/toggle/limb_alpha_per_limb
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "limb_alpha_per_limb"
	default_value = FALSE
	can_randomize = FALSE

/datum/preference/toggle/limb_alpha_per_limb/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/limb_alpha
	abstract_type = /datum/preference/numeric/limb_alpha
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = 0
	maximum = 255
	can_randomize = FALSE
	/// The BODY_ZONE_* this slider controls. Also forms the dna.features key.
	var/limb_zone
	/// If FALSE, the slider is hidden entirely. Kept around so head/chest can be re-enabled later.
	var/enabled = TRUE

/datum/preference/numeric/limb_alpha/create_default_value()
	return maximum

/datum/preference/numeric/limb_alpha/is_accessible(datum/preferences/preferences)
	if(!enabled)
		return FALSE
	if(!..())
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/limb_alpha_per_limb))
		return FALSE
	return TRUE

/datum/preference/numeric/limb_alpha/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!enabled)
		value = maximum
	else if(preferences && !preferences.read_preference(/datum/preference/toggle/limb_alpha_per_limb))
		value = maximum
	target.dna.features["limb_alpha_[limb_zone]"] = value
	return TRUE

// Head and chest are intentionally disabled for now (the sliders/keys are kept so they can be
// re-enabled by simply flipping `enabled` back to TRUE).
/datum/preference/numeric/limb_alpha/head
	savefile_key = "limb_alpha_head"
	limb_zone = BODY_ZONE_HEAD

/datum/preference/numeric/limb_alpha/chest
	savefile_key = "limb_alpha_chest"
	limb_zone = BODY_ZONE_CHEST

/datum/preference/numeric/limb_alpha/l_arm
	savefile_key = "limb_alpha_l_arm"
	limb_zone = BODY_ZONE_L_ARM

/datum/preference/numeric/limb_alpha/r_arm
	savefile_key = "limb_alpha_r_arm"
	limb_zone = BODY_ZONE_R_ARM

/datum/preference/numeric/limb_alpha/l_leg
	savefile_key = "limb_alpha_l_leg"
	limb_zone = BODY_ZONE_L_LEG

/datum/preference/numeric/limb_alpha/r_leg
	savefile_key = "limb_alpha_r_leg"
	limb_zone = BODY_ZONE_R_LEG
