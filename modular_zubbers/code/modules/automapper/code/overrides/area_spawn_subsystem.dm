/datum/area_spawn/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station", "Effigy Rimpoint", "Effigy Sigma Octantis")
	. = ..()

/datum/area_spawn_over/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station", "Effigy Rimpoint", "Effigy Sigma Octantis")
	. = ..()
