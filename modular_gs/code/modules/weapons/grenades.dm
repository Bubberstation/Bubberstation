//GS13 - fattening grenade presets

/obj/item/grenade/chem_grenade/lipoifier_strong
	name = "lipoifier grenade"
	desc = "For when you want everyone in the room to gain a couple hundred pounds."
	stage = 3

/obj/item/grenade/chem_grenade/lipoifier_strong/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/bluespace/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/bluespace/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/consumable/lipoifier, 250)
	B1.reagents.add_reagent(/datum/reagent/potassium, 40)
	B2.reagents.add_reagent(/datum/reagent/phosphorus, 40)
	B2.reagents.add_reagent(/datum/reagent/consumable/sugar, 40)

	beakers += B1
	beakers += B2


/obj/item/grenade/chem_grenade/lipoifier_weak
	name = "lipoifier grenade"
	desc = "For when you want everyone in the room to gain a couple dozen pounds."
	stage = 3

/obj/item/grenade/chem_grenade/lipoifier_weak/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/large/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/large/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/consumable/lipoifier, 40)
	B1.reagents.add_reagent(/datum/reagent/potassium, 20)
	B2.reagents.add_reagent(/datum/reagent/phosphorus, 20)
	B2.reagents.add_reagent(/datum/reagent/consumable/sugar, 20)

	beakers += B1
	beakers += B2
