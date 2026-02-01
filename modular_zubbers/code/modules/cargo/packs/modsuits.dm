/datum/supply_pack/goody/modsuit
	cost = PAYCHECK_CREW
	group = "MODSuits"

/datum/supply_pack/goody/modsuit/retract_plates
	contains = list(/obj/item/mod/module/plate_compression)
	cost = PAYCHECK_COMMAND
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/disposals
	contains = list(/obj/item/mod/module/disposal_connector)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/atrocinator
	contains = list(/obj/item/mod/module/atrocinator)
	cost = PAYCHECK_COMMAND * 2
	order_flags = ORDER_CONTRABAND
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/waddle
	contains = list(/obj/item/mod/module/waddle)
	cost = PAYCHECK_LOWER
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/bikehorn
	contains = list(/obj/item/mod/module/bikehorn)
	cost = PAYCHECK_LOWER
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/microwavebeam
	contains = list(/obj/item/mod/module/microwave_beam)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/tanner
	contains = list(/obj/item/mod/module/tanner)
	order_flags = ORDER_CONTRABAND
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/rave
	contains = list(/obj/item/mod/module/visor/rave)
	order_flags = ORDER_CONTRABAND
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/hatstabilizer
	contains = list(/obj/item/mod/module/hat_stabilizer)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/medical/
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/goody/modsuit/medical/injector
	contains = list(/obj/item/mod/module/injector)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/medical/organizer
	contains = list(/obj/item/mod/module/organizer)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/medical/patient_transport
	contains = list(/obj/item/mod/module/criminalcapture/patienttransport)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/medical/thread_ripper
	contains = list(/obj/item/mod/module/thread_ripper)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/medical/surgical_processor
	contains = list(/obj/item/mod/module/surgical_processor)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/medical/defibrillator
	contains = list(/obj/item/mod/module/defibrillator)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/donk/dart_collector_safe
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/recycler/donk/safe)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/donk/dart_collector_unsafe
	cost = PAYCHECK_COMMAND * 4
	contains = list(/obj/item/mod/module/recycler/donk)
	auto_name = TRUE

/datum/supply_pack/goody/modsuit/standard_mod_core
	name = "MOD standard core"
	desc = "The basic core module for all MODsuits. Provides essential functionality and compatibility."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/standard)

/datum/supply_pack/goody/modsuit/plasma_mod_core
	name = "MOD plasma core"
	desc = "Nanotrasen's attempt at capitalizing on their plasma research. These plasma cores are refueled through plasma fuel, allowing for easy continued use by their mining squads."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/plasma)

/datum/supply_pack/goody/modsuit/ethereal_mod_core
	name = "MOD ethereal core"
	desc = "A reverse engineered core of a Modular Outerwear Device. Using natural liquid electricity from Ethereals, preventing the need to use external sources to convert electric charge. As the suits are naturally charged by liquid electricity, this core makes it much more efficient, running all soft, hard, and wetware with several times less energy usage."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/ethereal)

/datum/supply_pack/goody/modsuit/cosmohonk
	name = "MOD Cosmohonk Plating"
	desc ="A suit by Honk Ltd. Protects against low humor environments. Most of the tech went to lower the power cost."
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/mod/construction/plating/cosmohonk)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/goody/modsuit/magnetic_deployable
	name = "MOD Magnetic Deployment Module"
	desc = "A much more modern version of a springlock system. This is a module that uses magnets to speed up the deployment and retraction time of your MODsuit. Unlike the outdated springlock module, this one does not have unforseen issues regarding its springs when exposed to moisture."
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/mod/module/springlock/contractor)

/datum/supply_pack/goody/modsuit/storage_large_capacity
	name = "MOD Expanded Storage Module"
	desc = "A larger capacity storage module for MODsuits, allowing for more efficient carrying of items."
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/storage/large_capacity)
