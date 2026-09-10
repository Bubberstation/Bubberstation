/datum/supply_pack/misc/americacrate
	name = "Freedom Crate"
	desc = "FREEDOM. FREEDOM. FREEDOM. Freedom aint not free. Buy our flags, pray to the flag, worship the flag. Dress up as the founder and kneel at the alter of the flag that created everything. Guns sold seperately."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/sign/flag/usa,
		/obj/item/sign/flag/usa,
		/obj/item/food/burger/superbite,
		/obj/item/bedsheet/patriot,
		/obj/item/bedsheet/patriot/double,
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/superbite,
		/obj/item/clothing/under/costume/griffin,
		/obj/item/clothing/head/costume/griffin,
	)
	crate_name = "patriotic crate"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/lizardgoodscrate
	name = "Lizard Goods Crate"
	desc = "Limited edition Lizard Goods Crate! Contains a random assortment of your FAVOURITE lizard related items, including the coveted 'weh-nade'"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/effect/spawner/random/lizard_crate = 8
	)
	crate_name = "lizard goods crate"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/antimatcrate
	name = "Wylom Anti-Material Rifle Crate"
	desc = "Do you have a hard target that you need dead? That ion gun not stopping the bad guy with a mech? Buy this to aquire a singular Wylom, with two spare magazines."
	cost = 7500
	contains = list(
		/obj/item/gun/ballistic/automatic/wylom,
		/obj/item/ammo_box/magazine/wylom,
		/obj/item/ammo_box/magazine/wylom,
	)
	crate_name = "AMR Crate"
	order_flags = ORDER_CONTRABAND

/datum/supply_pack/imports/riflecrate
	name = "Lanca Battle Rifle Crate"
	desc = "Need some more reliable firepower than the standard Sakhno? Look no further than these bad boys. Featuring a more modern semi-automatic action, these bad babies will be sure to make anyone regret messing with you. Don't mind the fees..."
	cost = 2500
	contains = list(
		/obj/item/gun/ballistic/automatic/lanca,
		/obj/item/ammo_box/magazine/lanca,
		/obj/item/ammo_box/magazine/lanca,
	)
	crate_name = "Battle Rifle Crate"
	order_flags = ORDER_CONTRABAND
