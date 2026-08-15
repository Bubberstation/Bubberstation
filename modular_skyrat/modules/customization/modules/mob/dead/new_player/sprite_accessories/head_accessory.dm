/datum/sprite_accessory/head_accessory
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/head_accessory.dmi'
	key = "head_acc"
	relevent_layers = list(EXTERNAL_ADJACENT, EXTERNAL_FRONT)
	organ_type = /obj/item/organ/head_accessory

/datum/sprite_accessory/head_accessory/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/H)
	if(H.covered_slots & HIDEHAIR)
		return TRUE
	return FALSE

/datum/sprite_accessory/head_accessory/sylveon_bow
	name = "Sylveon Head Bow"
	icon_state = "sylveon_bow"
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_HUMANOID)
	relevent_layers = list(EXTERNAL_BEHIND, EXTERNAL_FRONT)
	color_src = USE_MATRIXED_COLORS
//	ckey_whitelist = list("whirlsam" = TRUE)
