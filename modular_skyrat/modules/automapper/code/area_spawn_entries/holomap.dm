/datum/area_spawn/holomap
	desired_atom = /obj/machinery/holomap
	mode = AREA_SPAWN_MODE_MOUNT_WALL
	optional = TRUE // The problem is most areas can just not exist on many maps. It's really fucking annoying. Also sometimes some rooms are already crammed with shit.

/datum/area_spawn/holomap/arrivals
	target_areas = list(/area/station/hallway/secondary/entry)
	amount_to_spawn = 2

/datum/area_spawn/holomap/bar
	target_areas = list(/area/station/commons/lounge)

/datum/area_spawn/holomap/cafe
	target_areas = list(/area/station/service/cafeteria)

/datum/area_spawn/holomap/security
	target_areas = list(/area/station/security/brig)

/datum/area_spawn/holomap/security_upper
	target_areas = list(/area/station/security/brig/upper)

/datum/area_spawn/holomap/science
	target_areas = list(/area/station/science)

/datum/area_spawn/holomap/central_hall
	target_areas = list(/area/station/hallway/primary/central)
	amount_to_spawn = 4

/datum/area_spawn/holomap/cargo
	target_areas = list(/area/station/cargo/lobby)

/datum/area_spawn/holomap/medbay
	target_areas = list(/area/station/medical/medbay/lobby)

/datum/area_spawn/holomap/medbay_paramed
	target_areas = list(/area/station/medical/paramedic)

/datum/area_spawn/holomap/mine_lounge
	target_areas = list(/area/mine/lounge)

/datum/area_spawn/holomap/mine_mining
	target_areas = list(/area/mine/production)
