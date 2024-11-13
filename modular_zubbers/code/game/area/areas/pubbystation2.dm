/area/jungleplanet
	name = "DO NOT USE"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/earth_rumble/earth_rumble_distant1.ogg'
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	outdoors = TRUE

/area/jungleplanet/surface
	name = "jungle planet surface"
	static_lighting = FALSE
	base_lighting_alpha = 255
	map_generator = /datum/map_generator/jungle_generator

/area/jungleplanet/nearstation
	name = "jungle planet surface"
	static_lighting = FALSE
	base_lighting_alpha = 255
	map_generator = /datum/map_generator/nearstation_jungle_generator
