/////////////////////////////
/////Synth and IPC Organs////
/////////////////////////////

/datum/design/ipc_heart
	name = "IPC heart"
	desc = "Allows for the construction of an IPC heart."
	id = "ipc_heart"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/glass = 400, /datum/material/iron = 800, /datum/material/gold = 300)
	build_path = /obj/item/organ/heart/ipc
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/ipc_liver
	name = "IPC reagent processing liver"
	desc = "Allows for the construction of an IPC reagent processing liver."
	id = "ipc_liver"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/plasma = 100, /datum/material/iron = 800, /datum/material/glass = 300, /datum/material/silver = 500, /datum/material/gold = 400)
	build_path = /obj/item/organ/liver/ipc
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/ipc_ears
	name = "IPC auditory sensors"
	desc = "Allows for the construction of an IPC auditory sensors."
	id = "ipc_ears"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/gold = 400, /datum/material/iron = 800)
	build_path = /obj/item/organ/ears/ipc
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/ipc_tongue
	name = "IPC positronic voicebox"
	desc = "Allows for the construction of an IPC positronic voicebox."
	id = "ipc_tongue"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/gold = 400, /datum/material/iron = 800)
	build_path = /obj/item/organ/tongue/robot/ipc
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/ipc_eyes
	name = "IPC eyes"
	desc = "Allows for the construction of an IPC eyes."
	id = "ipc_eyes"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/glass = 500, /datum/material/iron = 800, /datum/material/glass = 300,)
	build_path = /obj/item/organ/eyes/ipc
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE
