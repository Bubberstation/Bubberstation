/datum/supply_pack/selfdef
	access = NONE
	cost = PAYCHECK_CREW
	group = "Sol Federation Imports" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing
	cost = PAYCHECK_CREW

/datum/supply_pack/selfdef/clothing/peacekeeper
	contains = list(/obj/item/clothing/under/sol_peacekeeper)

/datum/supply_pack/selfdef/clothing
	contains = list(/obj/item/clothing/under/sol_emt)

/datum/supply_pack/selfdef/clothing/armor
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/selfdef/clothing/armor/ballistic_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper/debranded)

/datum/supply_pack/selfdef/clothing/armor/sf_ballistic_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper)

/datum/supply_pack/selfdef/clothing/armor/soft_vest
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper/debranded)

/datum/supply_pack/selfdef/clothing/armor/sf_soft_vest
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper)

/datum/supply_pack/selfdef/clothing/armor/flak_jacket
	contains = list(/obj/item/clothing/suit/armor/vest/det_suit/terra)

/datum/supply_pack/selfdef/clothing/armor/slim_vest
	contains = list(/obj/item/clothing/suit/armor/vest)

/datum/supply_pack/selfdef/clothing/armor/enclosed_helmet
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened)

/datum/supply_pack/selfdef/clothing/armor/emt_enclosed_helmet
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt)

/datum/supply_pack/selfdef/clothing/armor/hardened_vest
	contains = list(/obj/item/clothing/suit/armor/sf_hardened)

/datum/supply_pack/selfdef/clothing/armor/emt_hardened_vest
	contains = list(/obj/item/clothing/suit/armor/sf_hardened/emt)

/datum/supply_pack/selfdef/clothing/armor/sacrifice
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/selfdef/clothing/armor/sacrifice/helmet
	contains = list(/obj/item/clothing/head/helmet/sf_sacrificial)

/datum/supply_pack/selfdef/clothing/armor/sacrifice/face_shield
	contains = list(/obj/item/sacrificial_face_shield)
	cost = PAYCHECK_LOWER

/datum/supply_pack/selfdef/clothing/armor/sacrifice/vest
	contains = list(/obj/item/clothing/suit/armor/sf_sacrificial)

/datum/supply_pack/selfdef/ammo_machines/bench
	contains = list(/obj/item/circuitboard/machine/ammo_workbench)
	cost = PAYCHECK_COMMAND * 5

/datum/supply_pack/selfdef/ammo_machines/bullet_drive
	contains = list(/obj/item/circuitboard/machine/dish_drive/bullet)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/selfdef/gun_accessories/suppressor
	contains = list(/obj/item/suppressor/standard)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/selfdef/speedloader
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/selfdef/speedloader/det_lethal
	contains = list(/obj/item/ammo_box/speedloader/c38)

/datum/supply_pack/selfdef/speedloader/det_dumdum
	contains = list(/obj/item/ammo_box/speedloader/c38/dumdum)

/datum/supply_pack/selfdef/speedloader/det_bouncy
	contains = list(/obj/item/ammo_box/speedloader/c38/match)

/datum/supply_pack/selfdef/shotbox
	cost = PAYCHECK_COMMAND

/datum/supply_pack/selfdef/shotbox/beanbag
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean)

/datum/supply_pack/selfdef/shotbox/rubber
	contains = list(/obj/item/ammo_box/advanced/s12gauge/rubber)

/datum/supply_pack/selfdef/shotbox/hunter
	contains = list(/obj/item/ammo_box/advanced/s12gauge/hunter)

/datum/supply_pack/selfdef/shotbox/honk
	contains = list(/obj/item/ammo_box/advanced/s12gauge/honkshot)
	cost = PAYCHECK_LOWER

/datum/supply_pack/selfdef/nadeshells/
	cost = PAYCHECK_COMMAND

/datum/supply_pack/selfdef/nadeshells/practice
	contains = list(/obj/item/ammo_box/c980grenade)

/datum/supply_pack/selfdef/nadeshells/smoke
	contains = list(/obj/item/ammo_box/c980grenade/smoke)

/datum/supply_pack/selfdef/nadeshells/riot
	contains = list(/obj/item/ammo_box/c980grenade/riot)

/datum/supply_pack/selfdef/nadeshells/shrapnel
	contains = list(/obj/item/ammo_box/c980grenade/shrapnel)
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/selfdef/nadeshells/phosphor
	contains = list(/obj/item/ammo_box/c980grenade/shrapnel/phosphor)
	order_flags = ORDER_CONTRABAND
