/datum/supply_pack/company_import/sol_defense
	subcategory = "Sol Defense"

/datum/supply_pack/company_import/sol_defense/clothing
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/sol_defense/clothing/peacekeeper
	item_type = /obj/item/clothing/under/sol_peacekeeper

/datum/supply_pack/company_import/sol_defense/clothing/emt
	item_type = /obj/item/clothing/under/sol_emt

/datum/supply_pack/company_import/sol_defense/armor
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/company_import/sol_defense/armor/ballistic_helmet
	item_type = /obj/item/clothing/head/helmet/sf_peacekeeper/debranded

/datum/supply_pack/company_import/sol_defense/armor/sf_ballistic_helmet
	item_type = /obj/item/clothing/head/helmet/sf_peacekeeper

/datum/supply_pack/company_import/sol_defense/armor/soft_vest
	item_type = /obj/item/clothing/suit/armor/sf_peacekeeper/debranded

/datum/supply_pack/company_import/sol_defense/armor/sf_soft_vest
	item_type = /obj/item/clothing/suit/armor/sf_peacekeeper

/datum/supply_pack/company_import/sol_defense/armor/flak_jacket
	item_type = /obj/item/clothing/suit/armor/vest/det_suit/terra

/datum/supply_pack/company_import/sol_defense/armor/slim_vest
	name = "type I vest"
	item_type = /obj/item/clothing/suit/armor/vest

/datum/supply_pack/company_import/sol_defense/armor_hardened
	cost = PAYCHECK_CREW * 6

/datum/supply_pack/company_import/sol_defense/armor_hardened/enclosed_helmet
	item_type = /obj/item/clothing/head/helmet/toggleable/sf_hardened

/datum/supply_pack/company_import/sol_defense/armor_hardened/emt_enclosed_helmet
	item_type = /obj/item/clothing/head/helmet/toggleable/sf_hardened/emt

/datum/supply_pack/company_import/sol_defense/armor_hardened/hardened_vest
	item_type = /obj/item/clothing/suit/armor/sf_hardened

/datum/supply_pack/company_import/sol_defense/armor_hardened/emt_hardened_vest
	item_type = /obj/item/clothing/suit/armor/sf_hardened/emt

/datum/supply_pack/company_import/sol_defense/armor_sacrifice
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/company_import/sol_defense/armor_sacrifice/sacrificial_helmet
	item_type = /obj/item/clothing/head/helmet/sf_sacrificial

/datum/supply_pack/company_import/sol_defense/armor_sacrifice/face_shield
	item_type = /obj/item/sacrificial_face_shield
	cost = PAYCHECK_LOWER

/datum/supply_pack/company_import/sol_defense/armor_sacrifice/sacrificial_vest
	item_type = /obj/item/clothing/suit/armor/sf_sacrificial

/datum/supply_pack/company_import/sol_defense/magazines
	cost = PAYCHECK_CREW

/datum/supply_pack/company_import/sol_defense/magazines/sol_grenade_standard
	item_type = /obj/item/ammo_box/magazine/c980_grenade/starts_empty
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/company_import/sol_defense/magazines/sol_grenade_drum
	item_type = /obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty
	cost = PAYCHECK_CREW * 3
	order_flags = ORDER_CONTRABAND
