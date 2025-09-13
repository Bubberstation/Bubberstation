/datum/sprite_accessory/genital/butt
	icon = 'modular_gs/icons/mob/human/genitals/butt.dmi'
	organ_type = /obj/item/organ/genital/butt
	associated_organ_slot = ORGAN_SLOT_BUTT
	key = ORGAN_SLOT_BUTT
	color_src = USE_ONE_COLOR
	always_color_customizable = TRUE
	has_skintone_shading = TRUE
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/genital/butt/none
    icon_state = "none"
    name = SPRITE_ACCESSORY_NONE
    factual = FALSE
    color_src = null

/datum/sprite_accessory/genital/butt/pair
    icon_state = "pair"
    name = "Pair" //a pair of buns i guess

/datum/sprite_accessory/genital/belly
	icon = 'modular_gs/icons/mob/human/genitals/belly.dmi'
	organ_type = /obj/item/organ/genital/belly
	associated_organ_slot = ORGAN_SLOT_BELLY
	key = ORGAN_SLOT_BELLY
	color_src = USE_ONE_COLOR
	always_color_customizable = TRUE
	has_skintone_shading = TRUE
	relevent_layers = list(BODY_FRONT_LAYER, BODY_BEHIND_LAYER)

/datum/sprite_accessory/genital/belly/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/belly/normal
	icon_state = "belly"
	name = "Belly"

/datum/sprite_accessory/genital/belly/round
	icon = 'modular_gs/icons/mob/human/genitals/belly_round.dmi'
	icon_state = "round"
	name = "Round Belly"
