/datum/design/biogen/food_replicator
	name = "Food Replicator"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 100)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_NRI_FOOD,
	)

/datum/design/biogen/food_replicator/ration
	name = "Foreign Colonization Ration"
	id = "slavic_mre"
	materials = list(/datum/material/biomass = 550)
	build_path = /obj/item/storage/box/colonial_rations

/datum/design/biogen/food_replicator/pljeskavica
	name = "Foreign Colonization Ration, Main Course"
	id = "slavic_burger"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/food/colonial_course/pljeskavica

/datum/design/biogen/food_replicator/nachos
	name = "Foreign Colonization Ration, Side Dish"
	id = "mexican_chips"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/food/colonial_course/nachos

/datum/design/biogen/food_replicator/blins
	name = "Foreign Colonization Ration, Dessert"
	id = "slavic_crepes"
	build_path = /obj/item/food/colonial_course/blins

///Despite being in the medical.dm file, it's still used to fill your hunger up, as such, technically, is food.
/datum/design/biogen/food_replicator/glucose
	name = "Glucose Injector"
	id = "slavic_glupen"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/hypospray/medipen/glucose

/datum/design/biogen/food_replicator/spork
	name = "Foreign Colonization Ration, Utensils"
	id = "slavic_utens"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/storage/box/utensils

/datum/design/biogen/food_replicator/bubblegum
	name = "Foreign Colonization Ration, Bubblegum Pack"
	id = "slavic_gum"
	build_path = /obj/item/storage/box/gum/colonial

/datum/design/biogen/food_replicator/cup
	name = "Empty Paper Cup"
	id = "slavic_cup"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/reagent_containers/cup/glass/coffee/colonial/empty

/datum/design/biogen/food_replicator/tea
	name = "Powdered Black Tea"
	id = "slavic_tea"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_tea

/datum/design/biogen/food_replicator/coffee
	name = "Powdered Coffee"
	id = "slavic_coffee"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_coffee

/datum/design/biogen/food_replicator/cocoa
	name = "Powdered Hot Chocolate"
	id = "cocoa"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/coco

/datum/design/biogen/food_replicator/lemonade
	name = "Powdered Lemonade"
	id = "slavic_lemon"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_lemonade

/datum/design/biogen/food_replicator/replicator_sugar
	name = "Sugar"
	id = "slavic_sugar"
	materials = list(/datum/material/biomass = 5)
	make_reagent = /datum/reagent/consumable/sugar

/datum/design/biogen/food_replicator/powdered_milk
	name = "Powdered Milk"
	id = "slavic_milk"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_milk

/datum/design/biogen/food_replicator/water
	name = "Water"
	id = "slavic_water"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/water
