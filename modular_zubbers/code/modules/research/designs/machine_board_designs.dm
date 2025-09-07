/datum/design/board/plantgenes
	name = "Plant Gene Editor Board"
	desc = "The circuit board for a plant gene editing machine."
	id = "plantgene"
	build_path = /obj/item/circuitboard/machine/plantgenes
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/mechpad
	name = "Mecha Orbital Pad Board"
	desc = "The circuit board for a mecha orbital pad."
	id = "mechlauncher_pad"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/mechpad
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
