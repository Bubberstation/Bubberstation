/datum/supply_pack/engineering/omni_drill
	contains = list(/obj/item/screwdriver/omni_drill)

/datum/supply_pack/engineering/arc_welder
	contains = list(/obj/item/weldingtool/electric/arc_welder)

/datum/supply_pack/engineering/compact_drill
	contains = list(/obj/item/pickaxe/drill/compact)

/datum/supply_pack/engineering/rapid_construction_fabricator
	contains = list(/obj/item/flatpacked_machine)
	order_flags = ORDER_GOODY
	cost = CARGO_CRATE_VALUE * 6

/datum/supply_pack/engineering/foodricator
	contains = list(/obj/item/flatpacked_machine/organics_ration_printer)
	cost = CARGO_CRATE_VALUE * 2

/datum/supply_pack/engineering/charger
	contains = list(/obj/item/wallframe/cell_charger_multi)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/engineering/water_synth
	contains = list(/obj/item/flatpacked_machine/water_synth)

/datum/supply_pack/engineering/hydro_synth
	contains = list(/obj/item/flatpacked_machine/hydro_synth)

/datum/supply_pack/engineering/sustenance_dispenser
	contains = list(/obj/item/flatpacked_machine/sustenance_machine)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/engineering/arc_furnace
	contains = list(/obj/item/flatpacked_machine/arc_furnace)

/datum/supply_pack/engineering/thermomachine
	contains = list(/obj/item/flatpacked_machine/thermomachine)

/datum/supply_pack/engineering/co2_cracker
	contains = list(/obj/item/flatpacked_machine/co2_cracker)

/datum/supply_pack/engineering/recycler
	contains = list(/obj/item/flatpacked_machine/recycler)

/datum/supply_pack/engineering/solar
	contains = list(/obj/item/flatpacked_machine/solar)

/datum/supply_pack/engineering/solar_tracker
	contains = list(/obj/item/flatpacked_machine/solar_tracker)

/datum/supply_pack/engineering/station_battery
	contains = list(/obj/item/flatpacked_machine/station_battery)

/datum/supply_pack/engineering/big_station_battery
	contains = list(/obj/item/flatpacked_machine/large_station_battery)

/datum/supply_pack/engineering/fuel_generator
	contains = list(/obj/item/flatpacked_machine/fuel_generator)
	access_view = ACCESS_ENGINEERING

/datum/supply_pack/goody/engineering
	group = "Engineering"

/datum/supply_pack/goody/engineering/weldhat
	contains = list(/obj/item/clothing/head/utility/hardhat/welding/orange)
	cost = PAYCHECK_CREW * 1.5

/datum/supply_pack/goody/engineering/gasmask
	contains = list(/obj/item/clothing/mask/gas/alt)
	cost = PAYCHECK_LOWER

/datum/supply_pack/goody/engineering/hazard_vest
	contains = list(/obj/item/clothing/suit/hazardvest)
	cost = PAYCHECK_CREW
