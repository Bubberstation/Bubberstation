/datum/supply_pack/psc
	access = NONE
	group = "PSC Surplus"
	crate_type = /obj/structure/closet/crate/secure/gear

/datum/supply_pack/psc/recruit_kit
	contains = list(
		/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color,
		/obj/item/storage/belt/military/cin_surplus/random_color,
		/obj/item/clothing/mask/gas/hecu2,
		/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color,
		/obj/item/clothing/suit/armor/vest/cin_surplus_vest,
	)
	cost = PAYCHECK_CREW * 8
	auto_name = TRUE

/datum/supply_pack/psc/police
	access = ACCESS_SECURITY

/datum/supply_pack/psc/police/recruit_kit
	contains = list(
		/obj/item/clothing/under/colonial/nri_police,
		/obj/item/clothing/neck/cloak/colonial/nri_police,
		/obj/item/clothing/head/hats/colonial/nri_police,
		/obj/item/clothing/mask/gas/nri_police,
		/obj/item/clothing/head/helmet/nri_police,
		/obj/item/clothing/suit/armor/vest/nri_police,
	)
	cost = PAYCHECK_CREW * 10
	auto_name = TRUE

/datum/supply_pack/psc/goodies
	cost = PAYCHECK_CREW
	order_flags = ORDER_GOODY
	crate_type = null

/datum/supply_pack/psc/goodies/flares
	contains = list(/obj/item/storage/box/nri_flares)
	cost = PAYCHECK_LOWER
	auto_name = TRUE

/datum/supply_pack/psc/goodies/binoculars
	contains = list(/obj/item/binoculars)
	auto_name = TRUE

/datum/supply_pack/psc/goodies/screwpen
	contains = list(/obj/item/pen/screwdriver)
	auto_name = TRUE

/datum/supply_pack/psc/goodies/trench_tool
	contains = list(/obj/item/trench_tool)
	auto_name = TRUE

/datum/supply_pack/psc/food_replicator
	contains = list(/obj/item/circuitboard/machine/biogenerator/food_replicator)
	cost = CARGO_CRATE_VALUE * 9
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/botany
	contains = list(/obj/item/survivalcapsule/botany)
	cost = PAYCHECK_COMMAND * 4
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/botany_trays
	contains = list(/obj/item/survivalcapsule/trays)
	cost = PAYCHECK_COMMAND * 2
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/kitchen
	contains = list(/obj/item/survivalcapsule/kitchen)
	cost = PAYCHECK_COMMAND * 4
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/oxygen
	contains = list(/obj/item/survivalcapsule/o2)
	cost = PAYCHECK_COMMAND * 4
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/fanpod
	contains = list(/obj/item/survivalcapsule/fan)
	cost = PAYCHECK_COMMAND
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/threebythree
	contains = list(/obj/item/survivalcapsule/threebythree)
	cost = PAYCHECK_COMMAND
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/sixbysix
	contains = list(/obj/item/survivalcapsule/sixbysix)
	cost = PAYCHECK_COMMAND * 2
	auto_name = TRUE

/datum/supply_pack/psc/goodies/pods/cabin
	contains = list(/obj/item/survivalcapsule/cabin)
	cost = PAYCHECK_COMMAND * 2
	auto_name = TRUE
