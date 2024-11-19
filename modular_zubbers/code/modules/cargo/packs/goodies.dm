/datum/supply_pack/goody/sol_pistol_single
	name = "Sol 'Wespe' Pistol Single Pack"
	desc = "The standard issue service pistol of the Solar Federation's various military branches. Comes with an attached light and a spare magazine."
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
