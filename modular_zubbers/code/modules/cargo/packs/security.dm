/datum/supply_pack/security/armory/wt551
	name = "WT-551 Autorifle Crate"
	desc = "Contains a pair of WT-551 Autorifles pre-loaded with less-than-lethal rubber-tipped rounds. Additional ammo sold seperately. Backwards-compatible with WT-550 magazines. NanoTrasen reminds you that the other weapon is for a friend, and not for going guns akimbo."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/item/gun/ballistic/automatic/wt550/security/rubber = 2)
	crate_name = "wt-550 autorifle crate"

/datum/supply_pack/security/armory/wt550_ammo_rubber
	name = "WT-550/WT-551 Autorifle Ammo Crate (Rubber-Tipped)"
	desc = "Contains 3 magazines with less than lethal rubber-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/ammo_box/magazine/wt550m9/rubber = 3)
	crate_name = "wt-550 magazine crate (rubber-tipped)"

/datum/supply_pack/security/armory/wt550_ammo_flat
	name = "WT-550/WT-551 Autorifle Ammo Crate (Flat-Tipped)"
	desc = "Contains 3 magazines with lethal flat-tipped rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/ammo_box/magazine/wt550m9/flathead = 3)
	crate_name = "wt-550 magazine crate (flat-tipped)"

/datum/supply_pack/security/armory/wt550_ammo_regular
	name = "WT-550/WT-551 Autorifle Ammo Crate (Regular)"
	desc = "Contains 3 magazines with lethal regular rounds for the WT-551."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/ammo_box/magazine/wt550m9 = 3)
	crate_name = "wt-550 magazine crate (regular)"
