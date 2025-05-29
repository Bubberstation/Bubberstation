//this is a recipe file for just random shit we've ported from other servers
//you can call me lazy if you'd like but I didn't really feel like making 10 different folders and files just to port a couple simple meals

//writing down recipe categories, should be handy
//CAT_FOOD,CAT_BREAD,CAT_BURGER,CAT_CAKE,CAT_EGG,CAT_MEAT,CAT_MISCFOOD,CAT_PASTRY,CAT_PIE,CAT_PIZZ,CAT_SALAD,CAT_SANDWICH,CAT_SOUP,CAT_SPAGHETTI,CAT_FISH,CAT_ICE


/datum/crafting_recipe/food/doner
	name = "Doner Kebab"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/bun = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/doner_kebab
	subcategory = CAT_BURGER


/datum/crafting_recipe/food/lasagna
	name = "Lasagna"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/lasagna
	subcategory = CAT_SPAGHETTI


/datum/crafting_recipe/food/corndog
	name = "Corndog"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/obj/item/reagent_containers/food/snacks/sausage = 1,
		/datum/reagent/consumable/cooking_oil = 5
	)
	result = /obj/item/reagent_containers/food/snacks/corndog
	subcategory = CAT_MEAT


/datum/crafting_recipe/food/turkey
	name = "Whole Turkey"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 2,
		/obj/item/reagent_containers/food/snacks/sausage = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 2,
	)
	result = /obj/item/reagent_containers/food/snacks/turkey
	subcategory = CAT_MEAT


/datum/crafting_recipe/food/brownies
	name = "Brownies"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/ethanol/creme_de_cacao = 10,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/butter = 2
	)
	result = /obj/item/reagent_containers/food/snacks/brownies
	subcategory = CAT_CAKE


/datum/crafting_recipe/food/cosmic_brownies
	name = "Cosmic Brownies"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/brownies = 1,
		/datum/reagent/consumable/sprinkles = 10
	)
	result = /obj/item/reagent_containers/food/snacks/brownies_cosmic
	subcategory = CAT_CAKE


/datum/crafting_recipe/food/cosmic_brownies
	name = "Cosmic Brownies"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/brownies = 1,
		/datum/reagent/consumable/sprinkles = 10
	)
	result = /obj/item/reagent_containers/food/snacks/brownies_cosmic
	subcategory = CAT_CAKE


/datum/crafting_recipe/food/bacon_and_eggs
	name = "Bacon and Eggs"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/friedegg = 2,
		/obj/item/reagent_containers/food/snacks/meat/bacon = 1
	)
	result = /obj/item/reagent_containers/food/snacks/bacon_and_eggs
	subcategory = CAT_EGG


/datum/crafting_recipe/food/egg_muffin
	name = "Egg muffin"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/friedegg = 1,
		/obj/item/reagent_containers/food/snacks/muffin = 1
	)
	result = /obj/item/reagent_containers/food/snacks/eggmuffin
	subcategory = CAT_EGG


/datum/crafting_recipe/food/cinnamon_roll
	name = "Cinnamon roll"
	reqs = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/vanilla = 2,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cinammonbun
	subcategory = CAT_PASTRY

//GS Food

/datum/crafting_recipe/food/lavaland_stew
	name = "Lavaland Stew"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_stem = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit = 2,
		/obj/item/reagent_containers/glass/bowl/mushroom_bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/lavaland_stew
	subcategory = CAT_SOUP
