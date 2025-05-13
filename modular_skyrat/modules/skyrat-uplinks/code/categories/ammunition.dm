/datum/uplink_item/ammo/revolver_emp
	name = ".357 Haywire+ (EMP) speedloader"
	desc = "A speed loader that contains seven additional .357 Magnum Haywire+ rounds; usable with the Syndicate revolver. \
		For when you really need a lot of things dead and batteries drained."
	item = /obj/item/ammo_box/a357/haywire
	cost = 5
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)
