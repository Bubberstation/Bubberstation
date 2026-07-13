
/datum/supply_pack/imports/hoshi
	name = "Hoshi Modular Carbine crate"
	desc = "This crate includes a licenesed Hoshi Modular Carbine, one of the newest addition to the Terran's armories."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/gun/energy/modular_laser_rifle/carbine,
	)
	access_view = ACCESS_WEAPONS

datum/supply_pack/imports/rifle_collection
	name = "Relic Rifles Crate"
	desc = "This crate includes two rifles from Donk's line of reproduction firearms, all chambered in the reproducer's caliber of choice, .310. Produced by Donk for the discerning collector of antiquities."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(
		/obj/item/gun/ballistic/rifle/lionhunter/empty,
		/obj/item/gun/ballistic/rifle/boltaction/donkrifle/empty,
		/obj/item/gun/ballistic/rifle/sks,
		/obj/item/gun/ballistic/rifle/boltaction/surplus,
		/obj/item/gun/ballistic/rifle/boltaction,
		/obj/item/gun/ballistic/rifle/boltaction/prime,
	)

/datum/supply_pack/imports/rifle_collection/fill(obj/structure/closet/crate/our_crate)
	for(var/items in 1 to 2)
		var/item = pick(contains)
		new item(our_crate)
