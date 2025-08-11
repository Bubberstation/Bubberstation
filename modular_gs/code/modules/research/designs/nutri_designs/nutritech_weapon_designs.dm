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

/datum/design/alter_ray_metabolism
	name = "AL-T-Ray: Metabolism"
	id = "alter_ray_metabolism"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 400, /datum/material/calorite = 1300)
	construction_time = 200
	build_path = /obj/item/gun/energy/laser/alter_ray/gainrate
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY


/datum/design/alter_ray_reverser
	name = "AL-T-Ray: Reverser"
	id = "alter_ray_reverser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 400, /datum/material/calorite = 1300)
	construction_time = 200
	build_path = /obj/item/gun/energy/laser/alter_ray/noloss
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY


// /datum/design/borg_fatoray
// 	name = "Cyborg Upgrade (Fatoray)"
// 	id = "borg_upgrade_fatoray"
// 	build_type = MECHFAB
// 	build_path = /obj/item/borg/upgrade/fatoray
// 	materials = list(/datum/material/iron = 400, /datum/material/glass = 300, /datum/material/calorite = 500)
// 	construction_time = 100
// 	category = list(
// 		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SECURITY
// 	)

// /obj/item/borg/upgrade/fatoray
// 	name = "cyborg fatoray module"
// 	desc = "An extra module that allows cyborgs to use fatoray weapons."
// 	icon_state = "cyborg_upgrade3"

// /obj/item/borg/upgrade/fatoray/action(mob/living/silicon/robot/R, user = usr)
// 	. = ..()
// 	if(.)
// 		var/obj/item/gun/energy/fatoray/weak/cyborg/S = new(R.module)
// 		R.module.basic_modules += S
// 		R.module.add_module(S, FALSE, TRUE)

// /obj/item/borg/upgrade/fatoray/deactivate(mob/living/silicon/robot/R, user = usr)
// 	. = ..()
// 	if (.)
// 		var/obj/item/gun/energy/fatoray/weak/cyborg/S = locate() in R.module
// 		R.module.remove_module(S, TRUE)