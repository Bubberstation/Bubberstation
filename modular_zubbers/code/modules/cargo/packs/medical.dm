/datum/supply_pack/medical/kinetics
	name = "Kinetic Prosthetic Limbs Crate"
	desc = "Contains two sets of four kinetic prosthetic limbs to provide a \
		simpler alternative to advanced prosthetics."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/bodypart/arm/left/kinetic = 2,
		/obj/item/bodypart/arm/right/kinetic = 2,
		/obj/item/bodypart/leg/left/kinetic = 2,
		/obj/item/bodypart/leg/right/kinetic = 2,
	)
	crate_name = "kinetics crate"
	crate_type = /obj/structure/closet/crate/medical

/datum/supply_pack/medical/grimoire
	name = "Healing Grimoire Crate"
	desc = "Countain a singular volume on basic healing incantation"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/gun/magic/healing_grimoire = 1,
	)
	crate_name = "grimoire crate"
	crate_type = /obj/structure/closet/crate/medical
