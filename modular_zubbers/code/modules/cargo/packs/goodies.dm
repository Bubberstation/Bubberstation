/datum/supply_pack/goody
	auto_name = TRUE

/datum/supply_pack/goody/smg_single
	name = "Disabler SMG Single-Pack"
	cost = PAYCHECK_COMMAND * 3
	auto_name = FALSE

/datum/supply_pack/goody/lasercarbine_single
	name = "Laser Carbine Single-Pack"
	desc = "Contains one laser carbine, an automatic variant of the laser gun. For when you need a fast-firing lethal-only solution."
	cost = PAYCHECK_COMMAND * 7
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/carbine)
	auto_name = FALSE


/datum/supply_pack/goody/miniegun_single
	name = "Mini E-Gun Single-Pack"
	desc = "Contains one mini e-gun, for when your Bridge Officer loses theirs to the clown."
	cost = PAYCHECK_COMMAND * 5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun/mini)
	auto_name = FALSE

/datum/supply_pack/goody/wt550_single
	name = "WT-551 Autorifle Single-Pack"
	desc = "An NT-security grade autorifle, it comes with excellent heating and poses no health-related risks for the user. Comes as a single-pack with one WT-551 locked and loaded."
	cost = PAYCHECK_COMMAND * 8 //Nvm these are stronger than lasers in most scenarios so let's get them a bit of an edge. Plus gun price variety looks better
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/automatic/wt550/security)
	auto_name = FALSE

/datum/supply_pack/goody/wt550_ammo
	name = "WT-550/WT-551 Autorifle Magazine Single-Pack"
	desc = "A single-pack magazine with lethal regular rounds for the WT-551."
	cost = PAYCHECK_CREW * 5 //Scale it like all guns
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 1)
	auto_name = FALSE

/datum/supply_pack/goody/nt_shotgun
	name = "Nanotrasen Woodstock Shotgun"
	desc = "A classic shotgun used by hunters, police and frontiersmen alike, now at an affordable price."
	cost = PAYCHECK_COMMAND * 12 //Worse renoster, let's make it a tad cheaper
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/shotgun/riot, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/hunter)
	auto_name = FALSE

/datum/supply_pack/goody/renoster_shotgun
	name = "Renoster Shotgun Single-Pack"
	desc = "A common modern shotgun used by Terran Government Police."
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/rubber)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 14 //I'd say it's at odds with the combat shotgun, sustain vs burst and such, but since ss13 favours burst I'll make it a tad cheaper.
	auto_name = FALSE

/datum/supply_pack/goody/double_barrel
	cost = PAYCHECK_COMMAND * 10 //1400 is too much considering the combat shotgun is 1500 for 1
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/plasma_marksman
	name = "Gwiazda Plasma Sharpshooters Single-pack"
	desc = "Contains a Gwiazda Plasma Sharpshooter and one plasma battery free of additional charge."
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
	/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 4
	auto_name = FALSE

/datum/supply_pack/goody/plasma_marksman_ammo
	name = "Plasma Battery Single-pack"
	desc = "Contains a single plasma battery."
	contains = list(/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 1
	auto_name = FALSE

/datum/supply_pack/goody/medkit_surgery
	name = "High Capacity Surgical Medkit"
	desc = "A high capacity aid kit, full of medical supplies and basic surgical equipment."
	cost = PAYCHECK_CREW * 15
	contains = list(/obj/item/storage/medkit/surgery)
	auto_name = FALSE

//For @unionheart
/datum/supply_pack/goody/security_maid
	name = "CnC Maid Operator Kit"
	desc = "Contains a set of armoured janitorial kit for combat scenario."
	cost = PAYCHECK_COMMAND * 4
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/clothing/under/rank/security/maid, /obj/item/clothing/suit/armor/vest/maid, /obj/item/clothing/head/security_maid, /obj/item/pushbroom)
	auto_name = FALSE

/datum/supply_pack/goody/prescription_lenses
	name = "Spare Prescription Lenses"
	desc = "A small toolbox with one spare set of prescripted lenses. Warning: fragile."
	cost = PAYCHECK_COMMAND * 2 // glasses are expensive! woah-wee momma!
	contains = list(/obj/item/prescription_lenses)
	auto_name = FALSE

/datum/supply_pack/goody/space_pet_snack
	name = "Spaceproof Pet Snack"
	desc = "Contains a treat for your loving companion that'll make them spaceworthy."
	cost = PAYCHECK_CREW * 5
	contains = list(/obj/item/pet_food/pet_space_treat)
	auto_name = FALSE

/datum/supply_pack/goody/rope_implant
	name = "Climbing Hook Implant"
	desc = "A specialized climbing hook implant for the vertically challenged."
	cost = PAYCHECK_CREW * 12
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/rope)
	auto_name = FALSE

/datum/supply_pack/goody/food/ready/standard
	contains = list(/obj/item/food/ready_donk)

/datum/supply_pack/goody/food/ready/donkhiladas
	contains = list(/obj/item/food/ready_donk/donkhiladas)

/datum/supply_pack/goody/food/ready/mac_n_cheese
	contains = list(/obj/item/food/ready_donk/mac_n_cheese)

/datum/supply_pack/goody/food/pockets/standard
	contains = list(/obj/item/storage/box/donkpockets)

/datum/supply_pack/goody/food/pockets/berry
	contains = list(/obj/item/storage/box/donkpockets/donkpocketberry)

/datum/supply_pack/goody/food/pockets/banana
	contains = list(/obj/item/storage/box/donkpockets/donkpockethonk)

/datum/supply_pack/goody/food/pockets/pizza
	contains = list(/obj/item/storage/box/donkpockets/donkpocketpizza)

/datum/supply_pack/goody/food/pockets/spicy
	contains = list(/obj/item/storage/box/donkpockets/donkpocketspicy)

/datum/supply_pack/goody/food/pockets/teriyaki
	contains = list(/obj/item/storage/box/donkpockets/donkpocketteriyaki)

/datum/supply_pack/goody/merch/donk_carpet
	contains = list(/obj/item/stack/tile/carpet/donk/thirty)

/datum/supply_pack/goody/merch/tacticool_turtleneck
	contains = list(/obj/item/clothing/under/syndicate/tacticool)

/datum/supply_pack/goody/merch/tacticool_turtleneck_skirt
	contains = list(/obj/item/clothing/under/syndicate/tacticool/skirt)

/datum/supply_pack/goody/merch/fake_centcom_turtleneck
	contains = list(/obj/item/clothing/under/rank/centcom/officer/replica)

/datum/supply_pack/goody/merch/fake_centcom_turtleneck_skirt
	contains = list(/obj/item/clothing/under/rank/centcom/officer_skirt/replica)

/datum/supply_pack/goody/merch/snack_rig
	contains = list(/obj/item/storage/belt/military/snack)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/goody/merch/fake_syndie_suit
	contains = list(/obj/item/storage/box/fakesyndiesuit)

/datum/supply_pack/goody/merch/syndicate_balloon
	contains = list(/obj/item/toy/balloon/arrest)

/datum/supply_pack/goody/foamforce
	cost = PAYCHECK_COMMAND

/datum/supply_pack/goody/foamforce/pistol
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)

/datum/supply_pack/goody/foamforce/shotgun
	contains = list(/obj/item/gun/ballistic/shotgun/toy/riot)

/datum/supply_pack/goody/foamforce/smg
	contains = list(/obj/item/gun/ballistic/automatic/toy/riot)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/goody/foamforce/c20
	contains = list(/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/goody/foamforce/lmg
	contains = list(/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/goody/foamforce/turret
	contains = list(/obj/item/storage/toolbox/emergency/turret/mag_fed/toy/pre_filled)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/goody/foamforce/pistol
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)

/datum/supply_pack/goody/foamforce/ammo
	cost = PAYCHECK_CREW

/datum/supply_pack/goody/foamforce/ammo/darts
	contains = list(/obj/item/ammo_box/foambox)
	cost = PAYCHECK_LOWER

/datum/supply_pack/goody/foamforce/ammo/riot
	contains = list(/obj/item/ammo_box/foambox/riot)
	cost = PAYCHECK_COMMAND * 1.5

/datum/supply_pack/goody/foamforce/ammo/pistol_mag
	contains = list(/obj/item/ammo_box/magazine/toy/pistol)

/datum/supply_pack/goody/foamforce/ammo/smg_mag
	contains = list(/obj/item/ammo_box/magazine/toy/smg)

/datum/supply_pack/goody/foamforce/ammo/smgm45_mag
	contains = list(/obj/item/ammo_box/magazine/toy/smgm45)

/datum/supply_pack/goody/foamforce/ammo/m762_mag
	contains = list(/obj/item/ammo_box/magazine/toy/m762)

/datum/supply_pack/goody/pepperball_gun
	cost = PAYCHECK_CREW * 9
	access = ACCESS_SECURITY
	contains = list(/obj/item/storage/toolbox/guncase/skyrat/pistol/pepperball)

/datum/supply_pack/goody/taser
	cost = PAYCHECK_CREW * 12
	access = ACCESS_SECURITY
	contains = list(/obj/item/gun/energy/e_gun/advtaser)

/datum/supply_pack/goody/standard_mod_core
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/standard)

/datum/supply_pack/goody/plasma_mod_core
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/plasma)

/datum/supply_pack/goody/ethereal_mod_core
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/mod/core/ethereal)

/datum/supply_pack/goody/cosmohonk
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/mod/construction/plating/cosmohonk)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/goody/magnetic_deployable
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/mod/module/springlock/contractor)

/datum/supply_pack/goody/storage_large_capacity
	cost = PAYCHECK_COMMAND
	contains = list(/obj/item/mod/module/storage/large_capacity)

/datum/supply_pack/goody/crew_monitor
	cost = PAYCHECK_COMMAND * 4.5
	contains = list(/obj/item/sensor_device)

/datum/supply_pack/goody/soap
	cost = PAYCHECK_LOWER * 3
	contains = list(/obj/item/soap/deluxe)
