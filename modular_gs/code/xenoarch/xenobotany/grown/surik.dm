/obj/item/seeds/surik
	name = "pack of surik seeds"
	desc = "These seeds grow into surik plants."
	icon = 'modular_gs/icons/obj/xenobotany/seeds.dmi'
	icon_state = "surik"
	species = "surik"
	plantname = "Surik Plant"
	product = /obj/item/food/grown/surik
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_gs/icons/obj/xenobotany/growing.dmi'
	icon_grow = "surik-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/frostoil = 0.1)

/obj/item/food/grown/surik
	seed = /obj/item/seeds/surik
	name = "surik"
	desc = "It's a little piece of surik."
	icon = 'modular_gs/icons/obj/xenobotany/harvests.dmi'
	icon_state = "surik"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/frostoil = 0.1)
	tastes = list("snow" = 1)
