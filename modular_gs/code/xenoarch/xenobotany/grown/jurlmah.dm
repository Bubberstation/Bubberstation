/obj/item/seeds/jurlmah
	name = "pack of jurlmah seeds"
	desc = "These seeds grow into jurlmah plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "jurlmah"
	species = "jurlmah"
	plantname = "Jurlmah Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/jurlmah
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "jurlmah-stage"
	growthstages = 5
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/cryoxadone = 0.1)

/obj/item/reagent_containers/food/snacks/grown/jurlmah
	seed = /obj/item/seeds/jurlmah
	name = "jurlmah"
	desc = "It's a little piece of jurlmah."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "jurlmah"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/medicine/cryoxadone = 0.1)
	tastes = list("cold" = 1)
