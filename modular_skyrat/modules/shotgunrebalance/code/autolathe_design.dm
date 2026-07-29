//12 Gauge
/datum/design/shotgun_slug
	name = "Shotgun Slug"
	id = "shotgun_slug"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/ammo_casing/shotgun
	category = list(
		RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

/datum/design/buckshot_shell
	name = "Buckshot Shell"
	id = "buckshot_shell"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list(
		RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

//Existing Designs Discounting

/datum/design/rubbershot
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)

/datum/design/rubbershot/sec
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)

/datum/design/beanbag_slug
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)

/datum/design/beanbag_slug/sec
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)

/datum/design/shotgun_dart
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)

/datum/design/shotgun_dart/sec
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)

/datum/design/incendiary_slug
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)

/datum/design/incendiary_slug/sec
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
