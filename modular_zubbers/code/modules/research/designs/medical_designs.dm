/datum/design/crewmonitor
	name = "Handheld crew monitor"
	desc = "A miniature machine that tracks suit sensors across the station."
	id = "crewmonitor"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/sensor_device
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

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
