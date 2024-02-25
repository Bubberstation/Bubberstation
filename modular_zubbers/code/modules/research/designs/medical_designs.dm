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
