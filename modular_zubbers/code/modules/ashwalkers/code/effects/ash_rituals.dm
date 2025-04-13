/datum/ash_ritual/ash_bait
	name = "Drake Offering"
	desc = "Prepare a meal for a drake."
	required_components = list(
		"north" = /obj/item/crusher_trophy/legion_skull,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/food/meat/steak/goliath,
		"west" = /obj/item/stack/sheet/sinew,
	)
	consumed_components = list(
		/obj/item/crusher_trophy/legion_skull,
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/food/meat/steak/goliath,
		/obj/item/stack/sheet/sinew,
	)
	ritual_success_items = list(
		/obj/item/food/meat/slab/drakebait,
	)
