/datum/area_spawn/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station")
	. = ..()

/datum/area_spawn_over/New()
	blacklisted_stations |= list("Lima Station", "Moon Station", "Box Station")
	. = ..()
