/obj/item/seeds/gelthi
	name = "pack of gelthi seeds"
	desc = "These seeds grow into gelthi plants."
	icon = 'modular_gs/icons/obj/xenobotany/seeds.dmi'
	icon_state = "gelthi"
	species = "gelthi"
	plantname = "Gelthi Plant"
	product = /obj/item/food/grown/gelthi
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_gs/icons/obj/xenobotany/growing.dmi'
	icon_grow = "gelthi-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/gold = 0.1)

/obj/item/food/grown/gelthi
	seed = /obj/item/seeds/gelthi
	name = "gelthi"
	desc = "It's a little piece of gelthi."
	icon = 'modular_gs/icons/obj/xenobotany/harvests.dmi'
	icon_state = "gelthi"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/gold = 0.1)
	tastes = list("gold" = 1)
