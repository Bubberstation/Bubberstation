
/datum/supply_pack/imports/hoshi
	name = "Hoshi Modular Carbine crate"
	desc = "This crate includes a licenesed Hoshi Modular Carbine, one of the newest addition to the Terran's armories."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/gun/energy/modular_laser_rifle/carbine,
	)
	access_view = ACCESS_WEAPONS

/datum/supply_pack/imports/jezail
	name = "Relic Jezail Single-Order"
	desc = "This crate includes a rifle from Donk's line of reproduction firearms, all chambered in the reproducer's caliber of choice, .310. Produced by Donk alongside Sahko for the discerning collector of antiquities."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/gun/ballistic/rifle/boltaction/donkrifle/empty)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "relic rifle crate"

/datum/supply_pack/imports/hunter_rifle
	name = "Relic Hunting Rifle Single-Order"
	desc = "This crate includes a rifle from Donk's line of reproduction firearms, all chambered in the reproducer's caliber of choice, .310. Produced by Donk alongside Sahko for the discerning collector of antiquities. This one seems a little... Off. "
	cost = CARGO_CRATE_VALUE * 14
	contains = list(/obj/item/gun/ballistic/rifle/boltaction/lionhunterlarp)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "relic rifle crate"

/datum/supply_pack/imports/prime_rifle
	name = "Modernized Bolt-Action Rifle Single-Order"
	desc = "This crate includes a rifle from Donk's line of reproduction firearms, all chambered in the reproducer's caliber of choice, .310. Produced by Donk alongside Sahko for the discerning collector of antiquities."
	cost = CARGO_CRATE_VALUE * 17
	contains = list(/obj/item/gun/ballistic/rifle/boltaction/prime)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "relic rifle crate"

/datum/supply_pack/imports/bolt_action
	name = "Bolt-Action Rifle Single-Order"
	desc = "This crate includes a rifle from Donk's line of reproduction firearms, all chambered in the reproducer's caliber of choice, .310. Produced by Donk alongside Sahko for the discerning collector of antiquities."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/gun/ballistic/rifle/boltaction)
	access_view = ACCESS_WEAPONS
	crate_type = /obj/structure/closet/crate/secure/plasma
	crate_name = "relic rifle crate"

/datum/supply_pack/imports/riflecrate
	name = "Lanca Battle Rifle Single-Order"
	desc = "Need some more reliable firepower than the standard Sakhno? Look no further than these bad boys. Featuring a more modern semi-automatic action, these bad babies will be sure to make anyone regret messing with you. Don't mind the fees..."
	cost = 2500
	contains = list(
		/obj/item/gun/ballistic/automatic/lanca,
		/obj/item/ammo_box/magazine/lanca,
		/obj/item/ammo_box/magazine/lanca,
	)
	crate_type = /obj/structure/closet/crate/secure/weapon
	crate_name = "Battle Rifle Crate"
	access_view = ACCESS_WEAPONS
