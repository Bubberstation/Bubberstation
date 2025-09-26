/datum/crafting_recipe/food/redbayseasoning
	name = "Red Bay Seasoning"
	reqs = list(
		/obj/item/food/grown/peppercorn = 1,
		/obj/item/food/grown/bell_pepper = 1,
		/obj/item/food/grown/herbs = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/salt = 5,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/red_bay
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/curry_powder
	name = "Curry powder"
	reqs = list(
		/obj/item/food/grown/peppercorn = 1,
		/obj/item/food/grown/nakati = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/salt = 5,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/curry_powder
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/worcestershire
	name = "Worcestershire Sauce"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/garlic = 1,
		/datum/reagent/consumable/vinegar = 15,
		/datum/reagent/consumable/salt = 5,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/worcestershire
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/dashiconcentrate
	name = "Concentrated Dashi"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/seaweedsheet = 1,
		/datum/reagent/water/salt = 15,
		/obj/item/reagent_containers/condiment = 1,
	)
	result = /obj/item/reagent_containers/condiment/dashi_concentrate
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/chapmix
	name = "Chap mix"
	reqs = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/blackpepper = 5,
		/datum/reagent/consumable/salt = 15,
	)
	result = /obj/item/food/meat/chapmix
	category = CAT_MISCFOOD

/obj/item/food/meat/chapmix
	name = "chap mix"
	desc = "A mass of seasoned meat, ready to be processed."
	icon_state = "raw_meatloaf"
	foodtypes = MEAT|VEGETABLES|RAW

/datum/food_processor_process/chap
	input = /obj/item/food/meat/chapmix
	output = /obj/item/food/canned/chap

/datum/food_processor_process/chocolate
	input = /obj/item/food/chocolatebar
	output = /obj/item/food/cnds

/datum/food_processor_process/peanut
	input = /obj/item/food/grown/peanut
	output = /obj/item/food/peanuts

/datum/food_processor_process/chips
	input = /obj/item/food/tatortot
	output = /obj/item/food/chips

/datum/food_processor_process/tinnedtomatoes
	input = /obj/item/food/grown/tomato
	output = /obj/item/food/canned/tomatoes

/datum/food_processor_process/pinenuts
	input = /obj/item/food/grown/korta_nut
	output = /obj/item/food/canned/pine_nuts

/datum/food_processor_process/larvae
	input = /obj/item/trash/bee
	output = /obj/item/food/canned/larvae

/datum/crafting_recipe/food/snailmix
	name = "Snail mix"
	reqs = list(
		/obj/item/food/meat/slab/bugmeat = 1,
		/obj/item/food/grown/herbs = 1,
		/datum/reagent/consumable/blackpepper = 5,
		/datum/reagent/consumable/salt = 15,
	)
	result = /obj/item/food/meat/snailmix
	category = CAT_MISCFOOD

/obj/item/food/meat/snailmix
	name = "snail mix"
	desc = "A mass of seasoned meat, ready to be processed... DO NOT CONFUSE WITH TRAIL MIX!"
	icon_state = "raw_meatloaf"
	foodtypes = MEAT|VEGETABLES|RAW|BUGS

/datum/food_processor_process/desertsnails
	input = /obj/item/food/meat/snailmix
	output = /obj/item/food/canned/desert_snails
	food_multiplier = 2 //Giving a 2x multiplier as bug meat is slightly rarer to come across once you've killed all the snails.

/datum/crafting_recipe/food/mac_balls_fresh
	name = "Macheronirölen (Mac balls) Fresh"
	reqs = list(
		/obj/item/food/spaghetti/mac_n_cheese = 1,
		/obj/item/food/tomato_sauce = 1,
		/datum/reagent/consumable/cornmeal_batter = 5
	)
	result = /obj/item/food/mac_balls
	removed_foodtypes = JUNKFOOD
	added_foodtypes = FRIED
	category = CAT_MOTH
