/datum/design/kiboko_mag
	name = "Kiboko Grenade Magazine"
	desc = "A standard magazine for compatible grenade launcher."
	id = "solgrenade_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c980_grenade/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/kiboko_box_mag
	name = "Kiboko Grenade Box Magazine"
	desc = "An extended capacity box magazine for compatible grenade launcher."
	id = "solgrenade_extmag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
// 12 Gauge Shell.. Individually.
// Because People will kill me if they realised the scale of economic
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

/datum/design/advancedgaugeboxes_slug
	name = "12 Gauge Advanced Slug Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_slug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 25, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/advancedgaugeboxes_flech
	name = "12 Gauge Advanced Flechette Ammunition Box(Lethal)"
	desc = "A 12 gauge ammunition box for shotgun shells."
	id = "s12g_flechette"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 6, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 25)
	build_path = /obj/item/ammo_box/advanced/s12gauge/flechette
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

/datum/design/m9mm_mag
	name = "9x25mm Mk2 Pistol Magazine(Lethal)"
	desc = "A standard magazine for pistol using 9x25mm Mk2."
	id = "m9mm_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12)
	build_path = /obj/item/ammo_box/magazine/m9mm
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_sec
	name = "Magazine (9x25mm Murphy) (Lethal)"
	desc = "Designed to slide in and out of a 9mm 'Murphy' service pistol. It's heavier bullets make this magazine quite heavy, watch where you throw it!"
	id = "m9mm_sec"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/ammo_box/magazine/security
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_sec_rocket
	name = "Magazine (9x25mm Murphy RE) (Lethal)"
	desc = "A volatile magazine with extra weight and aerodynamic padding, letting it accelerate rapidly upon release - preferrably towards the suspect."
	id = "m9mm_sec_rocket"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/ammo_box/magazine/security/rocket
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m45_mag
	name = ".460 Ceres Pistol Magazine(Lethal)"
	desc = "A standard magazine for pistol using .460 Ceres."
	id = "m45_mag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
