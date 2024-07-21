/area/ocean
	name = "Ocean"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"
	requires_power = TRUE
	always_unpowered = TRUE
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	outdoors = TRUE
	ambience_index = AMBIENCE_SPACE
	flags_1 = CAN_BE_DIRTY_1
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_SPACE

/area/ocean/generated
	icon_state = "unexplored"
	map_generator = /datum/map_generator/ocean_generator

/area/ocean/trench
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	name = "The Trench"

/area/ocean/trench/generated
	icon_state = "unexplored"
	map_generator = /datum/map_generator/cave_generator/trench

/area/ruin/ocean
	has_gravity = TRUE
	area_flags = UNIQUE_AREA

/area/ruin/ocean/bioweapon_research
	name = "Syndicate Ocean Base"

/area/ruin/ocean/bubble
	name = "ISV Bubblehead"

/area/ruin/ocean/bubble/titanium
	name = "ISV Leave A Ship"
