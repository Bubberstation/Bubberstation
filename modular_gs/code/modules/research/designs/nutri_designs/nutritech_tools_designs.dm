/datum/design/bluespace_belt
	name = "Bluespace Belt"
	desc = "A belt made using bluespace technology. The power of space and time, used to hide the fact you are fat."
	id = "bluespace_belt"
	build_type = PROTOLATHE
	construction_time = 100
	materials = list(/datum/material/silver = 200, /datum/material/gold = 200, /datum/material/bluespace = 100, )
	build_path = /obj/item/bluespace_belt
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/primitive_bluespace_belt
	name = "Primitive Bluespace Belt"
	desc = "A primitive belt made using bluespace technology. The power of space and time, used to hide the fact you are fat. This one requires cells to continue operating, and may suffer from random failures."
	id = "primitive_bluespace_belt"
	build_type = PROTOLATHE
	construction_time = 100
	materials = list(/datum/material/iron = 200, /datum/material/silver = 100, )
	build_path = /obj/item/bluespace_belt/primitive
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE