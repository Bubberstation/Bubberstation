/datum/sprite_accessory/skrell_hair
	icon = 'modular_zubbers/master_files/icons/mob/sprite_accessory/skrell_hair.dmi'
	generic = "Skrell Headtails"
	key = "skrell_hair"
	color_src = USE_MATRIXED_COLORS
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/skrell_hair

/datum/sprite_accessory/skrell_hair/is_hidden(mob/living/carbon/human/wearer)
	if((wearer.head?.flags_inv & HIDEHAIR) || (wearer.wear_mask?.flags_inv & HIDEHAIR))
		return TRUE

	return FALSE

/datum/sprite_accessory/skrell_hair/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/skrell_hair/long
	name = "Female (Long)"
	icon_state = "long"

/datum/sprite_accessory/skrell_hair/short
	name = "Male (Short)"
	icon_state = "short"
