/obj/item/seeds/nofruit
	name = "pack of nofruit seeds"
	desc = "These seeds grow into nofruit plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "nofruit"
	species = "nofruit"
	plantname = "Nofruit Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/nofruit
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "nofruit-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nothing = 0.1, /datum/reagent/consumable/laughter = 0.1)

/obj/item/reagent_containers/food/snacks/grown/nofruit
	seed = /obj/item/seeds/nofruit
	name = "nofruit"
	desc = "It's a little piece of nofruit."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "nofruit"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/nothing = 0.1, /datum/reagent/consumable/laughter = 0.1)
	tastes = list("entertainment" = 1)
