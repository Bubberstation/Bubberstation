/datum/area_spawn/secmed_landmark
	target_areas = list(/area/station/security/medical, /area/station/security/brig)
	desired_atom = /obj/effect/landmark/start/security_medic

/datum/area_spawn/podspawn_colony_lathe
	target_areas = list(/area/ruin/powered/seedvault, /area/centcom/central_command_areas/supply)
	desired_atom = /obj/machinery/rnd/production/colony_lathe
	mode = AREA_SPAWN_MODE_HUG_WALL