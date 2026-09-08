/// A small twinkling shining light that imbues people and things
/// with magical effects upon walking through.
/obj/effect/magical_light
	name = "\improper sparkles"
	icon = 'modular_zubbers/icons/effects/magic_lights.dmi'
	icon_state = "lights"
	desc = null
	light_range = 0.8
	light_power = 0.3
	light_system = OVERLAY_LIGHT
	light_on = TRUE

	/// The strength of the effects given out, might change length or other
	/// things, see the /datum/status_effect/magical_light types
	var/potency = 1
	/// Amount of effects this light initializes with at maximum.
	var/effect_count = 1
	/// The list of effects this light has on all mobs that pass through
	var/list/effect_types = list()

/obj/effect/magical_light/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(HAS_TRAIT(our_turf, TRAIT_TURF_BLESSED))
		return INITIALIZE_HINT_QDEL
	RegisterSignal(our_turf, COMSIG_ATOM_ENTERED, PROC_REF(on_enter))
	RegisterSignal(our_turf, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, PROC_REF(on_initialized))
	RegisterSignal(our_turf, SIGNAL_ADDTRAIT(TRAIT_TURF_BLESSED), PROC_REF(on_bless))
	RegisterSignal(our_turf, COMSIG_BIBLE_SMACKED, PROC_REF(on_bless))

	var/randomized_color = rgb2hsv("#" + random_color())
	randomized_color[2] = clamp(randomized_color[2], 5, 50)
	randomized_color[3] = clamp(randomized_color[2], 60, 100)
	var/final_color = hsv2rgb(randomized_color)
	color = final_color
	set_light_color(final_color)

	for(var/i in 1 to effect_count)
		var/type = pick(typesof(/datum/status_effect/magical_light) - effect_types) // Change to subtypesof later
		if(isnull(type))
			break
		effect_types += type

/obj/effect/magical_light/Destroy(force)
	. = ..()
	var/turf/our_turf = get_turf(src)
	UnregisterSignal(our_turf, list(COMSIG_ATOM_ENTERED,
		COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON,
		SIGNAL_ADDTRAIT(TRAIT_TURF_BLESSED),
		COMSIG_BIBLE_SMACKED,
		))

/obj/effect/magical_light/examine(mob/user)
	. = ..()


/obj/effect/magical_light/proc/on_enter(datum/source, atom/movable/entered)
	SIGNAL_HANDLER
	handle_new_entry(entered)

/obj/effect/magical_light/proc/on_initialized(datum/source, atom/movable/initialized, mapload)
	SIGNAL_HANDLER
	handle_new_entry(initialized)

/obj/effect/magical_light/proc/on_bless(datum/source)
	SIGNAL_HANDLER
	src.visible_message(span_notice("The sparkling lights fizzle out of existence."))
	qdel(src)

/obj/effect/magical_light/proc/handle_new_entry(atom/movable/entered)
	if(istype(entered, /mob/living))
		var/mob/living/entered_living
		for(var/datum/status_effect/magical_light/to_apply in effect_types)
			UNLINT(entered_living.apply_status_effect(to_apply, potency = src.potency)) // Sadly spacemanDMM wont shutup
