//Cargo
/datum/export/weapon/sec_glock
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock)
	cost = CARGO_CRATE_VALUE * 1.25
	unit_name = "'Murphy' Service Pistol"

/datum/supply_pack/security/armory/sec_glock
	name = "'Murphy' Service Pistol Crate"
	desc = "Contains three 'Murphy' service pistols pre-loaded with lethal rounds. Additional ammo sold seperately. Nanotrasen reminds you that the other weapons are for friends, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock = 3)
	crate_name = "'Murphy' service pistol crate"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/security/armory/sec_glock_ammo
	name = "'Murphy' Service Pistol Ammo Crate"
	desc = "Contains 4 magazines with lethal rounds for the 'Murphy' service pistol."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/ammo_box/magazine/security = 4)
	crate_name = "'Murphy' service pistol ammo crate"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/security/armory/alert_level_firing_pin
	name = "Alert Level Firing Pin Crate"
	desc = "Contains four special firing pins that only allow firing on code blue or higher."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/firing_pin/alert_level = 4)
	crate_name = "alert level firing pin crate"
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/murphy_single
	name = "'Murphy' Service Pistol Single-Pack"
	desc = "A rugged, law-enforcement-grade service pistol, once famously sold for just a dollar. Comes as a single-pack with one 'Murphy' pistol ready for action."
	cost = PAYCHECK_COMMAND * 5
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock = 1)
	access_view = ACCESS_WEAPONS

/datum/supply_pack/goody/murphy_ammo
	name = "'Murphy' Service Pistol Magazine Single-Pack"
	desc = "Full magazine with an extra-robust ejection spring. Fits into the Murphy Service Pistol."
	cost = PAYCHECK_COMMAND * 2
	contains = list(/obj/item/ammo_box/magazine/security = 1)
	access_view = ACCESS_WEAPONS
