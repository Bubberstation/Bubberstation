/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/wt550
	name = "WT-550 Gun Case"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/wt550
	extra_to_spawn = /obj/item/ammo_box/magazine/wt550m9

/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/wt550/PopulateContents() // The gun and two extra mags
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/wt550m9 = 2,
	), src)
