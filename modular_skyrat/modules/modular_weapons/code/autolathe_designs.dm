/*
*	AMMO
*/

// 4.6x30mm - SMG round, used in the WT550 and in numerous modular guns as a weaker alternative to 9mm.

/datum/design/c46x30mm
	name = "4.6x30mm Bullet"
	id = "c46x30mm"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5,
	)
	build_path = /obj/item/ammo_casing/c46x30mm
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

// .45

/datum/design/c45_lethal
	name = ".45 Bullet"
	id = "c45_lethal"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5,
	)
	build_path = /obj/item/ammo_casing/c45
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
