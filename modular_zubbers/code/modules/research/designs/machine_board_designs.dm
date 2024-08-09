/datum/design/board/plantgenes
	name = "Plant Gene Editor Board"
	desc = "The circuit board for a plant gene editing machine."
	id = "plantgene"
	build_path = /obj/item/circuitboard/machine/plantgenes
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/export_gate
	name = "Export Gate Board"
	desc = "The circuit board for an export gate."
	id = "export_gate"
	build_path = /obj/item/circuitboard/machine/export_gate
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO
