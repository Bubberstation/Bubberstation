/datum/design/nanite_disk
	name = "Nanite Program Disk"
	desc = "Stores nanite programs."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 300, /datum/material/glass = 100)
	build_path = /obj/item/disk/nanite_program
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_chamber_control
	name = "Computer Design (Nanite Chamber Control)"
	desc = "Allows for the construction of circuit boards used to build a new nanite chamber control console."
	build_path = /obj/item/circuitboard/computer/nanite_chamber_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_cloud_control
	name = "Computer Design (Nanite Cloud Control)"
	desc = "Allows for the construction of circuit boards used to build a new nanite cloud control console."
	build_path = /obj/item/circuitboard/computer/nanite_cloud_controller
	category = list("Computer Boards")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_chamber
	name = "Machine Design (Nanite Chamber Board)"
	desc = "The circuit board for a Nanite Chamber."
	build_path = /obj/item/circuitboard/machine/nanite_chamber
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/public_nanite_chamber
	name = "Machine Design (Public Nanite Chamber Board)"
	desc = "The circuit board for a Public Nanite Chamber."
	build_path = /obj/item/circuitboard/machine/public_nanite_chamber
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_programmer
	name = "Machine Design (Nanite Programmer Board)"
	desc = "The circuit board for a Nanite Programmer."
	build_path = /obj/item/circuitboard/machine/nanite_programmer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nanite_program_hub
	name = "Machine Design (Nanite Program Hub Board)"
	desc = "The circuit board for a Nanite Program Hub."
	build_path = /obj/item/circuitboard/machine/nanite_program_hub
	category = list("Research Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

///////////////////////////////////
//////////Nanite Devices///////////
///////////////////////////////////
/datum/design/nanite_remote
	name = "Nanite Remote"
	desc = "Allows for the construction of a nanite remote."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_remote
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/nanite_comm_remote
	name = "Nanite Communication Remote"
	desc = "Allows for the construction of a nanite communication remote."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_remote/comm
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/nanite_scanner
	name = "Nanite Scanner"
	desc = "Allows for the construction of a nanite scanner."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_scanner
	category = list("Electronics")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

