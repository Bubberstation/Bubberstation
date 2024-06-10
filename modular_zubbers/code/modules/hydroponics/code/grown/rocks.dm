/obj/item/seeds/rockfruit
	name = "pack of rockfruit seedlings"
	desc = "Small seedlings of the golem rockfruit plant. There's a warning label on its packaging: \n\
	\"Remember: Legally speaking, rocking is more legal than stoning. \n \
	We are not liable for any injury, death, or complete body evaporation caused by using or growing these plants\""
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-rockfruit"
	species = "rock"
	plantname = "Rockfruits"
	product = /obj/item/grown/rockfruit

	lifespan = 20
	endurance = 45

	potency = 15
	maturation = 8
	production = 4
	yield = 2
	instability = 0 // Rocks are very stable


	growthstages = 2
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'

	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy,
				/datum/plant_gene/trait/fire_resistance,
				/datum/plant_gene/trait/stable_stats, // It's a rock
				/datum/plant_gene/trait/preserved)

	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.01,
						/datum/reagent/consumable/nutriment = 0.01,
						)


/obj/item/grown/rockfruit
	seed = /obj/item/seeds/rockfruit

	name = "Rockfruit"
	desc = "Piece of rockfruit, commonly enjoyed by golem folk. The inside seems to be fruity, with the outside being a rocky shell."
	force = 5 // Comparatively shit considering a nettle is 15
	throwforce = 10 // Less shit but hey, it is a rock

	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "rockfruit"

	var/product = /obj/item/food/grown/rockfruit

/obj/item/grown/rockfruit/attack_self(mob/user, modifiers)
	user.show_message(span_notice("You begin peeling the rocky exterior..."))
	if(!(do_after(user, 2 SECONDS)))
		return
	user.show_message(span_notice("You peel off the rocky shell of the rockfruit, revealing the fruity goodness inside!"))
	balloon_alert(user, "peeled")

	// The fruit inside
	var/obj/item/food/grown/peel_prod
	peel_prod = new product(user.loc, new_seed = seed) // I stole this from seed code and am physically crying and shaking

	// The rocky shell
	new /obj/item/food/golem_food/rocks(user.loc)

	qdel(src)
	user.put_in_hands(peel_prod)

/obj/item/food/grown/rockfruit
	seed = /obj/item/seeds/rockfruit

	name = "Rockfruit core"
	desc = "The fruity insides of a rockfruit! Not too sugary, but still tasty. Golem folk use this to complement their rock foods. \
	Curiously enough, they don't like to eat this on its own"

	foodtypes = FRUIT

	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "rockfruit-peeled"

	tastes = list("mountains" = 1)

/obj/item/food/golem_food/rocks
	name = "Peeled rockfruit shell"
	desc = "The peeled shell of a rockfruit, or as you may call it, \"Literal pile of rocks\". \
	Probably not edible, but a golem will try to prove you otherwise"

	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "rockfruit-trash"

	foodtypes = STONE
	food_reagents = list(/datum/reagent/consumable/nutriment/mineral = 5)

	tastes = list("rocks and stones" = 1)

/datum/reagent/consumable/nutriment/mineral
	taste_description = "rocks and stones"
