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

/// Summon Ore Seed
/datum/ash_ritual/summon_ore_seed
	name = "Summon Ore Seed"
	desc = "Summons a seed that, when used in the hand, will cause a tendril to dig through the crust of the surface causing an ore vent to appear."
	required_components = list(
		"north" = /obj/item/crusher_trophy/legion_skull,
		"south" = /obj/item/organ/monster_core/regenerative_core,
		"east" = /obj/item/crusher_trophy/watcher_wing,
		"west" = /obj/item/crusher_trophy/goliath_tentacle,
	)
	consumed_components = list(
		/obj/item/crusher_trophy/legion_skull,
		/obj/item/organ/monster_core/regenerative_core,
		/obj/item/crusher_trophy/watcher_wing,
		/obj/item/crusher_trophy/goliath_tentacle,
	)
	ritual_success_items = list(
		/obj/item/ash_seed/vent,
	)
