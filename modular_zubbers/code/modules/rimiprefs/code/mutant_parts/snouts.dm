/datum/preference/toggle/mutant_toggle/snout
	savefile_key = "snout_toggle"
	relevant_mutant_bodypart = "snout"

/datum/preference/choiced/mutant/snout
	savefile_key = "feature_snout"
	relevant_mutant_bodypart = "snout"
	type_to_check = /datum/preference/toggle/mutant_toggle/snout
	sprite_direction = EAST
	crop_area = list(14, 22, 24, 32) // We want just the head.

/datum/preference/choiced/mutant/snout/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if (icon_exists(sprite_accessory.icon, "m_snout_[original_icon_state]_ADJ[suffix]"))
		return "m_snout_[original_icon_state]_ADJ[suffix]"

	return "m_snout_[original_icon_state]_FRONT[suffix]"

/datum/preference/choiced/mutant/snout/apply_to_human(mob/living/carbon/human/target, value)
	. = ..()

	var/obj/item/bodypart/head/our_head = target.get_bodypart(BODY_ZONE_HEAD)
	if(isnull(our_head)) // dullahans.
		return

	if(.)
		our_head.bodyshape |= BODYSHAPE_SNOUTED
	else
		our_head.bodyshape &= ~BODYSHAPE_SNOUTED
	target.synchronize_bodytypes()
	target.synchronize_bodyshapes()

/datum/preference/mutant_color/snout
	savefile_key = "snout_color"
	relevant_mutant_bodypart = "snout"
	type_to_check = /datum/preference/toggle/mutant_toggle/snout

/datum/preference/emissive_toggle/snout
	savefile_key = "snout_emissive"
	relevant_mutant_bodypart = "snout"
	type_to_check = /datum/preference/toggle/mutant_toggle/snout
