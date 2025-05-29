/obj/item/seeds/telriis
	name = "pack of telriis seeds"
	desc = "These seeds grow into telriis plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "telriis"
	species = "telriis"
	plantname = "Telriis Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/telriis
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "telriis-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/mutationtoxin/pod = 0.1)

/obj/item/reagent_containers/food/snacks/grown/telriis
	seed = /obj/item/seeds/telriis
	name = "telriis"
	desc = "It's a little piece of telriis."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "telriis"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/mutationtoxin/pod = 0.1)
	tastes = list("plant" = 1)
