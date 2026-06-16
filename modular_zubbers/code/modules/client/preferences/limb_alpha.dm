/**
 * Per-limb alpha (transparency) preferences.
 *
 * Lets a player set a custom alpha for each of their bodyparts, which is applied to the
 * limb's rendered sprite overlays (see /obj/item/bodypart/proc/get_limb_icon).
 *
 * Head and chest sliders are always shown. The arm and leg sliders are hidden behind the
 * [/datum/preference/toggle/limb_alpha_per_limb] toggle, and reset to fully opaque while it
 * is disabled, so casual players never have to think about them.
 *
 * While attached, a limb's alpha can go all the way to 0 (fully invisible) - the floor of 0 is
 * enforced by BYOND itself. While dropped, the limb sprite is floored at LIMB_DROPPED_MIN_ALPHA
 * so it stays visible and clickable on the ground.
 */

/// Toggle that reveals the per-limb (arm/leg) alpha sliders.
/datum/preference/toggle/limb_alpha_per_limb
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "limb_alpha_per_limb"
	default_value = FALSE
	can_randomize = FALSE

/datum/preference/toggle/limb_alpha_per_limb/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return // Purely a UI/visibility gate, handled by the individual sliders.

/// Base type for a single bodypart's alpha slider. Stores the chosen value in dna.features
/// under "limb_alpha_[limb_zone]", which /obj/item/bodypart/proc/update_limb reads.
/datum/preference/numeric/limb_alpha
	abstract_type = /datum/preference/numeric/limb_alpha
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = 0
	maximum = 255
	step = 1
	can_randomize = FALSE
	/// The BODY_ZONE_* this slider controls. Also forms the dna.features key.
	var/limb_zone
	/// If TRUE, this slider only shows (and only applies) when the per-limb toggle is enabled.
	var/requires_toggle = FALSE
	/// If FALSE, the slider is hidden entirely. Kept around so head/chest can be re-enabled later.
	var/enabled = TRUE

/datum/preference/numeric/limb_alpha/create_default_value()
	return maximum // Fully opaque by default.

/datum/preference/numeric/limb_alpha/is_accessible(datum/preferences/preferences)
	if(!enabled)
		return FALSE
	if(!..(preferences))
		return FALSE
	if(requires_toggle && !preferences.read_preference(/datum/preference/toggle/limb_alpha_per_limb))
		return FALSE
	return TRUE

/datum/preference/numeric/limb_alpha/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	// Disabled sliders (head/chest for now), and limbs gated behind the toggle while it is off,
	// stay fully opaque regardless of any saved value.
	if(!enabled)
		value = maximum
	else if(requires_toggle && preferences && !preferences.read_preference(/datum/preference/toggle/limb_alpha_per_limb))
		value = maximum
	target.dna.features["limb_alpha_[limb_zone]"] = value
	return TRUE

// Head and chest are intentionally disabled for now (the sliders/keys are kept so they can be
// re-enabled by simply flipping `enabled` back to TRUE).
/datum/preference/numeric/limb_alpha/head
	savefile_key = "limb_alpha_head"
	limb_zone = BODY_ZONE_HEAD
	enabled = FALSE

/datum/preference/numeric/limb_alpha/chest
	savefile_key = "limb_alpha_chest"
	limb_zone = BODY_ZONE_CHEST
	enabled = FALSE

/datum/preference/numeric/limb_alpha/l_arm
	savefile_key = "limb_alpha_l_arm"
	limb_zone = BODY_ZONE_L_ARM
	requires_toggle = TRUE

/datum/preference/numeric/limb_alpha/r_arm
	savefile_key = "limb_alpha_r_arm"
	limb_zone = BODY_ZONE_R_ARM
	requires_toggle = TRUE

/datum/preference/numeric/limb_alpha/l_leg
	savefile_key = "limb_alpha_l_leg"
	limb_zone = BODY_ZONE_L_LEG
	requires_toggle = TRUE

/datum/preference/numeric/limb_alpha/r_leg
	savefile_key = "limb_alpha_r_leg"
	limb_zone = BODY_ZONE_R_LEG
	requires_toggle = TRUE
