/obj/effect/particle_effect/fake_sparks
	name = "fake sparks"
	icon_state = "sparks"
	anchored = TRUE
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.8
	light_color = LIGHT_COLOR_FIRE

/obj/effect/particle_effect/fake_sparks/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/particle_effect/fake_sparks/LateInitialize()
	. = ..()
	flick(icon_state, src)
	playsound(src, SFX_SPARKS, 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	QDEL_IN(src, 20)

/datum/effect_system/spark_spread/fake_sparks
	effect_type = /obj/effect/particle_effect/fake_sparks

/proc/do_fake_sparks(number, cardinals_only, datum/source)
	var/datum/effect_system/spark_spread/fake_sparks/sparks = new
	sparks.set_up(number, cardinals_only, source)
	sparks.autocleanup = TRUE
	sparks.start()
