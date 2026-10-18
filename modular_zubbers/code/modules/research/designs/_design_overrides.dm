// This removes AI - Cyborg upload and AI core boards from ghost roles.

/datum/design/board/aicore
	name = "AI Core"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/aicore

/datum/design/board/aiupload
	name = "AI Upload"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/aiupload

/datum/design/board/borgupload
	name = "Borg Upload"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/borgupload

// NT and offstation mining Vendor separation

/datum/design/board/mining_equipment_vendor
	name = "Mining Equipment Vendor"
	build_type = IMPRINTER

/datum/design/crowbar/New()
	. = ..()
	build_type |= COLONY_FABRICATOR
