/obj/item/seeds/amauri
	name = "pack of amauri seeds"
	desc = "These seeds grow into amauri plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "amauri"
	species = "amauri"
	plantname = "Amauri Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/amauri
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "amauri-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/mutationtoxin/shadow = 0.1)

/obj/item/reagent_containers/food/snacks/grown/amauri
	seed = /obj/item/seeds/amauri
	name = "amauri"
	desc = "It's a little piece of amauri."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "amauri"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/mutationtoxin/shadow = 0.1)
	tastes = list("shadow" = 1)
