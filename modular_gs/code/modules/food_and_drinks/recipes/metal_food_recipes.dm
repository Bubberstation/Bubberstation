/datum/crafting_recipe/food/mburger
	name = "Metal Burger"
	reqs = list(
		/obj/item/stack/sheet/mineral/gold = 1,
		/obj/item/stack/sheet/mineral/silver = 1,
		/obj/item/stack/sheet/metal = 1
	)
	result = /obj/item/metal_food/mburger
	subcategory = CAT_MISCELLANEOUS //CAT_BURGER

/datum/crafting_recipe/food/mburger_calorite
	name = "Calotite Burger"
	reqs = list(
		/obj/item/stack/sheet/mineral/gold = 1,
		/obj/item/stack/sheet/mineral/calorite = 1,
		/obj/item/stack/sheet/metal = 1
	)
	result = /obj/item/metal_food/mburger_calorite
	subcategory = CAT_MISCELLANEOUS //CAT_BURGER

/datum/crafting_recipe/food/mfries
	name = "Fried rods"
	reqs = list(
		/obj/item/stack/rods = 3
	)
	result = /obj/item/metal_food/mfries
	subcategory = CAT_MISCELLANEOUS //CAT_BURGER
