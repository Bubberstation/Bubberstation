/datum/design/glock9mm_ammo_rubber
	name = "C-CK Magazine (9x25mm Rubber-Tipped) (Less-Than-Lethal)"
	desc = "A magazine for the C-CK 9x25mm Pistol. Contains less-than-lethal rubber-tipped ammo."
	id = "glock9mm_ammo_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)
	build_path =  /obj/item/ammo_box/magazine/m9mm/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/glock9mm_ammo_flat
	name = "C-CK Magazine (9x25mm FlatHead) (Lethal)"
	desc = "A magazine for the C-CK 9x25mm Pistol. Contains lethal surplus-tier flathead ammo."
	id = "glock9mm_ammo_flathead"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)
	build_path = /obj/item/ammo_box/magazine/m9mm/flathead
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/glock9mm_ammo
	name = "C-CK Magazine (9x25mm Regular) (Lethal)"
	desc = "A magazine for the C-CK 9x25mm Pistol. Contains lethal regular ammo."
	id = "glock9mm_ammo_normal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/m9mm
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/techweb_node/weaponry/New()
	design_ids += "glock9mm_ammo_rubber"
	design_ids += "glock9mm_ammo_flathead"
	. = ..()

/datum/techweb_node/adv_weaponry/New()
	design_ids += "glock9mm_ammo_normal"
	. = ..()
