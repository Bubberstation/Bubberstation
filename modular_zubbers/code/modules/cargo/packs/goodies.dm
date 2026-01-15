/datum/supply_pack/goody/smg_single
	name = "Disabler SMG Single-Pack"
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/goody/lasercarbine_single
	name = "Laser Carbine Single-Pack"
	desc = "Contains one laser carbine, an automatic variant of the laser gun. For when you need a fast-firing lethal-only solution."
	cost = PAYCHECK_COMMAND * 7
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/laser/carbine)

/datum/supply_pack/goody/miniegun_single
	name = "Mini E-Gun Single-Pack"
	desc = "Contains one mini e-gun, for when your Bridge Officer loses theirs to the clown."
	cost = PAYCHECK_COMMAND * 5
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/energy/e_gun/mini)

/datum/supply_pack/goody/wt550_single
	name = "WT-551 Autorifle Single-Pack"
	desc = "An NT-security grade autorifle, it comes with excellent heating and poses no health-related risks for the user. Comes as a single-pack with one WT-551 locked and loaded."
	cost = PAYCHECK_COMMAND * 8 //Nvm these are stronger than lasers in most scenarios so let's get them a bit of an edge. Plus gun price variety looks better
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/automatic/wt550/security)

/datum/supply_pack/goody/wt550_ammo
	name = "WT-550/WT-551 Autorifle Magazine Single-Pack"
	desc = "A single-pack magazine with lethal regular rounds for the WT-551."
	cost = PAYCHECK_CREW * 5 //Scale it like all guns
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 1)

/datum/supply_pack/goody/nt_shotgun
	name = "Nanotrasen Woodstock Shotgun"
	desc = "A classic shotgun used by hunters, police and frontiersmen alike, now at an affordable price."
	cost = PAYCHECK_COMMAND * 12 //Worse renoster, let's make it a tad cheaper
	access_view = ACCESS_WEAPONS
	contains = list(/obj/item/gun/ballistic/shotgun/riot, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/hunter)

/datum/supply_pack/goody/renoster_shotgun
	name = "Renoster Shotgun Single-Pack"
	desc = "A common modern shotgun used by Terran Government Police."
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol, /obj/item/storage/pouch/ammo, /obj/item/storage/belt/bandolier, /obj/item/ammo_box/advanced/s12gauge/rubber)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 14 //I'd say it's at odds with the combat shotgun, sustain vs burst and such, but since ss13 favours burst I'll make it a tad cheaper.

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

/datum/supply_pack/goody/plasma_marksman_ammo
	name = "Plasma Battery Single-pack"
	desc = "Contains a single plasma battery."
	contains = list(/obj/item/ammo_box/magazine/recharge/plasma_battery = 1)
	access_view = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 1


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

/datum/supply_pack/imports/donk
	access = NONE
	cost = PAYCHECK_CREW
	group = "Goodies" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/donk/food/ready/standard
	name = "Ready Donk"
	contains = list(/obj/item/food/ready_donk)

/datum/supply_pack/imports/donk/food/ready/donkhiladas
	name = "Ready Donkhiladas"
	contains = list(/obj/item/food/ready_donk/donkhiladas)

/datum/supply_pack/imports/donk/food/ready/mac_n_cheese
	name = "Mac & Cheese Ready Donk"
	contains = list(/obj/item/food/ready_donk/mac_n_cheese)

/datum/supply_pack/imports/donk/food/pockets/standard
	name = "Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets)

/datum/supply_pack/imports/donk/food/pockets/berry
	name = "Berry Honk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketberry)

/datum/supply_pack/imports/donk/food/pockets/banana
	name = "Honk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpockethonk)

/datum/supply_pack/imports/donk/food/pockets/pizza
	name = "Pizza Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketpizza)

/datum/supply_pack/imports/donk/food/pockets/spicy
	name = "Spicy Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketspicy)

/datum/supply_pack/imports/donk/food/pockets/teriyaki
	name = "Teriyaki Donk Pockets"
	contains = list(/obj/item/storage/box/donkpockets/donkpocketteriyaki)

/datum/supply_pack/imports/donk/merch/donk_carpet
	name = "Donk Pocket Carpet"
	contains = list(/obj/item/stack/tile/carpet/donk/thirty)

/datum/supply_pack/imports/donk/merch/tacticool_turtleneck
	name = "Tacticool Turtleneck"
	contains = list(/obj/item/clothing/under/syndicate/tacticool)

/datum/supply_pack/imports/donk/merch/tacticool_turtleneck_skirt
	name = "Tacticool Turtleneck Skirt"
	contains = list(/obj/item/clothing/under/syndicate/tacticool/skirt)

/datum/supply_pack/imports/donk/merch/fake_centcom_turtleneck
	name = "Replica CentCom Turtleneck"
	contains = list(/obj/item/clothing/under/rank/centcom/officer/replica)

/datum/supply_pack/imports/donk/merch/fake_centcom_turtleneck_skirt
	name = "Replica CentCom Turtleneck Skirt"
	contains = list(/obj/item/clothing/under/rank/centcom/officer_skirt/replica)

/datum/supply_pack/imports/donk/merch/snack_rig
	name = "Donk Co. Tactical Snack Belt"
	contains = list(/obj/item/storage/belt/military/snack)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/donk/merch/fake_syndie_suit
	name = "Replica Syndicate Suit"
	contains = list(/obj/item/storage/box/fakesyndiesuit)

/datum/supply_pack/imports/donk/merch/syndicate_balloon
	name = "Syndicate Balloon"
	contains = list(/obj/item/toy/balloon/arrest)

/datum/supply_pack/imports/donk/foamforce
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/donk/foamforce/pistol
	name = "Foam Dart Pistol"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)

/datum/supply_pack/imports/donk/foamforce/shotgun
	name = "Foam Dart Shotgun"
	contains = list(/obj/item/gun/ballistic/shotgun/toy/riot)

/datum/supply_pack/imports/donk/foamforce/smg
	name = "Foam Dart SMG"
	contains = list(/obj/item/gun/ballistic/automatic/toy/riot)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/donk/foamforce/c20
	name = "Foam Dart C20R"
	contains = list(/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted)
	cost = PAYCHECK_COMMAND * 3

/datum/supply_pack/imports/donk/foamforce/lmg
	name = "Foam Dart L6 Saw"
	contains = list(/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/donk/foamforce/turret
	name = "Foam Dart Turret"
	contains = list(/obj/item/storage/toolbox/emergency/turret/mag_fed/toy/pre_filled)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/donk/foamforce/pistol
	name = "Foam Dart Pistol"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)

/datum/supply_pack/imports/donk/foamforce/ammo
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/donk/foamforce/ammo/darts
	name = "Foamforce Darts"
	contains = list(/obj/item/ammo_box/foambox)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/donk/foamforce/ammo/riot
	name = "Foamforce Riot Darts"
	contains = list(/obj/item/ammo_box/foambox/riot)
	cost = PAYCHECK_COMMAND * 1.5

/datum/supply_pack/imports/donk/foamforce/ammo/pistol_mag
	name = "Foamforce Pistol Magazine"
	contains = list(/obj/item/ammo_box/magazine/toy/pistol)

/datum/supply_pack/imports/donk/foamforce/ammo/smg_mag
	name = "Foamforce SMG Magazine"
	contains = list(/obj/item/ammo_box/magazine/toy/smg)

/datum/supply_pack/imports/donk/foamforce/ammo/smgm45_mag
	name = "Foamforce SMGM45 Magazine"
	contains = list(/obj/item/ammo_box/magazine/toy/smgm45)

/datum/supply_pack/imports/donk/foamforce/ammo/m762_mag
	name = "Foamforce M762 Mag"
	contains = list(/obj/item/ammo_box/magazine/toy/m762)
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
	order_flags = ORDER_CONTRABAND

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

/datum/supply_pack/goody/crew_monitor
	name = "Handheld Crew Monitor Single-Pack"
	desc = "A miniature machine that tracks suit sensors across the station."
	cost = PAYCHECK_COMMAND * 4.5
	contains = list(/obj/item/sensor_device)

/datum/supply_pack/goody/soap
	name = "Soap Single-Pack"
	desc = "Recommended for emergency self-cleaning, passive-aggressive demonstrations, or reminding others that hygiene is, in fact, part of the job."
	cost = PAYCHECK_LOWER * 3
	contains = list(/obj/item/soap/deluxe)
