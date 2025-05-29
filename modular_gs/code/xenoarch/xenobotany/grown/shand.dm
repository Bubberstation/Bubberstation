/obj/item/seeds/shand
	name = "pack of shand seeds"
	desc = "These seeds grow into shand plants."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "shand"
	species = "shand"
	plantname = "Shand Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/shand
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'GainStation13/code/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "shand-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/pax = 0.1)

/obj/item/reagent_containers/food/snacks/grown/shand
	seed = /obj/item/seeds/shand
	name = "shand"
	desc = "It's a little piece of shand."
	icon = 'GainStation13/code/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "shand"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/pax = 0.1)
	tastes = list("peace" = 1)
