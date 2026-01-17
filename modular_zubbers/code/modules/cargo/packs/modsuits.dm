/datum/supply_pack/modsuit
	access = NONE
	cost = PAYCHECK_CREW
	group = "MODSuits"
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/modsuit/mod_module/retract_plates
	name = "MOD Plate Retraction Module"
	desc = "A MODSuit Module that retracts plates." //figure out later
	contains = list(/obj/item/mod/module/plate_compression)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/modsuit/mod_module/disposals
	name = "MOD Disposals Connector Module"
	desc = "A MODSuit Module that connects to disposals." ///figure out later
	contains = list(/obj/item/mod/module/disposal_connector)

/datum/supply_pack/modsuit/mod_module/atrocinator
	name = "MOD Atrocinator Module"
	desc = "A MODSuit Module with unclear effects." ///figure out later
	contains = list(/obj/item/mod/module/atrocinator)
	cost = PAYCHECK_COMMAND * 2
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/modsuit/mod_module/waddle
	name = "MOD Waddle Module"
	desc = "A MODSuit Module that makes the user's walking look funny."
	contains = list(/obj/item/mod/module/waddle)
	cost = PAYCHECK_LOWER

/datum/supply_pack/modsuit/mod_module/bikehorn
	name = "MOD Bike Horn Module"
	desc = "A MODSuit Module that enables the user to honk whenever they want to."
	contains = list(/obj/item/mod/module/bikehorn)
	cost = PAYCHECK_LOWER

/datum/supply_pack/modsuit/mod_module/microwavebeam
	name = "MOD Microwave Beam Module"
	desc = "A MODSuit Module that allows the preparation of donk pockets whenever desired." //figure out later
	contains = list(/obj/item/mod/module/microwave_beam)

/datum/supply_pack/modsuit/mod_module/tanner
	name = "MOD Tanning Module"
	desc = "A MODSuit Module that makes you tan." //figure out later
	contains = list(/obj/item/mod/module/tanner)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/modsuit/mod_module/rave
	name = "MOD Rave Module"
	desc = "A MODSuit Module that enables hard partying." // figure out later
	contains = list(/obj/item/mod/module/visor/rave)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/modsuit/mod_module/hatstabilizer
	name = "MOD Hat Stabilizer Module"
	desc = "A MODSuit Module that allows the user to not lose their hat when the MODSuit is equipped."
	contains = list(/obj/item/mod/module/hat_stabilizer)


/datum/supply_pack/modsuit/mod_module/medical/
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/modsuit/mod_module/medical/injector
	name = "MOD Injector Module"
	contains = list(/obj/item/mod/module/injector)

/datum/supply_pack/modsuit/mod_module/medical/organizer
	name = "MOD Organizer Module"
	contains = list(/obj/item/mod/module/organizer)

/datum/supply_pack/modsuit/mod_module/medical/patient_transport
	name = "MOD Patient Transport Module"
	contains = list(/obj/item/mod/module/criminalcapture/patienttransport)

/datum/supply_pack/modsuit/mod_module/medical/thread_ripper
	name = "MOD Thread Ripper Module"
	contains = list(/obj/item/mod/module/thread_ripper)

/datum/supply_pack/modsuit/mod_module/medical/surgical_processor
	name = "MOD Surgical Processor Module"
	contains = list(/obj/item/mod/module/surgical_processor)

/datum/supply_pack/modsuit/mod_module/medical/defibrillator
	name = "MOD Defibrillator Module"
	contains = list(/obj/item/mod/module/defibrillator)

/datum/supply_pack/modsuit/mod_module/donk/dart_collector_safe
	name = "MOD Dart Collector"
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/recycler/donk/safe)

/datum/supply_pack/modsuit/mod_module/donk/dart_collector_unsafe
	name = "MOD Dart Collector (Unsafe)"
	cost = PAYCHECK_COMMAND * 4
	contains = list(/obj/item/mod/module/recycler/donk)
