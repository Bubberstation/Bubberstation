/datum/sprite_accessory/neck_accessory
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/neck_accessory.dmi'
	key = "neck_acc"
	relevent_layers = list(EXTERNAL_ADJACENT, EXTERNAL_FRONT)
	organ_type = /obj/item/organ/neck_accessory

/datum/sprite_accessory/neck_accessory/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/neck_accessory/is_hidden(mob/living/carbon/human/wearer)
	if(wearer.w_uniform)
		if(key in wearer.try_hide_mutant_parts)
			return TRUE
	return FALSE

/datum/sprite_accessory/neck_accessory/sylveon_bow
	name = "Sylveon Neck Bow"
	icon_state = "sylveon_bow"
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_HUMANOID)
	relevent_layers = list(EXTERNAL_BEHIND, EXTERNAL_FRONT)
	color_src = USE_MATRIXED_COLORS
//	ckey_whitelist = list("whirlsam" = TRUE)
