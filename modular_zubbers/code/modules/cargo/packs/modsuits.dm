/datum/supply_pack/imports_modsuit
	access = NONE
	cost = PAYCHECK_CREW
	group = "MODSuits"
	goody = TRUE
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports_modsuit/plasma_core
	name = "MOD Plasma Core"
	desc = "One MODsuit core designed to be powered with the natural plasma of its Plasmaman wearer."
	contains = list(/obj/item/mod/core/plasma)

/datum/supply_pack/imports_modsuit/ethereal_core
	name = "MOD Ethereal Core"
	desc = "A MODsuit core designed to be powered with the natural electricity of its Ethereal wearer."
	contains = list(/obj/item/mod/core/ethereal)

/datum/supply_pack/imports_modsuit/mod_plate
	name = "MOD Plating"
	desc = "The standard plating type for modsuits."
	contains = list(/obj/item/mod/construction/plating)

/datum/supply_pack/imports_modsuit/mod_plate_medical
	name = "MOD Medical Plating"
	desc = "A lightweight medical modsuit plating."
	contains = list(/obj/item/mod/construction/plating/medical)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_modsuit/mod_plate_engineering
	name = "MOD Engineering Plating"
	desc = "A middleweight engineering modsuit plating."
	contains = list(/obj/item/mod/construction/plating/engineering)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_modsuit/mod_plate_atmospherics
	name = "MOD Atmospherics Plating"
	desc = "A middleweight engineering modsuit plating with high thermal resistance."
	contains = list(/obj/item/mod/construction/plating/atmospheric)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_modsuit/mod_plate_security
	name = "MOD Security Plating"
	desc = "A heavyweight security modsuit plating with a built-in armor booster."
	contains = list(/obj/item/mod/construction/plating/security)
	cost = PAYCHECK_COMMAND * 2
	access = ACCESS_SECURITY

/datum/supply_pack/imports_modsuit/mod_plate_clown
	name = "MOD CosmoHonk(TM) Plating"
	desc = "An extremely funny modsuit plating type."
	contains = list(/obj/item/mod/construction/plating/cosmohonk)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_modsuit/mod_module_welding
	name = "MOD Welding Shield"
	desc = "A MODsuit module that protects the wearer's eyes when the suit is activated."
	contains = list(/obj/item/mod/module/welding)

/datum/supply_pack/imports_modsuit/mod_module_longfall
	name = "MOD Longfall Boots"
	desc = "A MODsuit module that protects the wearer from long falls."
	contains = list(/obj/item/mod/module/longfall)

/datum/supply_pack/imports_modsuit/mod_module_rad_protection
	name = "MOD Radiation Shield"
	desc = "A MODSuit Module that protects the wearer from radiation."
	contains = list(/obj/item/mod/module/rad_protection)

/datum/supply_pack/imports_modsuit/mod_module_emp_shield
	name = "MOD EMP Shield"
	desc = "A MODSuit Module that makes the MODSuit EMP resistant."
	contains = list(/obj/item/mod/module/emp_shield)

/datum/supply_pack/imports_modsuit/mod_module_accretion
	name = "MOD Ash Accretion Module"
	desc = "A MODSuit Module that accretes ash."
	contains = list(/obj/item/mod/module/ash_accretion)
	cost = PAYCHECK_COMMAND * 3
	contraband = TRUE

/datum/supply_pack/imports_modsuit/mod_module_flashlight
	name = "MOD Flashlight Module"
	desc = "A MODSuit Module that creates a light when activated."
	contains = list(/obj/item/mod/module/)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_regulator
	name = "MOD Thermal Regulator"
	desc = "A MODSuit Module that protects from mild shifts in atmospheric temperature."
	contains = list(/obj/item/mod/module/thermal_regulator)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_mouthhole
	name = "MOD Eating Apparatus"
	desc = "A MODSuit Module that allows the wearer to eat while masked."
	contains = list(/obj/item/mod/module/mouthhole)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_signlang
	name = "MOD Glove Translator" ///figure out later
	desc = "A MODSuit Module that allows the user to use sign language while worn."
	contains = list(/obj/item/mod/module/signlang_radio)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_plasma_stabilizer
	name = "MOD Plasma Stabilizer"
	desc = "A MODSuit Module meant for Plasmamen." ///figure out later
	contains = list(/obj/item/mod/module/plasma_stabilizer)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_storage
	name = "MOD Storage Module"
	desc = "A MODSuit Module with a small storage compartment."
	contains = list(/obj/item/mod/module/storage)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_expanded_storage
	name = "MOD Expanded Storage Module"
	desc = "A MODSuit Module with a storage compartment."
	contains = list(/obj/item/mod/module/storage/large_capacity)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_modsuit/mod_module_retract_plates
	name = "MOD Plate Retraction Module"
	desc = "A MODSuit Module that retracts plates." //figure out later
	contains = list(/obj/item/mod/module/plate_compression)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_modsuit/mod_module_magnetic_deploy
	name = "MOD Magnetic Deploy Module"
	desc = "A MODSuit Module that allows magnetic deployment." /// figure out later
	contains = list(/obj/item/mod/module/springlock/contractor)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_modsuit/mod_module_tether
	name = "MOD Tether Module"
	desc = "A MODSuit Module that allows the user to move in low-gravity areas by tethering to surfaces."
	contains = list(/obj/item/mod/module/tether)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_magboot
	name = "MOD Magboots Module"
	desc = "A MODSuit Module that allows the user to stick to the ground using magnetism."
	contains = list(/obj/item/mod/module/magboot)

/datum/supply_pack/imports_modsuit/mod_module_jetpack
	name = "MOD Ion Jetpack Module "
	desc = "A MODSuit Module that allows flight in zero-gravity areas."
	contains = list(/obj/item/mod/module/jetpack)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports_modsuit/mod_module_pathfinder
	name = "MOD Pathfinder Module"
	desc = "A MODSuit Module that enables it to be summoned remotely by its user."
	contains = list(/obj/item/mod/module/pathfinder)

/datum/supply_pack/imports_modsuit/mod_module_disposals
	name = "MOD Disposals Connector Module"
	desc = "A MODSuit Module that connects to disposals." ///figure out later
	contains = list(/obj/item/mod/module/disposal_connector)

/datum/supply_pack/imports_modsuit/mod_module_sphere
	name = "MOD Sphere Transform Module"
	desc = "A MODSuit Module that allows the user to morph into a ball, allowing passage over certain hazardous terrain."
	contains = list(/obj/item/mod/module/sphere_transform)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports_modsuit/mod_module_atrocinator
	name = "MOD Atrocinator Module"
	desc = "A MODSuit Module with unclear effects." ///figure out later
	contains = list(/obj/item/mod/module/atrocinator)
	cost = PAYCHECK_COMMAND * 2
	contraband = TRUE

/datum/supply_pack/imports_modsuit/mod_module_waddle
	name = "MOD Waddle Module"
	desc = "A MODSuit Module that makes the user's walking look funny."
	contains = list(/obj/item/mod/module/waddle)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_bikehorn
	name = "MOD Bike Horn Module"
	desc = "A MODSuit Module that enables the user to honk whenever they want to."
	contains = list(/obj/item/mod/module/bikehorn)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports_modsuit/mod_module_microwavebeam
	name = "MOD Microwave Beam Module"
	desc = "A MODSuit Module that allows the preparation of donk pockets whenever desired." //figure out later
	contains = list(/obj/item/mod/module/microwave_beam)

/datum/supply_pack/imports_modsuit/mod_module_tanner
	name = "MOD Tanning Module"
	desc = "A MODSuit Module that makes you tan." //figure out later
	contains = list(/obj/item/mod/module/tanner)
	contraband = TRUE

/datum/supply_pack/imports_modsuit/mod_module_rave
	name = "MOD Rave Module"
	desc = "A MODSuit Module that enables hard partying." // figure out later
	contains = list(/obj/item/mod/module/visor/rave)
	contraband = TRUE

/datum/supply_pack/imports_modsuit/mod_module_hatstabilizer
	name = "MOD Hat Stabilizer Module"
	desc = "A MODSuit Module that allows the user to not lose their hat when the MODSuit is equipped."
	contains = list(/obj/item/mod/module/hat_stabilizer)
