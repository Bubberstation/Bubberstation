/obj/item/storage/belt/fannypack
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/belts/belts_teshari.dmi'

/obj/item/storage/belt/bluespace
	name = "bluespace tech's belt"
	desc = "Can hold various things, and specifically up to 21 things. You likely shouldn't have this."
	content_overlays = FALSE
	icon = 'modular_zubbers/icons/obj/clothing/belts/belts.dmi'
	icon_state = "bst_belt"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belts/belts.dmi'
	worn_icon_state = "bst_belt"
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/belts/belts_teshari.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	inhand_icon_state = "bst_belt"
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	strip_delay = 60 SECONDS
	w_class = WEIGHT_CLASS_TINY

	preload = FALSE
	storage_type = /datum/storage/bluespace_belt

/obj/item/storage/belt/bluespace/PopulateContents()
	new /obj/item/screwdriver/power/bluespace(src)
	new /obj/item/crowbar/power/bluespace(src)
	new /obj/item/weldingtool/experimental/bluespace(src)
	new /obj/item/multitool/abductor/bluespace(src)
	new /obj/item/construction/rcd/combat/admin(src)
	new /obj/item/pipe_dispenser/bluespace(src)
	new /obj/item/holosign_creator/atmos(src)
	new /obj/item/extinguisher/advanced(src)
