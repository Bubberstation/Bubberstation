/datum/supply_pack/imports/nri
	access = NONE
	cost = PAYCHECK_LOWER
	group = "NRI Surplus" //figure this out later
	order_flags = ORDER_GOODY
	crate_type = null
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/imports/nri/uniform
	name = "Random NRI Uniform"
	contains = list(/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/nri/belt
	name = "NRI Belt"
	contains = list(/obj/item/storage/belt/military/cin_surplus/random_color)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/nri/backpack
	name = "Random NRI Backpack"
	contains = list(/obj/item/storage/backpack/industrial/cin_surplus/random_color)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/nri/gasmask
	name = "NRI Gas Mask"
	contains = list(/obj/item/clothing/mask/gas/hecu2)
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/nri/helmet
	name = "Random NRI Helmet"
	contains = list(/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/nri/vest
	name = "NRI Vest"
	contains = list(/obj/item/clothing/suit/armor/vest/cin_surplus_vest)
	cost = PAYCHECK_COMMAND


/datum/supply_pack/imports/nri/police
	cost = PAYCHECK_CREW
	access = ACCESS_SECURITY

/datum/supply_pack/imports/nri/police/uniform
	name = "NRI Police Uniform"
	contains = list(/obj/item/clothing/under/colonial/nri_police)

/datum/supply_pack/imports/nri/police/cloak
	name = "NRI Police Cloak"
	contains = list(/obj/item/clothing/neck/cloak/colonial/nri_police)

/datum/supply_pack/imports/nri/police/cap
	name = "NRI Police Cap"
	contains = list(/obj/item/clothing/head/hats/colonial/nri_police)

/datum/supply_pack/imports/nri/police/mask
	name = "NRI Police Gas Mask"
	contains = list(/obj/item/clothing/mask/gas/nri_police)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/imports/nri/police/vest
	name = "NRI Police Vest"
	contains = list(/obj/item/clothing/head/helmet/nri_police)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/nri/police/helmet
	name = "NRI Police Helmet"
	contains = list(/obj/item/clothing/suit/armor/vest/nri_police)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/nri/goodies
	cost = PAYCHECK_CREW

/datum/supply_pack/imports/nri/goodies/flares
	name = "NRI Flares"
	contains = list(/obj/item/storage/box/nri_flares)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/nri/goodies/binoculars
	name = "NRI Binoculars"
	contains = list(/obj/item/binoculars)

/datum/supply_pack/imports/nri/goodies/screwpen
	name = "NRI Screwdriver Pen"
	contains = list(/obj/item/pen/screwdriver)

/datum/supply_pack/imports/nri/goodies/trench_tool
	name = "NRI Trench Tool"
	contains = list(/obj/item/trench_tool)

/datum/supply_pack/imports/nri/goodies/flag
	name = "NRI Flag"
	contains = list(/obj/item/sign/flag/nri)
	cost = PAYCHECK_LOWER

/datum/supply_pack/imports/nri/food_replicator
	name = "NRI Food Replicator Circuitboard"
	contains = list(/obj/item/circuitboard/machine/biogenerator/food_replicator)
	cost = CARGO_CRATE_VALUE * 9

/datum/supply_pack/imports/nri/pods/botany
	name = "Botany Survival Pod"
	contains = list(/obj/item/survivalcapsule/botany)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/nri/pods/botany_trays
	name = "Botany Trays Survival Pod Addon"
	contains = list(/obj/item/survivalcapsule/trays)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/nri/pods/kitchen
	name = "Kitchen Survival Pod"
	contains = list(/obj/item/survivalcapsule/kitchen)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/nri/pods/oxygen
	name = "Oxygen Survival Pod"
	contains = list(/obj/item/survivalcapsule/o2)
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/imports/nri/pods/fanpod
	name = "Fan Survival Pod"
	contains = list(/obj/item/survivalcapsule/fan)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/nri/pods/threebythree
	name = "3x3 Survival Pod"
	contains = list(/obj/item/survivalcapsule/threebythree)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/imports/nri/pods/sixbysix
	name = "6x6 Survival Pod"
	contains = list(/obj/item/survivalcapsule/)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/imports/nri/pods/cabin
	name = "Cabin Survival Pod"
	contains = list(/obj/item/survivalcapsule/cabin)
	cost = PAYCHECK_COMMAND * 2
