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

/datum/design/civilian_hud
	name = "Civilian HUD"
	desc = "A heads-up display that scans the humanoids around you and displays their ID status. Experts say this has well over 9000 uses."
	id = "civ_hud"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/glasses/hud/civilian
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cyberimp_civ_hud
	name = "Civilian HUD Implant"
	desc = "These cybernetic eyes will display a civilian HUD over everything you see. Wiggle eyes to control."
	id = "ci-civhud"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 5 SECONDS
	//just about half the materials of a sechudimplant but no silver
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*3,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/organ/cyberimp/eyes/hud/civilian
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/umbrella
	name = "Umbrella"
	id = "umbrella"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.75, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.25)
	build_path = /obj/item/umbrella
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
