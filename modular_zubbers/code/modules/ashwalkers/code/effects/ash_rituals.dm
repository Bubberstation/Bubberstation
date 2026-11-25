/datum/ash_ritual/ash_bait
	name = "Drake Offering"
	desc = "Prepare a meal for a drake. In exchange for the offering, a drake will drop some of its scales."
	required_components = list(
		"north" = /obj/item/stack/ore/diamond,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/food/meat/steak/goliath,
		"west" = /obj/item/food/meat/steak/goliath,
	)
	consumed_components = list(
		/obj/item/stack/ore/diamond,
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/food/meat/steak/goliath,
		/obj/item/food/meat/steak/goliath,
	)
	ritual_success_items = list(
		/obj/item/food/meat/slab/drakebait,
	)
