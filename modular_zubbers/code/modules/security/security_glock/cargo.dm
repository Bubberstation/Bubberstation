/datum/supply_pack/security/armory/alert_level_firing_pin
	name = "Alert Level Firing Pin Crate"
	desc = "Contains four special firing pins that only allow firing on code blue or higher."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/firing_pin/alert_level = 4)
	crate_name = "alert level firing pin crate"

/datum/supply_pack/science/protean_organs
	name = "Protean Organs"
	desc = "Contains two sets of organs for Protean crewmembers."
	cost = CARGO_CRATE_VALUE * 10 // Not cheap
	contains = list(/obj/item/organ/stomach/protean = 2, /obj/item/organ/heart/protean = 2)
	crate_name = "protean organs"
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	crate_type = /obj/structure/closet/crate/secure/science/robo
