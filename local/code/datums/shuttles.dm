/// RIMPOINT ///

/datum/map_template/shuttle/arrival/rimpoint
	prefix = "_maps/effigy/shuttles/"
	suffix = "rimpoint"
	name = "arrival shuttle (RimPoint)"

/datum/map_template/shuttle/emergency/rimpoint
	prefix = "_maps/effigy/shuttles/"
	suffix = "rimpoint"
	name = "RimPoint Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 10
	description = "A middling-sized evacuation shuttle, with an individualized floorplan for each department."
	admin_notes = "Center room is as wide as Cere's shuttle and very, VERY comically easy for lasers to dominate in. Otherwise a standard fare shuttle as far as equipment's concerned."
	occupancy_limit = "50"

/// SIGMA OCTANTIS ///

/datum/map_template/shuttle/arrival/sigma_octantis
	prefix = "_maps/effigy/shuttles/"
	suffix = "sigmaoctantis"
	name = "arrival shuttle (Sigma Octantis)"

/datum/map_template/shuttle/emergency/sigma_octantis
	prefix = "_maps/effigy/shuttles/"
	suffix = "sigmaoctantis"
	name = "Sigma Octantis Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "A cramped emergency shuttle; specialized for handling flooded stations with an onboard drainage system."
	admin_notes = "Centre is dedicated to dealing with a flood - it will be pretty useless in other scenarios."
	occupancy_limit = "30"
