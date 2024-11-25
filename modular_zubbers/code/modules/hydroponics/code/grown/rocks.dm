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
	mutatelist = list(/obj/item/seeds/sandfruit)

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


//Rockfruits evolutions? OREFRUITS!//
//Sand - Base tier breaks into 4 trees ('energy', Precious, Metal, Miscmats)
/obj/item/seeds/sandfruit
	name = "sandfruit seed pack"
	desc = "These seeds grow to produce sandfruits."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-sandfruit"
	species = "ore"
	plantname = "Sandfruits"
	product = /obj/item/food/grown/shell/sand
	mutatelist = list(/obj/item/seeds/uraniberry,
					/obj/item/seeds/aubergine,
					/obj/item/seeds/ferrotuber,
					/obj/item/seeds/adamapple)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/silicon = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/sand
	seed = /obj/item/seeds/sandfruit
	name = "sandfruit"
	desc = "A mutated variant of rockfruits; rough, course and now available everywhere. Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/sandfruitcore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/silicon

/obj/item/grown/sandfruitcore
	seed = /obj/item/seeds/sandfruit
	name = "sandfruit core"
	desc = "A very fragile sandfruit core, literally composed of dozens of particles of sand... don't store in pockets."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "sandfruit"
	custom_materials = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*0.2)

//Uranium - First on 'energy' line

/obj/item/seeds/uraniberry
	name = "uraniberry seed pack"
	desc = "These seeds grow to produce 'berries' that god thinks probably shouldn't exist."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-uraniberry"
	species = "ore"
	plantname = "Uraniberry"
	product = /obj/item/food/grown/shell/uraniberry
	mutatelist = list(/obj/item/seeds/plasmaplum)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/uranium = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/uraniberry
	seed = /obj/item/seeds/uraniberry
	name = "uraniberry"
	desc = "A mutated variant of rockfruits; you might not want to hold it for long... also not actually a berry! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/uraniberrycore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/uranium

/obj/item/grown/uraniberrycore
	seed = /obj/item/seeds/uraniberry
	name = "uraniberry core"
	desc = "A very dense uraniberry core, don't store in pockets, unless you want extra limbs."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "uraniberry"
	custom_materials = list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT*0.2)

//Plasma - Second stage of 'energy' line.

/obj/item/seeds/plasmaplum
	name = "plasmaplum seed pack"
	desc = "These seeds grow to produce extremely volatile 'plums'."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-plasmaplum"
	species = "ore"
	plantname = "Plasmaplum"
	product = /obj/item/food/grown/shell/plasmaplum
	mutatelist = list(/obj/item/seeds/bluegemdrupe)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/toxin/plasma = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/plasmaplum
	seed = /obj/item/seeds/plasmaplum
	name = "plasmaplum"
	desc = "A mutated variant of rockfruits; Incredibly volatile... also not actually a plum! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/plasmaplumcore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/toxin/plasma

/obj/item/grown/plasmaplumcore
	seed = /obj/item/seeds/plasmaplum
	name = "plasmaplum core"
	desc = "A very dense plasmaplum core, store in a cold, fire and spark free place."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "plasmaplum"
	custom_materials = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT*0.2)

//Bluespace - ending of 'energy' line.

/obj/item/seeds/bluegemdrupe
	name = "bluegem drupe seed pack"
	desc = "These seeds grow to produce extremely volatile 'drupes'."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-bluegemdrupe"
	species = "ore"
	plantname = "Bluegem drupe"
	product = /obj/item/food/grown/shell/bluegemdrupe
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/bluespace = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/bluegemdrupe
	seed = /obj/item/seeds/bluegemdrupe
	name = "bluegem drupe"
	desc = "A mutated variant of rockfruits; Incredibly fragile... also not actually a drupe! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/bluegemdrupecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/bluespace

/obj/item/grown/bluegemdrupecore
	seed = /obj/item/seeds/bluegemdrupe
	name = "bluegem drupe core"
	desc = "A very dense bluegem drupe core, dropping may incur teleportation in rare cases."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "bluegemdrupe"
	custom_materials = list(/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*0.2)

//Silver - Aubergine (Get it? AU, silver?!) - First on 'precious' line

/obj/item/seeds/aubergine
	name = "au-bergine seed pack"
	desc = "These seeds grow to produce fruits, with cores of solid silver."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-aubergine"
	species = "ore"
	plantname = "aubergine"
	product = /obj/item/food/grown/shell/aubergine
	mutatelist = list(/obj/item/seeds/agbergine)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/silver = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/aubergine
	seed = /obj/item/seeds/aubergine
	name = "au-bergine"
	desc = "Au-bergine, get it AU? It's hilarious and valuable! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/auberginecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/silver

/obj/item/grown/auberginecore
	seed = /obj/item/seeds/aubergine
	name = "au-bergine core"
	desc = "A dense aubergine core of solid, sterling silver."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "aubergine"
	custom_materials = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT*0.2)

//Gold - Agbergine (Pretty sure you can work this one out) - Second stage of 'precious' line.

/obj/item/seeds/agbergine
	name = "ag-bergine seed pack"
	desc = "These seeds grow to golden cored fruits."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-agbergine"
	species = "ore"
	plantname = "agbergine"
	product = /obj/item/food/grown/shell/agbergine
	mutatelist = list(/obj/item/seeds/dimantis)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/gold = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/agbergine
	seed = /obj/item/seeds/agbergine
	name = "agbergine"
	desc = "An agbergine; AG? Get it?!... My talents are wasted here! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/agberginecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/gold

/obj/item/grown/agberginecore
	seed = /obj/item/seeds/agbergine
	name = "ag-bergine core"
	desc = "A very dense ag-bergine core, solid 24 karat goodness."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "agbergine"
	custom_materials = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT*0.2)

//Dimantis - ending of 'precious' line.

/obj/item/seeds/dimantis
	name = "dimantis seed pack"
	desc = "These seeds grow to produce extremely valuable dimatis fruits."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-dimantis"
	species = "ore"
	plantname = "Dimantis"
	product = /obj/item/food/grown/shell/dimantis
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/carbon = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/dimantis
	seed = /obj/item/seeds/dimantis
	name = "dimantis drupe"
	desc = "A fleshy fruid with a diamond core, Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/dimantiscore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/carbon

/obj/item/grown/dimantiscore
	seed = /obj/item/seeds/dimantis
	name = "dimantis core"
	desc = "A very dense dimantis core, the way to a woman's heart, it could probably get through her ribcage..."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "dimantis"
	custom_materials = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT*0.2)

//Iron - Ferrotubers - First on 'metal' line

/obj/item/seeds/ferrotuber
	name = "ferrotuber seed pack"
	desc = "These seeds grow to produce tubers, with cores of iron."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-ferrotuber"
	species = "ore"
	plantname = "ferrotuber"
	product = /obj/item/food/grown/shell/ferrotuber
	mutatelist = list(/obj/item/seeds/titanituber)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/iron = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/ferrotuber
	seed = /obj/item/seeds/ferrotuber
	name = "ferrotuber"
	desc = "Ferrotubers, fleshy shells with iron fillings! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/ferrotubercore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/iron

/obj/item/grown/ferrotubercore
	seed = /obj/item/seeds/ferrotuber
	name = "ferrotuber core"
	desc = "A dense ferrotuber core of solid iron, slightly magnetic."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "ferrotuber"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*0.2)

//Titanium - titanituber - Second stage of 'metal' line.

/obj/item/seeds/titanituber
	name = "titanituber seed pack"
	desc = "These seeds grow to titanium tubers."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-titanituber"
	species = "ore"
	plantname = "titanituber"
	product = /obj/item/food/grown/shell/titanituber
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/titanituber
	seed = /obj/item/seeds/titanituber
	name = "titanituber"
	desc = "soft fruits with incredibly sturdy cores, watch your teeth! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/titanitubercore
	foodtypes = FRUIT

/obj/item/grown/titanitubercore
	seed = /obj/item/seeds/titanituber
	name = "titanituber core"
	desc = "A very dense titanituber core, let's hope you didn't bite it!"
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "titanituber"
	custom_materials = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT*0.2)

//Adamantine - First on 'misc' line

/obj/item/seeds/adamapple
	name = "adam's apple seed pack"
	desc = "These seeds grow to produce fruits, with cores of adamantine."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-adamapple"
	species = "ore"
	plantname = "adamapple"
	product = /obj/item/food/grown/shell/adamapple
	mutatelist = list(/obj/item/seeds/runescooper)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/adamapple
	seed = /obj/item/seeds/adamapple
	name = "Adam's apple"
	desc = "Adam's apples, The garden Eden's bounty! Just peel it for a core."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/adamapplecore
	foodtypes = FRUIT

/obj/item/grown/adamapplecore
	seed = /obj/item/seeds/adamapple
	name = "adam's apple core"
	desc = "A dense adam's apple core of solid adamantine."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "adamapple"
	custom_materials = list(/datum/material/adamantine=SHEET_MATERIAL_AMOUNT*0.2)

//Runite - Second stage of 'misc' line.

/obj/item/seeds/runescooper
	name = "runescooper seed pack"
	desc = "These seeds grow to rare, wildy fruits."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-runescooper"
	species = "ore"
	plantname = "runescooper"
	product = /obj/item/food/grown/shell/runescooper
	mutatelist = list(/obj/item/seeds/bananiumberry)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/runescooper
	seed = /obj/item/seeds/runescooper
	name = "runescooper"
	desc = "A fruit, usually grown in wild places where men would kill each other for gain."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/runescoopercore
	foodtypes = FRUIT

/obj/item/grown/runescoopercore
	seed = /obj/item/seeds/runescooper
	name = "ag-bergine core"
	desc = "A very dense runite core, a few more of these and you might be able to make a scimitar to defeat your foes..."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "runescooper"
	custom_materials = list(/datum/material/runite=SHEET_MATERIAL_AMOUNT*0.2)

//bananiumberry - ending of 'misc' line.

/obj/item/seeds/bananiumberry
	name = "bananium berry seed pack"
	desc = "These seeds grow to produce unholy abominations."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/seeds.dmi'
	icon_state = "seed-bananiumberry"
	species = "ore"
	plantname = "bananiumberry"
	product = /obj/item/food/grown/shell/bananiumberry
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/consumable/nutriment/soup/clown_tears = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/code/modules/hydroponics/icons/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/shell/bananiumberry
	seed = /obj/item/seeds/bananiumberry
	name = "bananiumberry"
	desc = "holy honkmother... This fruit got a core of bananium, Just peel it!"
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/grown/bananiumberrycore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/consumable/nutriment/soup/clown_tears

/obj/item/grown/bananiumberrycore
	seed = /obj/item/seeds/bananiumberry
	name = "bananiumberry core"
	desc = "A very dense bananium core, the way to a clown's heart, it could probably get through their ribcage..."
	icon = 'modular_zubbers/code/modules/hydroponics/icons/harvest.dmi'
	icon_state = "bananiumberry"
	custom_materials = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT*0.2)
