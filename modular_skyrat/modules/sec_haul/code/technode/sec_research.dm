/datum/design/s12c_fslug
	name = "Frangible slug(Destructive)"
	desc = "A 12 gauge slug intended for destroying airlocks"
	id = "s12c_fslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1, /datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_casing/shotgun/frangible
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//12 Gauge Ammunition Boxes
//This shit is a mistake but we embraced it instead of removing it, They all will require plastic to make alongside the iron cost
//I hate it

/datum/design/advancedgaugeboxes
	name = "12 Gauge Advanced Buckshot Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_buckshot"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/buckshot
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_incinslug
	name = "12 Gauge Advanced Incendiary Slug Ammunition Box(Very Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_incinslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/incendiary
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_beanbagslug
	name = "12 Gauge Advanced Bean Bag Ammunition Box(Less-Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_bslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/bean
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO

/datum/design/advancedgaugeboxes_rubbershot
	name = "12 Gauge Advanced Rubber Shot Ammunition Box(Less-Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/rubber
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO

/datum/design/advancedgaugeboxes_db
	name = "12 Gauge Advanced Dragons Breath Ammunition Box(Very Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_db"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,  /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 15 , /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/dragonsbreath
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_breaching
	name = "12 Gauge Advanced Frangible Slug Ammunition Box(Destructive)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_br"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,  /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 35 , /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/frangible
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_laser
	name = "12 Gauge Advanced Scatter Laser Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_laser"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 15, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/advanced/s12gauge/laser
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_hunting
	name = "12 Gauge Advanced Hunting Slug Ammunition Box(Less Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_huntingslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8)
	build_path = /obj/item/ammo_box/advanced/s12gauge/hunter
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_CARGO
