/datum/supply_pack/science/protean_organs
	name = "Protean Organs"
	desc = "Contains two sets of organs for Protean crewmembers."
	contains = list(/obj/item/organ/stomach/protean = 2, /obj/item/organ/heart/protean = 2)
	crate_name = "protean organs"
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	crate_type = /obj/structure/closet/crate/secure/science/robo

/datum/supply_pack/science/protean_vessel
	name = "Protean Vessel"
	desc = "Contains a blank protean body, the refactory on its last legs, long enough to place the core in the vessel, but will quickly deteriorate as soon as the core goes inside."
	cost = CARGO_CRATE_VALUE * 5 // Not expensive but not the cheapest
	contains = list(/mob/living/carbon/human/species/protean/empty = 1)
	crate_name = "protean vessel"
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	crate_type = /obj/structure/closet/crate/secure/science/robo
