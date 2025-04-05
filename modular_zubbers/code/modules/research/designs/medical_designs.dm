/datum/design/empathic_sensor
	name = "Empathic sensor implant"
	desc = "An implant which allows one to intuit the thoughts of some."
	id = "ci_empathic_sensor"
	build_type = PROTOLATHE | MECHFAB
	materials = list(
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
	/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
	/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,)
	build_path = /obj/item/organ/cyberimp/brain/empathic_sensor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE


/datum/design/medical_constructor
	name = "Medical RCD Body Constructor"
	id = "medical_rcd"
	build_type = PROTOLATHE
	build_path = /obj/item/construction/rcd // change
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 20)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
