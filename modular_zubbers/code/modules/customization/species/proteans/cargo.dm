/datum/supply_pack/science/protean_organs
	name = "Protean Parts"
	desc = "Contains two sets of organs for Protean crewmembers, alongside a blank body, the refactory on its last legs, long enough to place the core in the vessel, but will quickly deteriorate as soon as the core goes inside."
	cost = CARGO_CRATE_VALUE * 10 // Not cheap
	contains = list(/obj/item/organ/stomach/protean = 2, /obj/item/organ/heart/protean = 2, /mob/living/carbon/human/species/protean/empty = 1)
	crate_name = "protean parts"
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	crate_type = /obj/structure/closet/crate/secure/science/robo
