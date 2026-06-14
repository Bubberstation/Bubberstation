// Designs for the SmartFridge Organic Fabricator
// A gigantic variety of food and drink items, more expensive than a biogen (twice as, usually), and all artificial. Yummy slop!

// Ingredients

/datum/design/smartfridge_fabricator_milk
	name = "Synthetic Milk"
	id = "smartfridge_fabricator_milk"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_soymilk
	name = "Synthetic Soy Milk"
	id = "smartfridge_fabricator_soymilk"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/soymilk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_kortamilk
	name = "Synthetic Korta Milk"
	id = "smartfridge_fabricator_kortamilk"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2.4)
	make_reagent = /datum/reagent/consumable/korta_milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_ethanol
	name = "Synthetic Ethanol"
	id = "smartfridge_fabricator_ethanol"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/ethanol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_cream
	name = "Synthetic Cream"
	id = "smartfridge_fabricator_cream"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/cream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_enzyme
	name = "Synthetic Enzyme"
	id = "smartfridge_fabricator_enzyme"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/enzyme
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_flour
	name = "Synthetic Flour"
	id = "smartfridge_fabricator_flour"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_kflour
	name = "Synthetic Korta Flour"
	id = "smartfridge_fabricator_kflour"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2.4)
	make_reagent = /datum/reagent/consumable/korta_flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_cornstarch
	name = "Synthetic Corn Starch"
	id = "smartfridge_fabricator_cornstarch"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/corn_starch
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_rice
	name = "Synthetic Rice"
	id = "smartfridge_fabricator_rice"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/rice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_sugar
	name = "Synthetic Sugar"
	id = "smartfridge_fabricator_sugar"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/sugar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_cookingoil
	name = "Synthetic Cooking Oil"
	id = "smartfridge_fabricator_cooking_oil"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/nutriment/fat/oil
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_oliveoil
	name = "Synthetic Olive Oil"
	id = "smartfridge_fabricator_olive_oil"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/nutriment/fat/oil/olive
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_egg
	name = "Egg"
	id = "smartfridge_fabricator_egg"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/egg
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_chicken
	name = "Synthetic Chicken"
	id = "smartfridge_fabricator_chicken"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/chicken
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_meatslab
	name = "Synthetic Meat"
	id = "smartfridge_fabricator_meatslab"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/meatproduct
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_patty
	name = "Synthetic Meat Patty"
	id = "smartfridge_fabricator_patty"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/raw_patty
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_bacon
	name = "Synthetic Bacon"
	id = "smartfridge_fabricator_bacon"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/meat/rawbacon
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_sausage
	name = "Synthetic Sausage"
	id = "smartfridge_fabricator_sausage"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/raw_sausage
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_fillet
	name = "Synthetic Fish Fillet"
	id = "smartfridge_fabricator_fillet"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/fishmeat
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_butter
	name = "Butter"
	id = "smartfridge_fabricator_butter"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/butter
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_cheese
	name = "Cheese"
	id = "smartfridge_fabricator_cheese"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/cheese/wedge
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_cheese_firm
	name = "Firm Cheese"
	id = "smartfridge_fabricator_firm_cheese"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/cheese/firm_cheese_slice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/smartfridge_fabricator_seaweed_sheet
	name = "Seaweed Sheet"
	id = "smartfridge_fabricator_seaweedsheet"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 6)
	build_path = /obj/item/food/seaweedsheet
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

// Condiments

/datum/design/smartfridge_fabricator_black_pepper
	name = "Synthetic Black Pepper"
	id = "smartfridge_fabricator_black_pepper"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.8)
	make_reagent = /datum/reagent/consumable/blackpepper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_salt
	name = "Synthetic Salt"
	id = "smartfridge_fabricator_salt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.4)
	make_reagent = /datum/reagent/consumable/salt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_soysauce
	name = "Synthetic Soy Sauce"
	id = "smartfridge_fabricator_soysauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/soysauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_ketchup
	name = "Synthetic Ketchup"
	id = "smartfridge_fabricator_ketchup"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/ketchup
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_mayonnaise
	name = "Synthetic Mayonnaise"
	id = "smartfridge_fabricator_mayonnaise"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/mayonnaise
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_bbqsauce
	name = "Synthetic BBQ Sauce"
	id = "smartfridge_fabricator_bbqsauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/bbqsauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_hotsauce
	name = "Synthetic Hotsauce"
	id = "smartfridge_fabricator_hotsauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/capsaicin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/smartfridge_fabricator_coldsauce
	name = "Synthetic Coldsauce"
	id = "smartfridge_fabricator_coldsauce"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/frostoil
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

// Food/Drinks

/datum/design/smartfridge_fabricator_bun
	name = "Bun"
	id = "smartfridge_fabricator_bun"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/food/bun
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_rroll
	name = "Rootroll"
	id = "smartfridge_fabricator_rroll"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/food/rootroll
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_donut
	name = "Donut"
	id = "smartfridge_fabricator_donut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/donut/plain
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_jellydonut
	name = "Jelly Donut"
	id = "smartfridge_fabricator_jellydonut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/donut/jelly/plain
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_cannedtomatoes
	name = "Canned Tomatoes"
	id = "smartfridge_fabricator_cannedtomatoes"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/tomatoes
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_cannedbeans
	name = "Canned Beans"
	id = "smartfridge_fabricator_cannedbeans"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/beans
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_cannedpeaches
	name = "Canned Peaches"
	id = "smartfridge_fabricator_cannedpeaches"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/peaches
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_cannedtuna
	name = "Canned Tuna"
	id = "smartfridge_fabricator_cannedtuna"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/tuna
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_chap
	name = "CHAP"
	id = "smartfridge_fabricator_chap"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/food/canned/chap
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_cornuto
	name = "Cornuto"
	id = "smartfridge_fabricator_cornuto"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/cornuto
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_icecreamsandwich
	name = "Icecream Sandwich"
	id = "smartfridge_fabricator_icecreamsandwich"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/icecreamsandwich
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_yoghurt
	name = "Yoghurt"
	id = "smartfridge_fabricator_yoghurt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/yoghurt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_berryblast
	name = "Berry Blast Smoothie"
	id = "smartfridge_fabricator_berryblast"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/berry_blast
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_strawberrybanana
	name = "Strawberry Banana Smoothie"
	id = "smartfridge_fabricator_strawberrybanana"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/strawberry_banana
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_vanilladream
	name = "Vanilla Dream Smoothie"
	id = "smartfridge_fabricator_vanilladream"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/vanilla_dream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/smartfridge_fabricator_funkymonkey
	name = "Funky Monkey Smoothie"
	id = "smartfridge_fabricator_funkymonkey"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/funky_monkey
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

// Luxuries

/datum/design/smartfridge_fabricator_gum
	name = "Gum"
	id = "smartfridge_fabricator_gum"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_gum_wakeup
	name = "Activin 12 Hour Medicated Gum"
	id = "smartfridge_fabricator_gum_wakeup"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum/wake_up
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_energy_bar
	name = "High Power Energy Bar"
	id = "smartfridge_fabricator_energy_bar"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/energybar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_ciggies
	name = "Cigarettes"
	id = "smartfridge_fabricator_ciggies"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/storage/fancy/cigarettes/cigpack_uplift
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_engine_fodder
	name = "Engine Fodder"
	id = "smartfridge_fabricator_engine_fodder"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/moth_bag
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_fueljak_snack
	name = "Fueljack's Snack"
	id = "smartfridge_fabricator_fueljak_snack"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/moth_bag/fuel_jack
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_ricecracker
	name = "Rice Crackers"
	id = "smartfridge_fabricator_ricecracker"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/rice_crackers
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_candy
	name = "Candy Bar"
	id = "smartfridge_fabricator_candy"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/candy
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_stickorandom
	name = "Sticko Biscuit"
	id = "smartfridge_fabricator_stickorandom"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/sticko/random
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_chocolatebar
	name = "Chocolate Bar"
	id = "smartfridge_fabricator_chocolatebar"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/chocolatebar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_chips
	name = "Chips"
	id = "smartfridge_fabricator_chips"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/chips
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_shrimpchips
	name = "Shrimp Chips"
	id = "smartfridge_fabricator_shrimpchips"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/chips/shrimp
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/smartfridge_fabricator_cornchipsrandom
	name = "Boritos Cornchips"
	id = "smartfridge_fabricator_cornchipsrandom"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/cornchips/random
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)
