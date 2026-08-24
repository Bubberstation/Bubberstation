/datum/supply_pack/misc/smithing_skillchips
	name = "Smithing Skillchips Pack"
	desc = "Learn the art of metalworking and build your own weapons! Contains two smithing skillchips."
	cost = CARGO_CRATE_VALUE * 3
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/storage/box/skillchips/supply,)

/datum/supply_pack/misc/singular_smithing_chip
	name = "Single Smithing Skillchip"
	desc = "Learn the art of metalworking and build your own weapons! Contains one smithing skillchip."
	cost = CARGO_CRATE_VALUE * 2
	order_flags = ORDER_GOODY
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/skillchip/job/blacksmith,)

/datum/supply_pack/misc/blacksmith_starter_pack
	name = "Blacksmithing Starter Pack"
	desc = "Almost everything one person needs to get to a basic blacksmithing setup. Contains a forge, anvil, cooling basin, crafting bench, two jerrycans of smithing oil, a wall-mounted A/C unit, and a wrench to secure everything to the floor."
	cost = CARGO_CRATE_VALUE * 4
	access = list(ACCESS_WEAPONS)
	crate_type = /obj/structure/closet/crate/wooden/blacksmith

/datum/supply_pack/misc/smithing_oil
	name = "Smithing Oil Jerrycans"
	desc = "Two jerrycans of smithing oil, perfect for quenching freshly-forged metal items."
	cost = CARGO_CRATE_VALUE * 2
	access = list(ACCESS_WEAPONS)
	contains = list(/obj/item/reagent_containers/cup/jerrycan/smithing_oil,/obj/item/reagent_containers/cup/jerrycan/smithing_oil,)
