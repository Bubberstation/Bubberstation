/obj/item/seeds/vale
	name = "pack of vale seeds"
	desc = "These seeds grow into vale plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "vale"
	species = "vale"
	plantname = "Vale Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/vale
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "vale-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/slime_toxin = 0.1)

/obj/item/reagent_containers/food/snacks/grown/vale
	seed = /obj/item/seeds/vale
	name = "vale"
	desc = "It's a little piece of vale."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "vale"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/slime_toxin = 0.1)
	tastes = list("slime" = 1)
