/datum/feeders_den_goodie
	/// What is the name of the goodie we want to buy?
	var/name
	/// How much credits does this cost to buy?
	var/credit_cost = 0
	/// How much stock of this can be bought? If this is null, infinite can be bought
	var/initial_stock
	/// What is the path of the item to dispense?
	var/item_to_dispense

/datum/feeders_den_goodie/food_vendor_refill
	name = "Food Vendor Refill"
	credit_cost = 100
	item_to_dispense = /obj/item/vending_refill/mealdor

/datum/feeders_den_goodie/nutripump_turbo
	name = "Nutri-Pump TURBO Autosurgeon"
	credit_cost = 150
	item_to_dispense = /obj/item/autosurgeon/nutripump_turbo

/datum/feeders_den_goodie/nutripump_turbo
	name = "Mobility Nanite Core Autosurgeon"
	credit_cost = 400
	item_to_dispense = /obj/item/autosurgeon/fat_mobility

/datum/feeders_den_goodie/fatbeam_gun
	name = "Fatbeam gun"
	credit_cost = 400
	item_to_dispense = /obj/item/gun/fatbeam
	initial_stock = 2

/datum/feeders_den_goodie/grenade_weak
	name = "Lipofier Grenade (Weak)"
	credit_cost = 120
	item_to_dispense = /obj/item/grenade/chem_grenade/lipoifier_weak
	initial_stock = 6

/datum/feeders_den_goodie/grenade_strong
	name = "Lipofier Grenade (Strong)"
	credit_cost = 360
	item_to_dispense = /obj/item/grenade/chem_grenade/lipoifier_strong
	initial_stock = 3

/datum/feeders_den_goodie/chameleon
	name = "Chameleon Kit"
	credit_cost = 300
	item_to_dispense = /obj/item/storage/box/syndie_kit/chameleon
	initial_stock = 2

/datum/feeders_den_goodie/pie_cannon
	name = "Banana Cream Pie Cannon"
	credit_cost = 500
	item_to_dispense = /obj/item/pneumatic_cannon/pie/selfcharge
	initial_stock = 2

/datum/feeders_den_goodie/thermals
	name = "Thermal Imaging Glasses"
	credit_cost = 400
	item_to_dispense = /obj/item/clothing/glasses/thermal/syndi
	initial_stock = 2

/datum/feeders_den_goodie/reagent_gun
	name = "Reagent Gun"
	credit_cost = 500
	item_to_dispense = /obj/item/gun/chem

/datum/feeders_den_goodie/protolathe
	name = "R&D Kit"
	credit_cost = 1500
	item_to_dispense = /obj/item/storage/box/rndboards
	initial_stock = 2

/datum/feeders_den_goodie/docility_implant
	name = "Docility Implant"
	credit_cost = 100
	item_to_dispense = /obj/item/implantcase/docile
	initial_stock = 5

/datum/feeders_den_goodie/docility_implant/livestock
	name = "Livestock Implant"
	credit_cost = 250
	item_to_dispense = /obj/item/implantcase/docile/livestock

/datum/feeders_den_goodie/space_suit
	name = "Boxed Space Suit and Helmet"
	credit_cost = 300
	item_to_dispense = /obj/item/storage/box/syndie_kit/space
	initial_stock = 2

/datum/feeders_den_goodie/mootant_mutation_toxin
	name = "Mootant Mutation Pill"
	credit_cost = 200
	item_to_dispense = /obj/item/reagent_containers/pill/mutationmootant
	initial_stock = 5
