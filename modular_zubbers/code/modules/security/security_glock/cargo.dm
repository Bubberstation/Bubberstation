//Cargo
/datum/export/weapon/sec_glock
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock)
	cost = CARGO_CRATE_VALUE * 1.25
	unit_name = "C-CK 9x25mm pistol"

/datum/supply_pack/security/armory/sec_glock
	name = "C-CK 9x25mm Crate"
	desc = "Contains a pair of C-CK 9x25mm pistols pre-loaded with less-than-lethal rubber-tipped rounds. Additional ammo sold seperately. NanoTrasen reminds you that the other weapon is for a friend, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sec_glock/security/rubber = 2)
	crate_name = "C-CK 9x25mm crate"

/datum/supply_pack/security/armory/sec_glock_ammo_rubber
	name = "C-CK 9x25mm Ammo Crate (Rubber-Tipped)"
	desc = "Contains 4 magazines with less-than-lethal rubber-tipped rounds for the C-CK 9x25mm."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/ammo_box/magazine/m9mm/rubber = 4)
	crate_name = "C-CK 9x25mm ammo crate (rubber-tipped)"

/datum/supply_pack/security/armory/sec_glock_ammo_flat
	name = "C-CK 9x25mm Ammo Crate (Flat-Tipped)"
	desc = "Contains 4 magazines with lethal flat-tipped rounds for the C-CK 9x25mm."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/ammo_box/magazine/m9mm/flathead = 4)
	crate_name = "C-CK 9x25mm ammo crate (flat-tipped)"

/datum/supply_pack/security/armory/sec_glock_ammo_regular
	name = "C-CK 9x25mm Ammo Crate (Regular)"
	desc = "Contains 4 magazines with lethal rounds for the C-CK 9x25mm."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/ammo_box/magazine/m9mm = 4)
	crate_name = "C-CK 9x25mm ammo crate (regular)"

/datum/supply_pack/security/armory/alert_level_firing_pin
	name = "Alert Level Firing Pin Crate"
	desc = "Contains four special firing pins that only allow firing on code blue or higher."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/firing_pin/alert_level = 4)
	crate_name = "alert level firing pin crate"

