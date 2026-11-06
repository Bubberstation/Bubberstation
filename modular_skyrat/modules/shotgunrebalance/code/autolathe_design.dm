//12 Gauge
/datum/design/shotgun_slug
	name = "Shotgun Slug"
	build_type = AUTOLATHE
	materials = AMMO_MATS_SHOTGUN
	build_path = /obj/item/ammo_casing/shotgun
	category = list(
		RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

/datum/design/buckshot_shell
	name = "Buckshot Shell"
	build_type = AUTOLATHE
	materials = AMMO_MATS_SHOTGUN
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list(
		RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

