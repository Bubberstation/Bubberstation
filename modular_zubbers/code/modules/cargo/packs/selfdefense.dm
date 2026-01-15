/datum/supply_pack/imports/selfdef
	access = NONE
	cost = PAYCHECK_CREW
	group = "Sol Federation Imports" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/selfdef/clothing
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/selfdef/clothing/peacekeeper
	name = "Sol Peacekeeper Uniform"
	contains = list(/obj/item/clothing/under/sol_peacekeeper)

/datum/supply_pack/imports/selfdef/clothing
	name = "Sol Emergency Medical Technician Uniform"
	contains = list(/obj/item/clothing/under/sol_emt)

/datum/supply_pack/imports/selfdef/clothing/armor
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/imports/selfdef/clothing/armor/ballistic_helmet
	name = "Ballistic Helmet"
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper/debranded)

/datum/supply_pack/imports/selfdef/clothing/armor/sf_ballistic_helmet
	name = "Solfed Ballistic Helmet"
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper)

/datum/supply_pack/imports/selfdef/clothing/armor/soft_vest
	name = "Soft Vest"
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper/debranded)

/datum/supply_pack/imports/selfdef/clothing/armor/sf_soft_vest
	name = "Solfed Soft Vest"
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper)

/datum/supply_pack/imports/selfdef/clothing/armor/flak_jacket
	name = "Flak Jacket"
	contains = list(/obj/item/clothing/suit/armor/vest/det_suit/terra)

/datum/supply_pack/imports/selfdef/clothing/armor/slim_vest
	name = "Type I Vest"
	contains = list(/obj/item/clothing/suit/armor/vest)

/datum/supply_pack/imports/selfdef/clothing/armor/enclosed_helmet
	name = "Solfed Hardened Helmet"
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened)

/datum/supply_pack/imports/selfdef/clothing/armor/emt_enclosed_helmet
	name = "Solfed EMT Hardened Helmet"
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt)

/datum/supply_pack/imports/selfdef/clothing/armor/hardened_vest
	name = "Solfed Hardened Vest"
	contains = list(/obj/item/clothing/suit/armor/sf_hardened)

/datum/supply_pack/imports/selfdef/clothing/armor/emt_hardened_vest
	name = "Solfed EMT Hardened Vest"
	contains = list(/obj/item/clothing/suit/armor/sf_hardened/emt)

/datum/supply_pack/imports/selfdef/clothing/armor/sacrifice
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/imports/selfdef/clothing/armor/sacrifice/helmet
	name = "Solfed Sacrificial Helmet"
	contains = list(/obj/item/clothing/head/helmet/sf_sacrificial)

/datum/supply_pack/imports/selfdef/clothing/armor/sacrifice/face_shield
	name = "Solfed Sacrificial Face Shield"
	contains = list(/obj/item/sacrificial_face_shield)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/selfdef/clothing/armor/sacrifice/vest
	name = "Solfed Sacrificial Vest"
	contains = list(/obj/item/clothing/suit/armor/sf_sacrificial)

/datum/supply_pack/imports/selfdef/guns
	access = ACCESS_WEAPONS
	cost = PAYCHECK_COMMAND * 4.0

/datum/supply_pack/imports/selfdef/guns/eland
	name = "Eland Revolver"
	contains = list(/obj/item/gun/ballistic/revolver/sol)

/datum/supply_pack/imports/selfdef/guns/wespe
	name = "Wespe Revolver"
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sol)

/datum/supply_pack/imports/selfdef/guns/renoster
	name = "Renoster Shotgun"
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol)
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/imports/selfdef/guns/sindano
	name = "Sindano SMG"
	contains = list(/obj/item/gun/ballistic/automatic/sol_smg)
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/imports/selfdef/guns/elite
	name = "Elite Marksman"
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/marksman)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports/selfdef/guns/sidano_conversion
	name = "Sidano Conversion Kit"
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/marksman)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/imports/selfdef/mags
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/selfdef/mags/c35
	name = "C35 Pistol Magazine"
	contains = list(/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty)

/datum/supply_pack/imports/selfdef/mags/c35_extended
	name = "Extended C35 Pistol Magazine"
	contains = list(/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/selfdef/mags/c980
	name = "C980 Grenade Magazine"
	contains = list(/obj/item/ammo_box/magazine/c980_grenade/starts_empty)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/selfdef/mags/c980_extended
	name = "C980 Grenade Drum Magazine"
	contains = list(/obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty)
	cost = PAYCHECK_CREW * 3
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/selfdef/ammo_machines/bench
	name = "Ammo Workbench Circuit"
	contains = list(/obj/item/circuitboard/machine/ammo_workbench)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/imports/selfdef/ammo_machines/bullet_drive
	name = "Bullet Drive Circuit"
	contains = list(/obj/item/circuitboard/machine/dish_drive/bullet)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/selfdef/gun_accessories/suppressor
	name = "Suppressor"
	contains = list(/obj/item/suppressor/standard)
	cost = PAYCHECK_COMMAND


/datum/supply_pack/imports/selfdef/ammo_boxes/
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/selfdef/ammo_boxes/sol35
	name = "C35 Sol Ammo Box"
	contains = list(/obj/item/ammo_box/c35sol)

/datum/supply_pack/imports/selfdef/ammo_boxes/sol35_incap
	name = "C35 Sol Incapacitator Ammo Box"
	contains = list(/obj/item/ammo_box/c35sol/incapacitator)

/datum/supply_pack/imports/selfdef/ammo_boxes/sol40_frag
	name = "C40 Sol Fragmentation Ammo Box"
	contains = list(/obj/item/ammo_box/c40sol/fragmentation)

/datum/supply_pack/imports/selfdef/ammo_boxes/c585trappiste_incap
	name = "C585 Trappiste Incapacitator Ammo Box"
	contains = list(/obj/item/ammo_box/c585trappiste/incapacitator)

/datum/supply_pack/imports/selfdef/speedloader
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/selfdef/speedloader/det_lethal
	name = "C38 Speedloader (Lethal)"
	contains = list(/obj/item/ammo_box/speedloader/c38)

/datum/supply_pack/imports/selfdef/speedloader/det_dumdum
	name = "C38 Speedloader (Dumdum)"
	contains = list(/obj/item/ammo_box/speedloader/c38/dumdum)

/datum/supply_pack/imports/selfdef/speedloader/det_bouncy
	name = "C38 Speedloader (Bouncy)"
	contains = list(/obj/item/ammo_box/speedloader/c38/match)

/datum/supply_pack/imports/selfdef/shotbox
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/selfdef/shotbox/beanbag
	name = "Shotgun Beanbag Round Box"
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean)

/datum/supply_pack/imports/selfdef/shotbox/rubber
	name = "Shotgun Rubbershot Box"
	contains = list(/obj/item/ammo_box/advanced/s12gauge/rubber)

/datum/supply_pack/imports/selfdef/shotbox/hunter
	name = "Shotgun Hunting Slug Box"
	contains = list(/obj/item/ammo_box/advanced/s12gauge/hunter)

/datum/supply_pack/imports/selfdef/shotbox/honk
	name = "Honkshot Shell Box"
	contains = list(/obj/item/ammo_box/advanced/s12gauge/honkshot)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/selfdef/nadeshells/
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/selfdef/nadeshells/practice
	name = "C980 Grenade Launcher Practice Shells"
	contains = list(/obj/item/ammo_box/c980grenade)

/datum/supply_pack/imports/selfdef/nadeshells/smoke
	name = "C980 Grenade Launcher Smoke Shells"
	contains = list(/obj/item/ammo_box/c980grenade/smoke)

/datum/supply_pack/imports/selfdef/nadeshells/riot
	name = "C980 Grenade Launcher Riot Shells"
	contains = list(/obj/item/ammo_box/c980grenade/riot)

/datum/supply_pack/imports/selfdef/nadeshells/shrapnel
	name = "C980 Grenade Launcher Shrapnel Shells"
	contains = list(/obj/item/ammo_box/c980grenade/shrapnel)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/selfdef/nadeshells/phosphor
	name = "C980 Grenade Launcher White Phosphorous Shells"
	contains = list(/obj/item/ammo_box/c980grenade/shrapnel/phosphor)
	order_flags = ORDER_CONTRABAND
