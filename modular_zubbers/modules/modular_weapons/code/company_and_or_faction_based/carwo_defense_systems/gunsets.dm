/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano
	extra_to_spawn = null

/obj/item/storage/toolbox/guncase/skyrat/carwo_large_case/sindano/PopulateContents()
	new weapon_to_spawn (src)

	generate_items_inside(list(
		/obj/item/ammo_box/c35sol/incapacitator = 1,
		/obj/item/ammo_box/c35sol = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 2,
	), src)