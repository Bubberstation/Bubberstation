/obj/item/seeds/rockfruit
	name = "pack of rockfruit seedlings"
	desc = "Small seedlings of the golem rockfruit plant. There's a warning label on its packaging: \n\
	\"Remember: Legally speaking, rocking is more legal than stoning. \n \
	We are not liable for any injury, death, or complete body evaporation caused by using or growing these plants\""
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-rockfruit"
	species = "rock"
	plantname = "Rockfruits"
	product = /obj/item/food/grown/rockfruit

	lifespan = 20
	maturation = 3
	production = 2
	yield = 2
	instability = 0 // Rocks are very stable


	growthstages = 2
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'

	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy,
				/datum/plant_gene/trait/fire_resistance,
				/datum/plant_gene/trait/stable_stats, // It's a rock
				/datum/plant_gene/trait/preserved)

/obj/item/food/grown/rockfruit
	seed = /obj/item/seeds/rockfruit
	name = "Rockfruit"
	desc = "A small piece of rock. The inside seems to be fruity, with the outside being a rocky shell, commonly enjoyed by golem folk"
	throwforce = 10
