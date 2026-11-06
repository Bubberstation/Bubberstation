// Designs for the SmartFridge Organic Fabricator
// A gigantic variety of food and drink items, more expensive than a biogen (twice as, usually), and all artificial. Yummy slop!

// Ingredients

/datum/design/biogen/smartfridge_fabricator_milk
	name = "Synthetic Milk"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_soymilk
	name = "Synthetic Soy Milk"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/soymilk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_kortamilk
	name = "Synthetic Korta Milk"
	materials = list(/datum/material/biomass = 2.4)
	make_reagent = /datum/reagent/consumable/korta_milk
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_ethanol
	name = "Synthetic Ethanol"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/ethanol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cream
	name = "Synthetic Cream"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/cream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_enzyme
	name = "Synthetic Enzyme"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/enzyme
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_flour
	name = "Synthetic Flour"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_kflour
	name = "Synthetic Korta Flour"
	materials = list(/datum/material/biomass = 2.4)
	make_reagent = /datum/reagent/consumable/korta_flour
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cornstarch
	name = "Synthetic Corn Starch"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/corn_starch
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_rice
	name = "Synthetic Rice"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/rice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_sugar
	name = "Synthetic Sugar"
	materials = list(/datum/material/biomass = 1.2)
	make_reagent = /datum/reagent/consumable/sugar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cookingoil
	name = "Synthetic Cooking Oil"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/nutriment/fat/oil
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_oliveoil
	name = "Synthetic Olive Oil"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/nutriment/fat/oil/olive
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_vinegar
	name = "Synthetic Vinegar"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/vinegar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_egg
	name = "Egg"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/egg
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_chicken
	name = "Synthetic Chicken"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/chicken
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_meatslab
	name = "Synthetic Meat"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/meat/slab/meatproduct
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_patty
	name = "Synthetic Meat Patty"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/raw_patty
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_bacon
	name = "Synthetic Bacon"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/meat/rawbacon
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_sausage
	name = "Synthetic Sausage"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/raw_sausage
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_fillet
	name = "Synthetic Fish Fillet"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/fishmeat
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_butter
	name = "Butter"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/butter
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cheese
	name = "Cheese"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/cheese/wedge
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_cheese_firm
	name = "Firm Cheese"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/food/cheese/firm_cheese_slice
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

/datum/design/biogen/smartfridge_fabricator_seaweed_sheet
	name = "Seaweed Sheet"
	materials = list(/datum/material/biomass = 6)
	build_path = /obj/item/food/seaweedsheet
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_INGREDIENT)

// Condiments

/datum/design/biogen/smartfridge_fabricator_black_pepper
	name = "Synthetic Black Pepper"
	materials = list(/datum/material/biomass = 0.8)
	make_reagent = /datum/reagent/consumable/blackpepper
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_salt
	name = "Synthetic Salt"
	materials = list(/datum/material/biomass = 0.4)
	make_reagent = /datum/reagent/consumable/salt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_honey
	name = "Synthetic Honey"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/honey
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_soysauce
	name = "Synthetic Soy Sauce"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/soysauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_teriyaki
	name = "Synthetic Teriyaki Sauce"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/nutriment/soup/teriyaki
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_ketchup
	name = "Synthetic Ketchup"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/ketchup
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_mayonnaise
	name = "Synthetic Mayonnaise"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/consumable/mayonnaise
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_bbqsauce
	name = "Synthetic BBQ Sauce"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/bbqsauce
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_hotsauce
	name = "Synthetic Hotsauce"
	materials = list(/datum/material/biomass = 2)
	make_reagent = /datum/reagent/consumable/capsaicin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

/datum/design/biogen/smartfridge_fabricator_coldsauce
	name = "Synthetic Coldsauce"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/frostoil
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONDIMENTS)

// Food/Drinks

/datum/design/biogen/smartfridge_fabricator_bun
	name = "Bun"
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/food/bun
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_rroll
	name = "Rootroll"
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/food/rootroll
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_donut
	name = "Donut"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/food/donut/plain
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_jellydonut
	name = "Jelly Donut"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/donut/jelly/plain
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedtomatoes
	name = "Canned Tomatoes"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/tomatoes
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedbeans
	name = "Canned Beans"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/beans
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedpeaches
	name = "Canned Peaches"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/peaches
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cannedtuna
	name = "Canned Tuna"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/canned/tuna
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_chap
	name = "CHAP"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/food/canned/chap
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_cornuto
	name = "Cornuto"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/cornuto
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_icecreamsandwich
	name = "Icecream Sandwich"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/icecreamsandwich
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_yoghurt
	name = "Yoghurt"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/yoghurt
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_berryblast
	name = "Berry Blast Smoothie"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/berry_blast
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_strawberrybanana
	name = "Strawberry Banana Smoothie"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/strawberry_banana
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_vanilladream
	name = "Vanilla Dream Smoothie"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/vanilla_dream
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

/datum/design/biogen/smartfridge_fabricator_funkymonkey
	name = "Funky Monkey Smoothie"
	materials = list(/datum/material/biomass = 3)
	make_reagent = /datum/reagent/consumable/funky_monkey
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_CONSUMABLES)

// Luxuries

/datum/design/biogen/smartfridge_fabricator_gum
	name = "Gum"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_gum_wakeup
	name = "Activin 12 Hour Medicated Gum"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum/wake_up
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_energy_bar
	name = "High Power Energy Bar"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/energybar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_ciggies
	name = "Cigarettes"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/storage/fancy/cigarettes/cigpack_uplift
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_engine_fodder
	name = "Engine Fodder"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/moth_bag
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_fueljak_snack
	name = "Fueljack's Snack"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/moth_bag/fuel_jack
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_ricecracker
	name = "Rice Crackers"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/vendor_snacks/rice_crackers
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_candy
	name = "Candy Bar"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/candy
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_stickorandom
	name = "Sticko Biscuit"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/sticko/random
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_chocolatebar
	name = "Chocolate Bar"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/food/chocolatebar
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_chips
	name = "Chips"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/chips
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_shrimpchips
	name = "Shrimp Chips"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/chips/shrimp
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)

/datum/design/biogen/smartfridge_fabricator_cornchipsrandom
	name = "Boritos Cornchips"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/food/cornchips/random
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SFOF_LUXURIES)
