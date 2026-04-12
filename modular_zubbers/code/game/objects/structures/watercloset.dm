/obj/item/bikehorn/rubberducky
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/mask.dmi'

/obj/item/bikehorn/rubberducky/Initialize(mapload)
	. = ..()
	slot_flags |= ITEM_SLOT_MASK

/obj/structure/sink/basin
	name = "sink basin"
	icon = 'modular_zubbers/icons/obj/watercloset.dmi'
	icon_state = "sink_basin"
	pixel_z = 0
	pixel_shift = 0

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink/basin, (0))
