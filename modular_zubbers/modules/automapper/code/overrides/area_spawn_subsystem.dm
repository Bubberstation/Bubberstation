/datum/area_spawn/New()
	blacklisted_stations |= list("Lima Station", "Burgerstation")
	. = ..()

/datum/area_spawn_over/New()
	blacklisted_stations |= list("Lima Station", "Burgerstation")
	. = ..()
