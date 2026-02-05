/obj/item/grenade/chem_grenade/wehnade
	name = "wehnade"
	desc = "A weird, old looking grenade casing. If you shake it you can hear liquid inside. It has no markings on it beside a hand written sticker that says 'Weh'!"
	stage = GRENADE_READY

/obj/item/grenade/chem_grenade/wehnade/Initialize(mapload)
	. = ..()
	var/obj/item/reagent_containers/cup/beaker/beaker_one = new(src)
	var/obj/item/reagent_containers/cup/beaker/beaker_two = new(src)

	beaker_one.reagents.add_reagent(/datum/reagent/fluorosurfactant, 30)
	beaker_two.reagents.add_reagent(/datum/reagent/water, 30)
	beaker_one.reagents.add_reagent(/datum/reagent/juice_that_makes_you_weh, 30)
	beaker_two.reagents.add_reagent(/datum/reagent/juice_that_makes_you_weh, 30)

	beakers += beaker_one
	beakers += beaker_two
