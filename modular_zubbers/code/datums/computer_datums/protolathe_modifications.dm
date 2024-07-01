// This removes AI - Cyborg upload and AI core boards from ghost roles. //Leave a little message here every time you have to remove a machine from ghost roles. --Moffington

/datum/design/board/aicore
	build_type = IMPRINTER

/datum/design/board/aiupload
	build_type = IMPRINTER

/datum/design/board/borgupload
	build_type = IMPRINTER

/datum/design/board/brm
	build_type = IMPRINTER
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE //Adds Science so the Science imprinter can make it
// NT and offstation mining Vendor separation

/datum/design/board/mining_equipment_vendor
	build_type = IMPRINTER

/datum/design/board/interdyne_mining_equipment_vendor
	name = "Offstation Mining Rewards Vendor Board"
	desc = "The circuit board for a offstation Mining Rewards Vendor."
	id = "interdyne_mining_equipment_vendor"
	build_type = AWAY_IMPRINTER
	build_path = /obj/item/circuitboard/computer/order_console/mining/interdyne
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
