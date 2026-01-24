/datum/supply_pack/nri
	access = NONE
	cost = PAYCHECK_LOWER
	group = "NRI Surplus" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE
	auto_name = TRUE

/datum/supply_pack/nri/uniform
	contains = list(/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color)
	cost = PAYCHECK_CREW

/datum/supply_pack/nri/belt
	contains = list(/obj/item/storage/belt/military/cin_surplus/random_color)
	cost = PAYCHECK_CREW

/datum/supply_pack/nri/backpack
	contains = list(/obj/item/storage/backpack/industrial/cin_surplus/random_color)
	cost = PAYCHECK_CREW

/datum/supply_pack/nri/gasmask
	contains = list(/obj/item/clothing/mask/gas/hecu2)
	cost = PAYCHECK_CREW

/datum/supply_pack/nri/helmet
	contains = list(/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/nri/vest
	contains = list(/obj/item/clothing/suit/armor/vest/cin_surplus_vest)
	cost = PAYCHECK_COMMAND


/datum/supply_pack/nri/police
	cost = PAYCHECK_CREW
	access = ACCESS_SECURITY

/datum/supply_pack/nri/police/uniform
	contains = list(/obj/item/clothing/under/colonial/nri_police)

/datum/supply_pack/nri/police/cloak
	contains = list(/obj/item/clothing/neck/cloak/colonial/nri_police)

/datum/supply_pack/nri/police/cap
	contains = list(/obj/item/clothing/head/hats/colonial/nri_police)

/datum/supply_pack/nri/police/mask
	contains = list(/obj/item/clothing/mask/gas/nri_police)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/nri/police/vest
	contains = list(/obj/item/clothing/head/helmet/nri_police)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/nri/police/helmet
	contains = list(/obj/item/clothing/suit/armor/vest/nri_police)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/nri/goodies
	cost = PAYCHECK_CREW

/datum/supply_pack/nri/goodies/flares
	contains = list(/obj/item/storage/box/nri_flares)
	cost = PAYCHECK_LOWER

/datum/supply_pack/nri/goodies/binoculars
	contains = list(/obj/item/binoculars)

/datum/supply_pack/nri/goodies/screwpen
	contains = list(/obj/item/pen/screwdriver)

/datum/supply_pack/nri/goodies/trench_tool
	contains = list(/obj/item/trench_tool)

/datum/supply_pack/nri/goodies/flag
	contains = list(/obj/item/sign/flag/nri)
	cost = PAYCHECK_LOWER

/datum/supply_pack/nri/food_replicator
	contains = list(/obj/item/circuitboard/machine/biogenerator/food_replicator)
	cost = CARGO_CRATE_VALUE * 9

/datum/supply_pack/nri/pods/botany
	contains = list(/obj/item/survivalcapsule/botany)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/nri/pods/botany_trays
	contains = list(/obj/item/survivalcapsule/trays)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/nri/pods/kitchen
	contains = list(/obj/item/survivalcapsule/kitchen)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/nri/pods/oxygen
	contains = list(/obj/item/survivalcapsule/o2)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/nri/pods/fanpod
	contains = list(/obj/item/survivalcapsule/fan)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/nri/pods/threebythree
	contains = list(/obj/item/survivalcapsule/threebythree)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/nri/pods/sixbysix
	contains = list(/obj/item/survivalcapsule/)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/nri/pods/cabin
	contains = list(/obj/item/survivalcapsule/cabin)
	cost = PAYCHECK_COMMAND * 2
