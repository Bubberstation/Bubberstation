/datum/sprite_accessory/moth_antennae
	key = "moth_antennae"
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	organ_type = /obj/item/organ/antennae

/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/wearer)
	return is_deely_bobber_hidden(wearer, (HIDEHAIR | HIDEANTENNAE), SHOWSPRITEEARS)

/datum/sprite_accessory/moth_antennae/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
