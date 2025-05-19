/datum/design/m9mm_sec
	name = "Magazine (9x25mm Security) (Lethal)"
	desc = "Designed to slide in and out of a 9mm 'Murphy' service pistol. It's heavier bullets make this magazine quite heavy, watch where you throw it!"
	id = "m9mm_sec"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/ammo_box/magazine/m9mm/security
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/m9mm_sec_rocket
	name = "Magazine (9x25mm Security RE) (Lethal)"
	desc = "A volatile magazine with extra weight and aerodynamic padding, letting it accelerate rapidly upon release - preferrably towards the suspect."
	id = "m9mm_sec_rocket"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/ammo_box/magazine/m9mm/security/rocket
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
