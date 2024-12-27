/datum/design/diskplantgene
	name = "Plant Data Disk"
	desc = "A disk for storing plant genetic data."
	id = "diskplantgene"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=200, /datum/material/glass = 100)
	build_path = /obj/item/disk/plantgene
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/nitrogen_tank
	name = "Nitrogen Tank"
	desc = "An empty nitrogen tank."
	id = "nitrogen_tank"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/nitrogen/empty
	category = list(RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO
	
/* Uncomment in case nitrogen internal tanks get refactored to no longer be 25L
* /datum/design/nitrogen_tank_belt
*	name = "Nitrogen Internals Tank"
*	desc = "An empty nitrogen tank."
*	id = "nitrogen_tank_belt"
*	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
*	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
*	build_path = /obj/item/tank/internals/nitrogen/belt/empty
*	category = list(RND_CATEGORY_INITIAL,
*		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
*	)
*	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO
*/

/datum/design/anesthetic_tank
	name = "Anesthetic Tank"
	desc = "An empty tank designed specifically for use with anesthetics."
	id = "anesthetic_tank"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/tank/internals/anesthetic/empty
	category = list(RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL
