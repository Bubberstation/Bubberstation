/datum/supply_pack/selfdef
	access = NONE
	cost = PAYCHECK_CREW
	group = "Sol Federation Imports"
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/selfdef/clothing
	cost = PAYCHECK_CREW

/datum/supply_pack/selfdef/clothing/peacekeeper
	contains = list(/obj/item/clothing/under/sol_peacekeeper)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing
	contains = list(/obj/item/clothing/under/sol_emt)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/selfdef/clothing/armor/ballistic_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper/debranded)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/sf_ballistic_helmet
	contains = list(/obj/item/clothing/head/helmet/sf_peacekeeper)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/soft_vest
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper/debranded)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/sf_soft_vest
	contains = list(/obj/item/clothing/suit/armor/sf_peacekeeper)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/flak_jacket
	contains = list(/obj/item/clothing/suit/armor/vest/det_suit/terra)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/slim_vest
	contains = list(/obj/item/clothing/suit/armor/vest)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/enclosed_helmet
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/emt_enclosed_helmet
	contains = list(/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/hardened_vest
	contains = list(/obj/item/clothing/suit/armor/sf_hardened)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/emt_hardened_vest
	contains = list(/obj/item/clothing/suit/armor/sf_hardened/emt)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/sacrifice
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/selfdef/clothing/armor/sacrifice/helmet
	contains = list(/obj/item/clothing/head/helmet/sf_sacrificial)
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/sacrifice/face_shield
	contains = list(/obj/item/sacrificial_face_shield)
	cost = PAYCHECK_LOWER
	auto_name = TRUE

/datum/supply_pack/selfdef/clothing/armor/sacrifice/vest
	contains = list(/obj/item/clothing/suit/armor/sf_sacrificial)
	auto_name = TRUE
