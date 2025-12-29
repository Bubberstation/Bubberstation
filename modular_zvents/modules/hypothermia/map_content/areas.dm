// Defines
#define AREA_TEMPERATURE_DECREASE 0.5

// Fullscreen effects for temperature
/atom/movable/screen/fullscreen/temperature_cold
	icon = 'modular_zvents/icons/fullscreen/fullscreen_effects.dmi'
	icon_state = "cold"
	blend_mode = BLEND_ADD
	show_when_dead = TRUE

/atom/movable/screen/fullscreen/temperature_warm
	icon = 'modular_zvents/icons/fullscreen/fullscreen_effects.dmi'
	icon_state = "warm"
	blend_mode = BLEND_ADD
	show_when_dead = TRUE

// Hypothermia area
/area/hypothermia
	icon = 'icons/area/areas_away_missions.dmi'
	var/area_temperature = T0C
	var/area_min_temperature = TM15C
	var/list/heat_sources = list()
	var/datum/weather/affected_weather = null

/area/hypothermia/Initialize(mapload)
	. = ..()
	area_temperature = area_min_temperature
	START_PROCESSING(SSobj, src)

/area/hypothermia/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/area/hypothermia/proc/get_affected_weather()
	if(!length(SSweather.processing))
		return null
	for(var/datum/weather/active_weather in SSweather.processing)
		if(src in active_weather.impacted_areas)
			return active_weather

/area/hypothermia/proc/get_volume()
	// Volume in m^3, assuming 3 m^3 per turf
	return areasize * 3

/area/hypothermia/proc/adjust_temperature_scaled(delta_temp, target_temperature)
	if(area_temperature >= target_temperature)
		return // No change if at or above target
	area_temperature = min(target_temperature, area_temperature + delta_temp)
	update_visual()

/area/hypothermia/proc/decrease_temperature_scaled(delta_temp, target_temperature)
	if(area_temperature <= target_temperature)
		return // No change if at or below target
	area_temperature = max(target_temperature, area_temperature - delta_temp)
	update_visual()

/area/hypothermia/proc/set_temperature(new_temperature)
	if(new_temperature == area_temperature)
		return
	area_temperature = clamp(new_temperature, area_min_temperature, T20C + 100)
	update_visual()

/area/hypothermia/proc/update_visual()
	for(var/mob/living/L in contents)
		update_mob_visual(L)

/area/hypothermia/proc/update_mob_visual(mob/living/L)
	if(!L.client || !L.hud_used)
		return
	var/atom/movable/screen/current_cold = L.screens["temperature_cold"]
	var/atom/movable/screen/current_warm = L.screens["temperature_warm"]
	if(area_temperature <= T0C)
		if(!current_cold)
			L.clear_fullscreen("temperature_warm", animated = 1 SECONDS)
			L.overlay_fullscreen("temperature_cold", /atom/movable/screen/fullscreen/temperature_cold)
	else if(area_temperature > T0C)
		if(!current_warm)
			L.clear_fullscreen("temperature_cold", animated = 1 SECONDS)
			L.overlay_fullscreen("temperature_warm", /atom/movable/screen/fullscreen/temperature_warm)
	else
		if(current_cold || current_warm)
			L.clear_fullscreen("temperature_cold", animated = 1 SECONDS)
			L.clear_fullscreen("temperature_warm")

/area/hypothermia/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	if(iscarbon(arrived))
		update_mob_visual(arrived)
		var/mob/living/carbon/C = arrived
		if(!C.GetComponent(/datum/component/hypothermia))
			C.AddComponent(/datum/component/hypothermia)



/area/hypothermia/process(seconds_per_tick)
	if(area_temperature <= area_min_temperature)
		return
	decrease_temperature_scaled(AREA_TEMPERATURE_DECREASE * seconds_per_tick, area_min_temperature)

// Outdoor areas
/area/hypothermia/outdoor
	outdoors = TRUE
	icon_state = "awaycontent7"
	default_gravity = STANDARD_GRAVITY
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	area_flags_mapping = CAVES_ALLOWED
	area_flags = UNIQUE_AREA | HIDDEN_AREA | CAVES_ALLOWED | FLORA_ALLOWED
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	daylight = TRUE

/area/hypothermia/outdoor/crashland
	name = "Crash side"
	icon_state = "away1"

/area/hypothermia/outdoor/query
	name = "Deisolated query"
	icon_state = "away2"
	map_generator = /datum/map_generator/cave_generator/hypothermia/surface

/area/hypothermia/outdoor/plato
	name = "Deisolated plato"
	icon_state = "away3"
	map_generator = /datum/map_generator/cave_generator/hypothermia/surface/plato

/area/hypothermia/outdoor/abyss
	name = "Abyss"
	icon_state = "away4"
	map_generator = /datum/map_generator/cave_generator/hypothermia/abyss

/area/hypothermia/outdoor/outpost
	name = "Outpost"
	icon_state = "away5"

/area/hypothermia/outdoor/deisolated
	name = "Deisolated wastelands"
	icon_state = "away6"
	map_generator = /datum/map_generator/cave_generator/hypothermia/surface/deisolated

/area/hypothermia/indoor
	outdoors = FALSE
	default_gravity = STANDARD_GRAVITY
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_ENVIRONMENT_ROOM
	area_flags = UNIQUE_AREA | HIDDEN_AREA
	min_ambience_cooldown = 30 SECONDS


/area/hypothermia/indoor/caven
	name = "Arctic caves"
	outdoors = FALSE
	default_gravity = STANDARD_GRAVITY
	ambience_index = AMBIENCE_ICEMOON
	sound_environment = SOUND_ENVIRONMENT_CAVE
	area_flags_mapping = CAVES_ALLOWED
	area_flags = UNIQUE_AREA | HIDDEN_AREA | CAVES_ALLOWED | FLORA_ALLOWED
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	min_ambience_cooldown = 45 SECONDS
	ambientsounds = list(
		'modular_zvents/sounds/ambience/he_caves_moans1.ogg',
		'modular_zvents/sounds/ambience/he_caves_moans2.ogg',
		'modular_zvents/sounds/ambience/he_caves_moans3.ogg',
		'modular_zvents/sounds/ambience/he_caves_moans4.ogg',
		'modular_zvents/sounds/ambience/he_caves_rock1.ogg',
		'modular_zvents/sounds/ambience/he_caves_rock2.ogg',
		'modular_zvents/sounds/ambience/he_caves_rock3.ogg',
	)


/area/hypothermia/indoor/caven/deep
	name = "Deep caves"
	ambientsounds = list(
		'modular_zvents/sounds/ambience/he_caves_moans1.ogg',
		'modular_zvents/sounds/ambience/he_caves_moans2.ogg',
		'modular_zvents/sounds/ambience/he_caves_moans3.ogg',
		'modular_zvents/sounds/ambience/he_caves_moans4.ogg',
		'modular_zvents/sounds/ambience/he_caves_rock1.ogg',
		'modular_zvents/sounds/ambience/he_caves_rock2.ogg',
		'modular_zvents/sounds/ambience/he_caves_rock3.ogg',
		'modular_zvents/sounds/ambience/he_caves_screams.ogg',
		'modular_zvents/sounds/ambience/he_caves_steps.ogg',
	)

/area/hypothermia/indoor/caven/deep/autogen
	map_generator = /datum/map_generator/cave_generator/hypothermia/caven/deep

/area/hypothermia/indoor/caven/nest
	name = "The nest"


/area/hypothermia/indoor/caven/vosxod
	name = "Vosxod silence construct"

/area/hypothermia/indoor/caven/vosxod/core
	name = "Vosxod core unit"


/area/hypothermia/indoor/outpost
	name = "Arctic Outpost"

/area/hypothermia/indoor/outpost/zvezda
	name = "Zvezda Outpost"

/area/hypothermia/indoor/outpost/zvezda/kitchen
	name = "Zvezda kitchen"

/area/hypothermia/indoor/outpost/zvezda/hydroponics
	name = "Zvezda hydroponics"

/area/hypothermia/indoor/outpost/zvezda/janitor
	name = "Zvezda janitor"

/area/hypothermia/indoor/outpost/zvezda/restroom
	name = "Zvezda restroom"

/area/hypothermia/indoor/outpost/zvezda/dorm1
	name = "Zvezda 1 dormitory"

/area/hypothermia/indoor/outpost/zvezda/dorm2
	name = "Zvezda 2 dormitory"

/area/hypothermia/indoor/outpost/zvezda/dorm3
	name = "Zvezda 3 dormitory"

/area/hypothermia/indoor/outpost/zvezda/dorm4
	name = "Zvezda 4 dormitory"

/area/hypothermia/indoor/outpost/zvezda/dorm5
	name = "Zvezda 5 dormitory"

/area/hypothermia/indoor/outpost/zvezda/medical_lobby
	name = "Zvezda medical lobby"

/area/hypothermia/indoor/outpost/zvezda/medical_surgery
	name = "Zvezda surgery"

/area/hypothermia/indoor/outpost/zvezda/rnd
	name = "Zvezda research division"

/area/hypothermia/indoor/outpost/zvezda/engineering
	name = "Zvezda engineering"

/area/hypothermia/indoor/outpost/zvezda/garag
	name = "Zvezda garag"

/area/hypothermia/indoor/outpost/zvezda/heavy_armory
	name = "Zvezda heavy armory"

/area/hypothermia/indoor/outpost/zvezda/security
	name = "Zvezda security"


/area/hypothermia/indoor/outpost/tcoms
	name = "Telecomunications"


/area/hypothermia/indoor/outpost/arctic_quarters
	name = "Arctic quarters"

/area/hypothermia/indoor/outpost/arctic_quarters1
	name = "Arctic quarters"

/area/hypothermia/indoor/outpost/arctic_quarters2
	name = "Arctic quarters"

/area/hypothermia/indoor/outpost/arctic_quarters3
	name = "Arctic quarters"

/area/hypothermia/indoor/outpost/arctic_quarters4
	name = "Arctic quarters"




/area/hypothermia/indoor/outpost/progres
	name = "Progres enterence"

/area/hypothermia/indoor/outpost/progres/research
	name = "Heavy research division"

/area/hypothermia/indoor/outpost/progres/experement
	name = "Progress experement division"

/area/hypothermia/indoor/outpost/progres/bossfight
	name = "Isolation facility"




// Planet surface generator
/datum/map_generator/cave_generator/hypothermia
	weighted_mob_spawn_list = list()

// Surface generators
/datum/map_generator/cave_generator/hypothermia/surface
	weighted_closed_turf_types = list(/turf/closed/mineral/random/icy_planet = 1)
	weighted_open_turf_types = list(/turf/open/misc/icy_planet/snow = 1)

	flora_spawn_chance = 25
	feature_spawn_chance = 0
	mob_spawn_chance = 0

	initial_closed_chance = 30
	smoothing_iterations = 40
	birth_limit = 4
	death_limit = 3


// Plato

/datum/map_generator/cave_generator/hypothermia/surface/plato
	initial_closed_chance = 30
	smoothing_iterations = 25
	flora_spawn_chance = 35

	weighted_flora_spawn_list = list(
		/obj/structure/flora/rock/icy/style_random = 20,
		/obj/structure/flora/rock/pile/icy/style_random = 10
	)


// Mountains
/datum/map_generator/cave_generator/hypothermia/surface/deisolated
	initial_closed_chance = 80
	smoothing_iterations = 40
	birth_limit = 5
	death_limit = 4
	flora_spawn_chance = 10

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/chilly = 10,
		/obj/structure/flora/rock/icy/style_random = 90,
		/obj/structure/flora/rock/pile/icy/style_random = 10
	)


/datum/map_generator/cave_generator/hypothermia/abyss
	initial_closed_chance = 70
	smoothing_iterations = 15
	birth_limit = 3
	death_limit = 5
	weighted_flora_spawn_list = null
	weighted_feature_spawn_list = list(/obj/structure/geyser/random = 1)



/datum/map_generator/cave_generator/hypothermia/surface/outpost
	feature_spawn_chance = 40



// Caves generators
/datum/map_generator/cave_generator/hypothermia/caven
	initial_closed_chance = 45
	flora_spawn_chance = 10
	weighted_open_turf_types = list(/turf/open/misc/dirt/station = 1)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/rock/icy/style_random = 20,
		/obj/structure/flora/rock/pile/icy/style_random = 10,
		/obj/structure/prop/stalagmite/style_random = 10,
	)


/datum/map_generator/cave_generator/hypothermia/caven/deep
	weighted_closed_turf_types = list(/turf/closed/mineral/random/icy_planet/cave = 1)
	mob_spawn_chance = 10
	smoothing_iterations = 50


/obj/effect/mapping_helpers/ztrait_injector/snowstorm
	traits_to_add = list(ZTRAIT_SNOWSTORM = TRUE)
