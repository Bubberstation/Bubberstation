/obj/effect/mapping_helpers/looping_sound_emiter
	name = "Looping sound emmiter"

	var/ignore_walls = TRUE
	var/extra_range = 12
	var/volume = 50
	var/looping_sound_type
	VAR_PRIVATE/datum/looping_sound/soundloop = null

/obj/effect/mapping_helpers/looping_sound_emiter/Initialize(mapload)
	. = ..()
	soundloop = new looping_sound_type(src)
	soundloop.volume = volume
	soundloop.extra_range = extra_range
	soundloop.ignore_walls = ignore_walls
	soundloop.start()

/datum/looping_sound/dam_loop
	mid_sounds = 'modular_zvents/sounds/dam_loop.ogg'
	mid_length = 7 SECONDS
	volume = 50
	falloff_exponent = 2

/obj/effect/mapping_helpers/looping_sound_emiter/dam_sounds
	name = "Dam looping sounds"
	looping_sound_type = /datum/looping_sound/dam_loop
	extra_range = 24
