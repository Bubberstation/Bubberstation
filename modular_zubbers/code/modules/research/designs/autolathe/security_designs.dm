/datum/design/c9mm_sec
	name = "Ammo Box (9x19m Murphy) (Lethal)" //SKYRAT EDIT: Calibre rename - Original: name = "Ammo Box (9mm)"
	id = "c9mm_sec"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 150)
	build_path = /obj/item/ammo_box/c9mm/security
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

