/datum/techweb_node/exp_tools/New()
	. = ..()
	// if this datum is ever instantiated twice, somehow, this is more efficient. i feel like an idiot writing this
	var/static/list/science_tools = list(
		/datum/design/jawsoflife/science,
		/datum/design/handdrill/science,
		/datum/design/rcd_loaded/robotics_rcd,
	)
	unlocked_designs += science_tools

