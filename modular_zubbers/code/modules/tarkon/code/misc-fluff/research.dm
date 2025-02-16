///// Bubber added Tarkon Tech /////
/datum/design/tarkonpowerator
	name = "Tarkon Powerator"
	desc = "The circuit board for a machine that can sell power."
	id = "powerator_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/powerator/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tarkonexpressconsole
	name = "Tarkon Express Cargo Console"
	desc = "The circuit board for a computer used to purchase goods."
	id = "cargoconsole_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/computer/cargo/express/interdyne/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bountypad
	name = "Tarkon Bounty Pad"
	desc = "The circuit board for a machine used to sell goods."
	id = "bountypad_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/machine/syndiepad/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bountypadconsole
	name = "Tarkon Express Cargo Console"
	desc = "The circuit board for the Ta used to sell goods."
	id = "bountyconsole_tarkon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1)
	build_path = /obj/item/circuitboard/computer/syndiepad/tarkon
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
