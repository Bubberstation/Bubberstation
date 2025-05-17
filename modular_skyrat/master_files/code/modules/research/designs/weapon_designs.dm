/datum/design/c38_haywire
	name = "Speed Loader (.38 Haywire) (Lethal)"
	desc = "Designed to quickly reload revolvers. Haywire bullets create small electromagnetic pulses on impact; devastating against electronics."
	id = "c38_haywire"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/ammo_box/c38/haywire
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/c38_haywire_mag
	name = "Magazine (.38 Haywire) (Lethal)"
	desc = "Designed to tactically reload a NT BR-38 Battle Rifle. Haywire bullets create small electromagnetic pulses on impact; devastating against electronics."
	id = "c38_haywire_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 9,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/ammo_box/magazine/m38/haywire
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
