/obj/item/reagent_containers/cup/soda_cans
	/// Trash type that gets created upon crushing the can
	/// This is a Bubber feature
	/// Done by edits in the TG proc definitions for the type
	var/trash_type = /obj/item/trash/can

/obj/item/reagent_containers/cup/soda_cans/bubber
	icon = 'modular_zubbers/icons/obj/drinks/soda.dmi'
	icon_state = null
	trash_type = /obj/item/trash/can/bubber

/obj/item/trash/can/bubber
	icon = 'modular_zubbers/icons/obj/janitor.dmi'
	icon_state = "tangorine_soda"

/obj/item/reagent_containers/cup/soda_cans/bubber/blood_tea
	name = "Hemoglobin Iced Tea"
	desc = "Kinda like that rich golfer, but it's actually blood!"
	icon_state = "blood_tea"
	list_reagents = list(/datum/reagent/consumable/icetea/blood_tea = 25, /datum/reagent/consumable/ethanol/bloodshot = 5)

/obj/item/reagent_containers/cup/soda_cans/bubber/tangorine_soda
	name = "Tang-O-Rine"
	desc = "A refreshing blend of tangerine juice with a bubbly fizz. The soda can features a vibrant orange and green Teshari mascot."
	icon_state = "tangorine_soda"
	drink_type = SUGAR | FRUIT
	list_reagents = list(/datum/reagent/consumable/orangejuice = 20, /datum/reagent/consumable/sodawater = 10)

/obj/item/reagent_containers/cup/soda_cans/bubber/lubricola
	name = "LubriCola"
	desc = "The perfect lubricant for your weary gears."
	icon_state = "lubricola"
	list_reagents = list(/datum/reagent/fuel/oil = 30)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/bubber/welding_fizz
	name = "Welding Fizz"
	desc = "More energy than in an IED! Now carbonated. WARNING: Contains toxic and flammable fuels."
	icon_state = "welding_fizz"
	list_reagents = list(/datum/reagent/fuel = 25, /datum/reagent/carbondioxide = 5)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/bubber/synthanolcan
	name = "Silly Cone's Synthanol"
	desc = "A recompiling can of synthanol."
	icon_state = "synthanolcan"
	list_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 30)
	custom_price = PAYCHECK_CREW

/obj/item/reagent_containers/cup/soda_cans/bubber/wine_voltaic
	name = "canned voltaic wine"
	desc = "A can of electrically infused wine, recharges ethereals and is safe for consumption."
	icon_state = "wine_voltaic"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine_voltaic = 30)

/obj/item/reagent_containers/cup/soda_cans/bubber/kortara
	name = "kortara"
	desc = "A can of kortara, alcohol brewed from korta seeds, which gives it a unique peppery spice flavor."
	icon_state = "kortara"
	list_reagents = list(/datum/reagent/consumable/ethanol/kortara = 30)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/bubber/lemonade
	name = "\improper Gyárhajó 1023: Lemonade"
	desc = "A can of lemonade, for those who are into that kind of thing, or just have no choice."
	icon_state = "lemonade"
	list_reagents = list(/datum/reagent/consumable/lemonade = 30)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/soda_cans/bubber/lemonade/examine_more(mob/user)
	. = ..()
	. += span_notice("Markings on the can indicate this one was made on <i>factory ship 1023</i> of the Grand Nomad Fleet.")
	return .

/obj/item/reagent_containers/cup/soda_cans/bubber/navy_rum
	name = "\improper Gyárhajó 1506: Navy Rum"
	desc = "A can of navy rum brewed up and imported from a detachment of the nomad fleet, or so the can says."
	icon_state = "navy_rum"
	list_reagents = list(/datum/reagent/consumable/ethanol/navy_rum = 30)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/bubber/navy_rum/examine_more(mob/user)
	. = ..()
	. += span_notice("Markings on the can indicate this one was made on <i>factory ship 1506</i> of the Grand Nomad Fleet.")
	return .

/obj/item/reagent_containers/cup/soda_cans/bubber/soda_water_moth
	name = "\improper Gyárhajó 1023: Soda Water"
	desc = "A can of soda water. Why not make a rum and soda? Now that you think of it, maybe not."
	icon_state = "soda_water"
	list_reagents = list(/datum/reagent/consumable/sodawater = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/bubber/soda_water_moth/examine_more(mob/user)
	. = ..()
	. += span_notice("Markings on the can indicate this one was made on <i>factory ship 1023</i> of the Grand Nomad Fleet.")
	return .

/obj/item/reagent_containers/cup/soda_cans/bubber/ginger_beer
	name = "\improper Gyárhajó 1023: Ginger Beer"
	desc = "A can of ginger beer, don't let the beer part mislead you, this is entirely non-alcoholic."
	icon_state = "gingie_beer"
	list_reagents = list(/datum/reagent/consumable/sol_dry = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/bubber/ginger_beer/examine_more(mob/user)
	. = ..()
	. += span_notice("Markings on the can indicate this one was made on <i>factory ship 1023</i> of the Grand Nomad Fleet.")
	return .
