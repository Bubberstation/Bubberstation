/datum/design/jawsoflife/science
	name = "Hybrid cutters"
	desc = "An off-shoot of the jaws of life that lacks the door-opening power"
	id = SCIENCE_JAWS_OF_LIFE_DESIGN_ID // added one more requirement since the Jaws of Life are a bit OP
	build_path = /obj/item/crowbar/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science
	id = SCIENCE_DRILL_DESIGN_ID
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/screwdriver/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/rcd_loaded/robotics_rcd
	name = "Robotics RCD"
	desc = "A modified RCD that has less storage than your usual NT RCD is and has less construction options and has lost the ability to deconstruct in favor of being more accessible for synthetic repairs. Reload using metal, glass, or plasteel."
	id = SCIENCE_ROBORCD_DESIGN_ID
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/construction/rcd/robotics_rcd
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science/New()
	name = ("Science " + name)
	desc += " with a science paintjob"

	return ..()
