/obj/item/seeds/berry
	mutatelist = list(/obj/item/seeds/berry/glow, /obj/item/seeds/berry/poison, /obj/item/seeds/berry/blueberry)

/obj/item/seeds/berry/blueberry
	name = "pack of blueberry seeds"
	desc = "These seeds grow into blueberry bushes."
	species = "blueberry"
	plantname = "Blueberry Bush"
	product = /obj/item/reagent_containers/food/snacks/grown/berries/blueberry
	mutatelist = list()
	reagents_add = list(/datum/reagent/blueberry_juice = 0.1)
	potency = 1
	yield = 1
	production = 10
	rarity = 30
	icon = 'GainStation13/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-blueberry"
	growing_icon = 'GainStation13/icons/obj/hydroponics/growing.dmi'
	icon_grow = "berry-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "berry-dead" // Same for the dead icon
	icon_harvest = "blueberry-harvest"

/obj/item/reagent_containers/food/snacks/grown/berries/blueberry
	seed = /obj/item/seeds/berry/blueberry
	name = "bunch of blueberries"
	desc = "Taste so good, you might turn blue!"
	icon = 'GainStation13/icons/obj/hydroponics/harvest.dmi'
	icon_state = "blueberrypile"
	filling_color = "#5d00c7"
	foodtype = FRUIT
	juice_results = list(/datum/reagent/blueberry_juice = 20)
	tastes = list("blueberry" = 1)
	distill_reagent = null
	wine_power = 50
