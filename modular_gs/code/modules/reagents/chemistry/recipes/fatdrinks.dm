//GS13 drink recipes

/datum/chemical_reaction/belly_bloats
	name = "Belly Bloats"
	id = /datum/reagent/consumable/ethanol/belly_bloats
	results = list(/datum/reagent/consumable/ethanol/belly_bloats = 2)
	required_reagents = list(/datum/reagent/consumable/gibbfloats = 1, /datum/reagent/consumable/ethanol/beer = 1)

/datum/chemical_reaction/blobby_mary
	name = "Blobby Mary"
	id = /datum/reagent/consumable/ethanol/blobby_mary
	results = list(/datum/reagent/consumable/ethanol/blobby_mary = 3)
	required_reagents = list(/datum/reagent/consumable/tomatojuice = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/lipoifier = 1)

/datum/chemical_reaction/beltbuster_mead
	name = "Beltbuster Mead"
	id = /datum/reagent/consumable/ethanol/beltbuster_mead
	results = list(/datum/reagent/consumable/ethanol/beltbuster_mead = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/mead = 1, /datum/reagent/consumable/ethanol = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/lipoifier = 1)

/datum/chemical_reaction/heavy_cafe1
	name = "Heavy Cafe"
	id = /datum/reagent/consumable/heavy_cafe
	results = list(/datum/reagent/consumable/heavy_cafe = 3)
	required_reagents = list(/datum/reagent/consumable/cafe_latte = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/heavy_cafe2
	name = "Heavy Cafe"
	id = /datum/reagent/consumable/heavy_cafe
	results = list(/datum/reagent/consumable/heavy_cafe = 3)
	required_reagents = list(/datum/reagent/consumable/soy_latte = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/fruits_tea
	name = "Fruits Tea"
	id = /datum/reagent/consumable/fruits_tea
	results = list(/datum/reagent/consumable/fruits_tea = 3)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/lemonjuice = 1, /datum/reagent/consumable/tea = 1)

/datum/chemical_reaction/snakebite
	name = "Snakebite"
	id = /datum/reagent/consumable/snakebite
	results = list(/datum/reagent/consumable/snakebite = 3)
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/lipoifier = 1)

/datum/chemical_reaction/milkshake_vanilla
	name = "Vanilla Milkshake"
	id = /datum/reagent/consumable/milkshake_vanilla
	results = list(/datum/reagent/consumable/milkshake_vanilla = 3)
	required_reagents = list(/datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/vanilla = 1)

/datum/chemical_reaction/milkshake_chocolate
	name = "Chocolate Milkshake"
	id = /datum/reagent/consumable/milkshake_chocolate
	results = list(/datum/reagent/consumable/milkshake_chocolate = 3)
	required_reagents = list(/datum/reagent/consumable/milk/chocolate_milk = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/coco = 1)

/obj/structure/reagent_dispensers/keg/lipoifier //gs13
	name = "keg of lipoifier"
	desc = "Good luck downing that and not getting beached."
	icon_state = "orangekeg"
	reagent_id = /datum/reagent/consumable/lipoifier
	tank_volume = 300
