/datum/crafting_recipe/food/nekoroll
	added_foodtypes = MEAT
	removed_foodtypes = BREAKFAST | SEAFOOD
	name = "Neko roll"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/boiledrice = 1,
		/datum/reagent/consumable/sugar = 1
	)
	result = /obj/item/food/nekoroll
	category = CAT_SEAFOOD

/datum/crafting_recipe/food/bignekoroll
	added_foodtypes = MEAT
	removed_foodtypes = BREAKFAST | SEAFOOD
	name = "Nekobara roll"
	reqs = list(
		/obj/item/food/fishmeat = 2,
		/obj/item/food/boiledrice = 4,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/bignekoroll
	category = CAT_SEAFOOD
