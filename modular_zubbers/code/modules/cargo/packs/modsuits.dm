/datum/supply_pack/modsuit
	access = NONE
	cost = PAYCHECK_CREW
	group = "MODSuits"
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/modsuit/mod_module/retract_plates
	contains = list(/obj/item/mod/module/plate_compression)
	cost = PAYCHECK_COMMAND
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/disposals
	contains = list(/obj/item/mod/module/disposal_connector)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/atrocinator
	contains = list(/obj/item/mod/module/atrocinator)
	cost = PAYCHECK_COMMAND * 2
	order_flags = ORDER_CONTRABAND
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/waddle
	contains = list(/obj/item/mod/module/waddle)
	cost = PAYCHECK_LOWER
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/bikehorn
	contains = list(/obj/item/mod/module/bikehorn)
	cost = PAYCHECK_LOWER
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/microwavebeam
	contains = list(/obj/item/mod/module/microwave_beam)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/tanner
	contains = list(/obj/item/mod/module/tanner)
	order_flags = ORDER_CONTRABAND
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/rave
	contains = list(/obj/item/mod/module/visor/rave)
	order_flags = ORDER_CONTRABAND
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/hatstabilizer
	contains = list(/obj/item/mod/module/hat_stabilizer)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/medical/
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/modsuit/mod_module/medical/injector
	contains = list(/obj/item/mod/module/injector)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/medical/organizer
	contains = list(/obj/item/mod/module/organizer)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/medical/patient_transport
	contains = list(/obj/item/mod/module/criminalcapture/patienttransport)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/medical/thread_ripper
	contains = list(/obj/item/mod/module/thread_ripper)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/medical/surgical_processor
	contains = list(/obj/item/mod/module/surgical_processor)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/medical/defibrillator
	contains = list(/obj/item/mod/module/defibrillator)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/donk/dart_collector_safe
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/recycler/donk/safe)
	auto_name = TRUE

/datum/supply_pack/modsuit/mod_module/donk/dart_collector_unsafe
	cost = PAYCHECK_COMMAND * 4
	contains = list(/obj/item/mod/module/recycler/donk)
	auto_name = TRUE
