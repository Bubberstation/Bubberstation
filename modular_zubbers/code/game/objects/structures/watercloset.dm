/obj/item/bikehorn/rubberducky
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/mask.dmi'

/obj/item/bikehorn/rubberducky/Initialize(mapload)
	. = ..()
	slot_flags |= ITEM_SLOT_MASK
