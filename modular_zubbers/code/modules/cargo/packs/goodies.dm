/datum/supply_pack/goody/sol_pistol_single
	name = "Sol 'Wespe' Pistol Single Pack"
	desc = "The standard issue service pistol of the Terran Government's various military branches. Comes with an attached light and a spare magazine."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sol = 1,
	/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 1,
	)
	cost = PAYCHECK_COMMAND * 10 //Half the cost of a Detective Revolver
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/sol_revolver_single
	name = "Sol 'Eland' Revolver Single Pack"
	desc = "A stubby revolver chiefly found in the hands of Private Security forces due to its cheap price and decent stopping power. Comes with an ammo box."
	contains = list(/obj/item/gun/ballistic/revolver/sol = 1,
	/obj/item/ammo_box/c35sol = 1,
	)
	cost = PAYCHECK_COMMAND * 10 //Half the cost of a Detective Revolver
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/disablersmg_single
	name = "Disabler SMG Single-Pack"
	desc = "Contains one disabler SMG, an automatic variant of the original workhorse."
	cost = PAYCHECK_COMMAND * 3
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/disabler/smg)

/datum/supply_pack/goody/lasercarbine_single
	name = "Laser Carbine Single-Pack"
	desc = "Contains one laser carbine, an automatic variant of the laser gun. For when you need a fast-firing lethal-only solution."
	cost = PAYCHECK_COMMAND * 12
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/carbine)

/datum/supply_pack/goody/miniegun_single
	name = "Mini E-Gun Single-Pack"
	desc = "Contains one mini e-gun, for when your Bridge Officer loses theirs to the clown."
	cost = PAYCHECK_COMMAND * 5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun/mini)

/datum/supply_pack/goody/shotgun_revolver
	name = "Bóbr 12 GA Revolver Single-Pack"
	desc = "Contains 1 civilian-modified Bóbr revolver, chambered in 12 gauge. For when you really want the power of a shotgun in the palm of your hand. Comes with a box of beanbag shells."
	contains = list(/obj/item/gun/ballistic/revolver/shotgun_revolver/civvie = 1,
	/obj/item/ammo_box/advanced/s12gauge/bean = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 20

/datum/supply_pack/goody/plasma_projector
	name = "Słońce Plasma Projector Single-Pack"
	desc = "Contains one Słońce Plasma Projector. Spews an inaccurate stream of searing plasma out the magnetic barrel so long as it has power."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_thrower = 1,
	/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/goody/sakhno_derringer_single
	name = "Sakhno 'Yinbi' Derringer Single Pack"
	desc = "A compact self-defense pistol, chambered in .310 strilka. Comes with a box of modern reproduction cartridges."
	contains = list(/obj/item/gun/ballistic/derringer = 1,
	/obj/item/ammo_box/c310_cargo_box = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 4.5 //It's a close-range cannon, very poor ranged performance. Slightly pricer than imported Sol pistols

/datum/supply_pack/goody/mars_single
	special = FALSE

/datum/supply_pack/goody/dumdum38
	special = FALSE

/datum/supply_pack/goody/match38
	special = FALSE

/datum/supply_pack/goody/rubber
	special = FALSE

/datum/supply_pack/goody/ballistic_single
	special = FALSE

/datum/supply_pack/goody/disabler_single
	special = FALSE

/datum/supply_pack/goody/energy_single
	special = FALSE

/datum/supply_pack/goody/laser_single
	special = FALSE

/datum/supply_pack/goody/hell_single
	special = FALSE

/datum/supply_pack/goody/thermal_single
	special = FALSE

/datum/supply_pack/goody/medkit_surgery
	name = "High Capacity Surgical Medkit"
	desc = "A high capacity aid kit, full of medical supplies and basic surgical equipment."
	cost = PAYCHECK_CREW * 15
	contains = list(/obj/item/storage/medkit/surgery)

//For @unionheart
/datum/supply_pack/goody/security_maid
	name = "CnC Maid Operator Kit"
	desc = "Contains a set of armoured janitorial kit for combat scenario."
	cost = PAYCHECK_COMMAND * 4
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/clothing/under/rank/security/maid, /obj/item/clothing/suit/armor/vest/maid, /obj/item/clothing/head/security_maid, /obj/item/pushbroom)

/datum/supply_pack/goody/prescription_lenses
	name = "Spare Prescription Lenses"
	desc = "A small toolbox with one spare set of prescripted lenses. Warning: fragile."
	cost = PAYCHECK_COMMAND * 2 // glasses are expensive! woah-wee momma!
	contains = list(/obj/item/prescription_lenses)

/datum/supply_pack/goody/space_pet_snack
	name = "Spaceproof Pet Snack"
	desc = "Contains a treat for your loving companion that'll make them spaceworthy."
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/pet_food/pet_space_treat)

/datum/supply_pack/goody/rope_implant
	name = "Climbing Hook Implant"
	desc = "A specialized climbing hook implant for the vertically challenged."
	cost = PAYCHECK_CREW * 12
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/rope)

/datum/supply_pack/goody/pepperball_gun
	name = "Pepperball Gun Single-Pack"
	desc = "Contains one pepperball gun, a non-lethal weapon that fires pepper-filled projectiles."
	cost = PAYCHECK_CREW * 9
	access = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball)

/datum/supply_pack/goody/taser
	name = "Taser Single-Pack"
	desc = "Contains one hybrid taser, a non-lethal weapon that fires electric projectiles and features a secondary disabler."
	cost = PAYCHECK_CREW * 12
	access = ACCESS_SECURITY
	contains = list(/obj/item/gun/energy/e_gun/advtaser)

/datum/supply_pack/goody/standard_mod_core
	name = "MOD standard core"
	desc = "The basic core module for all MODsuits. Provides essential functionality and compatibility."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/standard)

/datum/supply_pack/goody/plasma_mod_core
	name = "MOD plasma core"
	desc = "Nanotrasen's attempt at capitalizing on their plasma research. These plasma cores are refueled through plasma fuel, allowing for easy continued use by their mining squads."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/plasma)

/datum/supply_pack/goody/ethereal_mod_core
	name = "MOD ethereal core"
	desc = "A reverse engineered core of a Modular Outerwear Device. Using natural liquid electricity from Ethereals, preventing the need to use external sources to convert electric charge. As the suits are naturally charged by liquid electricity, this core makes it much more efficient, running all soft, hard, and wetware with several times less energy usage."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/ethereal)

/datum/supply_pack/goody/cosmohonk
	name = "MOD Cosmohonk Plating"
	desc ="A suit by Honk Ltd. Protects against low humor environments. Most of the tech went to lower the power cost."
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/mod/construction/plating/cosmohonk)
	contraband = TRUE

/datum/supply_pack/goody/magnetic_deployable
	name = "MOD Magnetic Deployment Module"
	desc = "A much more modern version of a springlock system. This is a module that uses magnets to speed up the deployment and retraction time of your MODsuit. Unlike the outdated springlock module, this one does not have unforseen issues regarding its springs when exposed to moisture."
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/mod/module/springlock/contractor)

/datum/supply_pack/goody/storage_large_capacity
	name = "MOD Expanded Storage Module"
	desc = "A larger capacity storage module for MODsuits, allowing for more efficient carrying of items."
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/storage/large_capacity)

