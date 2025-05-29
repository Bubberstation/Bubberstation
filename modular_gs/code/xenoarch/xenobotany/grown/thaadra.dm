/obj/item/seeds/thaadra
	name = "pack of thaadra seeds"
	desc = "These seeds grow into thaadra plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "thaadra"
	species = "thaadra"
	plantname = "Thaadra Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/thaadra
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "thaadra-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/silver = 0.1)

/obj/item/reagent_containers/food/snacks/grown/thaadra
	seed = /obj/item/seeds/thaadra
	name = "thaadra"
	desc = "It's a little piece of thaadra."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "thaadra"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/silver = 0.1)
	tastes = list("silver" = 1)
