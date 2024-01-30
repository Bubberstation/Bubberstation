/area/station/solars/asteroid
	name = "\improper Asteroid Solar Array"
	icon_state = "panelsAF"
	area_flags = UNIQUE_AREA | EVENT_PROTECTED

/area/station/engineering/atmos/asteroid
	name = "\improper Asteroid Atmospherics Room"
	icon_state = "atmos"
	area_flags = UNIQUE_AREA | EVENT_PROTECTED

/area/station/engineering/asteroid_lobby
	name = "\improper Asteroid Lobby"
	icon_state = "engine_hallway"
	area_flags = UNIQUE_AREA | EVENT_PROTECTED

/area/station/engineering/supermatter/emitter
	name = "\improper Supermatter Emitter Room"
	icon_state = "engine_control"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/station/service/service_room
	name = "\improper Service Lathe"
	icon_state = "hall_service"


/area/station/engineering/storage/eva
	name = "\improper Engineering EVA Storage"
	icon_state = "eva"

/area/moonstation
	name = "DO NOT USE"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_AREA_ICEMOON
	ambient_buzz = 'sound/ambience/magma.ogg'

/area/moonstation/surface
	name = "Lunar Surface"
	icon_state = "explored"
	outdoors = TRUE
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/moonstation/surface/LateInitialize()

	//Lighting
	var/sunlight_freq = 6
	for(var/turf/lighting_turf in contents)
		if(lighting_turf.light)
			continue
		if(lighting_turf.x % sunlight_freq)
			continue
		var/bonus = !(lighting_turf.x % (sunlight_freq*2)) && sunlight_freq > 1 ? sunlight_freq*0.5 : 0
		if((lighting_turf.y+bonus) % sunlight_freq)
			continue
		lighting_turf.set_light(
			1 + sunlight_freq,
			1,
			"#724C2B"
		)

/area/moonstation/underground
	name = "Lunar Caves"
	outdoors = TRUE
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
