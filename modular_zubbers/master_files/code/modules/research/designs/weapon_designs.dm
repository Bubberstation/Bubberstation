/datum/design/wt550_ammo_rubber
	name = "WT-550/WT-551 Magazine (4.6x30mm Rubber-Tipped) (Less-Than_Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains less-than-lethal rubber-tipped ammo."
	id = "wt550_ammo_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6)
	build_path = /obj/item/ammo_box/magazine/wt550m9/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_flat
	name = "WT-550/WT-551 Magazine (4.6x30mm FlatHead) (Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains lethal surplus-tier flathead ammo."
	id = "wt550_ammo_flathead"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8)
	build_path = /obj/item/ammo_box/magazine/wt550m9/flathead
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo
	name = "WT-550/WT-551 Magazine (4.6x30mm Regular) (Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains lethal regular ammo."
	id = "wt550_ammo_normal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_ap
	name = "WT-550/WT-551 Magazine (4.6x30mm Armor-Piercing) (Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains lethal armor-piercing ammo. NanoTrasen prefers you didn't use these on your pressurized space station."
	id = "wt550_ammo_ap"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtap
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/wt550_ammo_incendiary
	name = "WT-550/WT-551 Magazine (4.6x30mm Incendiary) (Extremely Lethal)"
	desc = "A magazine for the WT-550/WT-551 Autorifle. Contains very lethal incendiary ammo. Consult your local laws for warcrime status before use."
	id = "wt550_ammo_incendiary"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2, /datum/material/silver = SHEET_MATERIAL_AMOUNT , /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtic
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
