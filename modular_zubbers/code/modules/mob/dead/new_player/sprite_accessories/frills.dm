//Im leaving HIDEEARS flag here so we don't have to update everything to include HIDEFRILLS
/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/human)
	if((human.covered_slots & HIDEEARS) || (key in human.try_hide_mutant_parts) || (human.covered_slots & HIDEFRILLS))
		return TRUE

	return FALSE

/datum/sprite_accessory/frills/najahood
	name = "Naja Hood"
	icon_state = "najahood"
	icon = 'modular_zubbers/icons/customization/frills.dmi'
	color_src = USE_MATRIXED_COLORS
