/datum/sprite_accessory/genital/butt
	icon = 'modular_zzplurt/icons/mob/human/genitals/butt.dmi'
	organ_type = /obj/item/organ/external/genital/butt
	associated_organ_slot = ORGAN_SLOT_BUTT
	key = ORGAN_SLOT_BUTT
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/genital/butt/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/butt/pair
	icon_state = "pair"
	name = "Pair"


/datum/sprite_accessory/genital/anus
	icon = 'modular_zzplurt/icons/mob/human/genitals/anus.dmi'
	organ_type = /obj/item/organ/external/genital/anus
	associated_organ_slot = ORGAN_SLOT_BUTT // :3
	key = ORGAN_SLOT_ANUS
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	relevent_layers = list(BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/genital/anus/normal
	icon_state = "donut"
	color_src = USE_MATRIXED_COLORS
	name = "Donut"

/datum/sprite_accessory/genital/anus/squished
	icon_state = "squished"
	name = "Squished"
	color_src = USE_MATRIXED_COLORS


/datum/sprite_accessory/genital/belly
	icon = 'modular_zzplurt/icons/mob/human/genitals/belly.dmi'
	organ_type = /obj/item/organ/external/genital/belly
	associated_organ_slot = ORGAN_SLOT_BELLY
	key = ORGAN_SLOT_BELLY
	color_src = USE_ONE_COLOR
	always_color_customizable = TRUE
	relevent_layers = list(BODY_FRONT_LAYER, BODY_BEHIND_LAYER)
	genetic = TRUE

/datum/sprite_accessory/genital/belly/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/belly/normal
	icon_state = "pair" //????
	name = "Belly"
