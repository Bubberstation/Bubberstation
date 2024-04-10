/obj/item/storage/bag/plants
	name = "plant bag"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "plantbag"
	worn_icon_state = "plantbag"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/plants/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 100
	atom_storage.max_slots = 100
	atom_storage.set_holdable(list(
		/obj/item/food/grown,
		/obj/item/graft,
		/obj/item/grown,
		/obj/item/food/honeycomb,
		/obj/item/seeds,
		))
