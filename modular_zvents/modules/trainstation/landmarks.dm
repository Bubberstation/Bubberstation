/obj/effect/landmark/trainstation
	icon_state = "tdome_admin"
	flags_1 = NO_TURF_MOVEMENT_1

/obj/effect/landmark/trainstation/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STATION_UNLOAD, INNATE_TRAIT)

// Используетя для создания окрестности станции над рельсами путей
/obj/effect/landmark/trainstation/nearstation_spawnpoint
	name = "Near station placer"

// Используется для создания станций, под рельсами путей
/obj/effect/landmark/trainstation/station_spawnpoint
	name = "Station Placer"

/obj/effect/landmark/trainstation/nearstation_spawnpoint
	name = "Nearstation Placer"


/obj/effect/landmark/trainstation/train_spawnpoint
	name = "Train Placer"

/obj/effect/landmark/trainstation/crew_spawnpoint
	name = "Crew Placer"

/obj/effect/landmark/trainstation/raider_spawnpoint
	name = "Raider spawner"

/turf/closed/indestructible/train_border
	name = "Iced rock"
	icon_state = "icerock"

/datum/map_template/train
	name = "Train Template"
	width = 200
	height = 13
	mappath = "_maps/modular_events/trainstation/train_general.dmm"
