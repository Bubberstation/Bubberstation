/datum/design/fatoray_weak
	name = "Basic Fatoray"
	id = "fatoray_weak"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 300, /datum/material/calorite = 500)
	construction_time = 75
	build_path = /obj/item/gun/energy/fatoray/weak
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

/datum/design/fatoray_cannon_weak
	name = "Basic Cannonshot Fatoray"
	id = "fatoray_cannon_weak"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 400, /datum/material/calorite = 1000)
	construction_time = 200
	build_path = /obj/item/gun/energy/fatoray/cannon_weak
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY