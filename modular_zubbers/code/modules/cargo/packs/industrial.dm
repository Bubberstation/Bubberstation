/datum/supply_pack/imports/engineering
	access = NONE
	cost = PAYCHECK_COMMAND
	group = "Industrial" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/engineering/omni_drill
	name = "Omni-Drill"
	contains = list(/obj/item/screwdriver/omni_drill)

/datum/supply_pack/imports/engineering/arc_welder
	name = "Arc Welder"
	contains = list(/obj/item/weldingtool/electric/arc_welder)

/datum/supply_pack/imports/engineering/compact_drill
	name = "Compact Drill"
	contains = list(/obj/item/pickaxe/drill/compact)

/datum/supply_pack/imports/engineering/rapid_construction_fabricator
	name = "Rapid Construction Fabricator"
	contains = list(/obj/item/flatpacked_machine)
	order_flags = ORDER_GOODY
	cost = CARGO_CRATE_VALUE * 6

/datum/supply_pack/imports/engineering/foodricator
	name = "Ration Printer"
	contains = list(/obj/item/flatpacked_machine/organics_ration_printer)
	cost = CARGO_CRATE_VALUE * 2

/datum/supply_pack/imports/engineering/charger
	name = "Multi-Cell Charger"
	contains = list(/obj/item/wallframe/cell_charger_multi)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/engineering/water_synth
	name = "Water Synthesizer" ///check this later
	contains = list(/obj/item/flatpacked_machine/water_synth)

/datum/supply_pack/imports/engineering/hydro_synth
	name = "Hydroponics Synthesizer" ///check this later
	contains = list(/obj/item/flatpacked_machine/hydro_synth)

/datum/supply_pack/imports/engineering/sustenance_dispenser
	name = "Sustenance Dispenser"///check this later
	contains = list(/obj/item/flatpacked_machine/sustenance_machine)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/engineering/arc_furnace
	name = "Arc Furnace"
	contains = list(/obj/item/flatpacked_machine/arc_furnace)

/datum/supply_pack/imports/engineering/thermomachine
	name = "Thermomachine"
	contains = list(/obj/item/flatpacked_machine/thermomachine)

/datum/supply_pack/imports/engineering/co2_cracker
	name = "CO2 Cracker" //check this later
	contains = list(/obj/item/flatpacked_machine/co2_cracker)

/datum/supply_pack/imports/engineering/recycler
	name = "Recycler"
	contains = list(/obj/item/flatpacked_machine/recycler)

/datum/supply_pack/imports/engineering/solar
	name = "Solar Panels"//check this later
	contains = list(/obj/item/flatpacked_machine/solar)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/engineering/solar_tracker
	name = "Solar Tracker"///check this later
	contains = list(/obj/item/flatpacked_machine/solar_tracker)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/engineering/station_battery
	name = "Station Battery" //check this later
	contains = list(/obj/item/flatpacked_machine/station_battery)

/datum/supply_pack/imports/engineering/big_station_battery
	name = "Large Station Battery" //check this later
	contains = list(/obj/item/flatpacked_machine/large_station_battery)

/datum/supply_pack/imports/engineering/fuel_generator
	name = "Fuel Generator" //check this later
	contains = list(/obj/item/flatpacked_machine/fuel_generator)
	access_view = ACCESS_ENGINEERING

/datum/supply_pack/imports/engineering/equipment/wearable/weldhat
	name = "Weldning Hard Hat"
	contains = list(/obj/item/clothing/head/utility/hardhat/welding/orange)
	cost = PAYCHECK_CREW * 1.5

/datum/supply_pack/imports/engineering/equipment/wearable/gasmask
	name = "Gas Mask"
	contains = list(/obj/item/clothing/mask/gas/alt)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/engineering/equipment/wearable/hazard_vest
	name = "Hi-Vis Vest"
	contains = list(/obj/item/clothing/suit/hazardvest)
	cost = PAYCHECK_CREW
