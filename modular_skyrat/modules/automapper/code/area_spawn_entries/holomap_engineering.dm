/datum/area_spawn/holomap/engineering
	desired_atom = /obj/machinery/holomap/engineering

/datum/area_spawn/holomap/engineering/lobby
	target_areas = list(/area/station/engineering/lobby)
	amount_to_spawn = 2

/datum/area_spawn/holomap/engineering/main
	target_areas = list(/area/station/engineering/main)
	amount_to_spawn = 2 // It's a coinflip on if the lobby is free enough to place any, so.

/datum/area_spawn/holomap/engineering/ce
	target_areas = list(/area/station/command/heads_quarters/ce)

/datum/area_spawn/holomap/engineering/bridge
	target_areas = list(/area/station/command/bridge)
