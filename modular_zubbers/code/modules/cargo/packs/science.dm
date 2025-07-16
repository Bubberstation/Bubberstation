/datum/supply_pack/science/mechthermal
	name = "Heavy Thermal Guns Crate"
	desc = "Contains two experimental thermal cannons for use by mechs. \
		When used simultaneously, their excess power used to heat and cool the opposing weapon, \
		increasing the reload speed."
	access = ACCESS_ROBOTICS
	access_view = ACCESS_ROBOTICS
	cost = CARGO_CRATE_VALUE * 25
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/thermal/cryo,
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/thermal/inferno,
	)
	crate_name = "thermal cannons crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
