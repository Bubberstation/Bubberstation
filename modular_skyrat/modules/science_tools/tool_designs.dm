/datum/design/jawsoflife/science
	name = "Hybrid cutters"
	desc = "An off-shoot of the jaws of life that lacks the door-opening power"
	build_path = /obj/item/crowbar/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/rcd_loaded/robotics_rcd
	name = "Robotics RCD"
	desc = "A modified RCD that has less storage than your usual NT RCD is and has less construction options and has lost the ability to deconstruct in favor of being more accessible for synthetic repairs. Reload using metal, glass, or plasteel."
	build_type = PROTOLATHE | AWAY_LATHE
	transfered_materials = list(
		/obj/item/construction/rcd/robotics_rcd = /obj/item/construction/rcd/robotics_rcd::custom_materials, //The RCD has less materials than what's used, as some is converted to charge/matter
	)
	build_path = /obj/item/construction/rcd/robotics_rcd
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science/New()
	name = ("Science " + name)
	desc += " with a science paintjob"

	return ..()
