/obj/item/seeds/amauri
	name = "pack of amauri seeds"
	desc = "These seeds grow into amauri plants."
	icon = 'modular_gs/icons/obj/xenobotany/seeds.dmi'
	icon_state = "amauri"
	species = "amauri"
	plantname = "Amauri Plant"
	product = /obj/item/food/grown/amauri
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_gs/icons/obj/xenobotany/growing.dmi'
	icon_grow = "amauri-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/mutationtoxin/shadow = 0.1)

/obj/item/food/grown/amauri
	seed = /obj/item/seeds/amauri
	name = "amauri"
	desc = "It's a little piece of amauri."
	icon = 'modular_gs/icons/obj/xenobotany/harvests.dmi'
	icon_state = "amauri"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/mutationtoxin/shadow = 0.1)
	tastes = list("shadow" = 1)
