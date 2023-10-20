/datum/area_spawn/redsec_vendor //Its back and cannot be stopped baybeeeeee :crab:
	target_areas = list(/area/station/security/lockers, /area/station/security/office)
	desired_atom = /obj/machinery/vending/wardrobe/sec_wardrobe/red
	mode = AREA_SPAWN_MODE_HUG_WALL
	blacklisted_stations = list("Runtime Station", "MultiZ Debug", "Gateway Test") //so it spawns on void, burger, etc
