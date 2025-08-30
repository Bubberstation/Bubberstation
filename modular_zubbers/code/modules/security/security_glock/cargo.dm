//Cargo
/datum/export/weapon/sec_glock
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock)
	cost = CARGO_CRATE_VALUE * 1.25
	unit_name = "'Murphy' Service Pistol"

/datum/supply_pack/security/armory/sec_glock
	name = "'Murphy' Service Pistol Crate"
	desc = "Contains a pair of 'Murphy' service pistols pre-loaded with lethal rounds. Additional ammo sold seperately. Nanotrasen reminds you that the other weapon is for a friend, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock = 2)
	crate_name = "'Murphy' service pistol crate"

/datum/supply_pack/security/armory/sec_glock_ammo
	name = "'Murphy' Service Pistol Ammo Crate"
	desc = "Contains 4 magazines with lethal rounds for the 'Murphy' service pistol."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/ammo_box/magazine/security = 4)
	crate_name = "'Murphy' service pistol ammo crate"

/datum/supply_pack/security/armory/alert_level_firing_pin
	name = "Alert Level Firing Pin Crate"
	desc = "Contains four special firing pins that only allow firing on code blue or higher."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/firing_pin/alert_level = 4)
	crate_name = "alert level firing pin crate"
