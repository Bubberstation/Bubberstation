/// A small twinkling shining light that imbues people and things
/// with magical effects upon walking through.
/obj/effect/magical_light
	name = "sparkles"
	icon = 'modular_zubbers/icons/effects/magic_lights.dmi'
	icon_state = "lights"
	desc = "A set of nice sparkling lights."
	light_range = 0.8
	light_power = 0.3
	light_system = OVERLAY_LIGHT
	light_on = TRUE

	/// The strength of the effects given out, might change length or other
	/// things, see the /datum/status_effect/magical_light types
	var/potency = 1
	/// Amount of effects this light initializes with at maximum.
	var/initial_effect_count = 1
	/// The list of effects this light has on all mobs that pass through
	var/list/datum/status_effect/magical_light/effect_types = list()

/obj/effect/magical_light/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(HAS_TRAIT(our_turf, TRAIT_TURF_BLESSED) | isnull(our_turf))
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

	for(var/i in 1 to initial_effect_count)
		var/type = pick(subtypesof(/datum/status_effect/magical_light) - effect_types) // Change to subtypesof later
		if(isnull(type))
			break
		effect_types += type

/obj/effect/magical_light/Destroy(force)
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(!isnull(our_turf))
		UnregisterSignal(our_turf, list(COMSIG_ATOM_ENTERED,
			COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON,
			SIGNAL_ADDTRAIT(TRAIT_TURF_BLESSED),
			COMSIG_BIBLE_SMACKED,
			))

/obj/effect/magical_light/examine(mob/user)
	. = ..()
	if(effect_types.len <= 0)
		return
	if(user.mind?.holy_role >= HOLY_ROLE_PRIEST || IS_WIZARD(user) || isobserver(user))
		var/magic_desc = ""
		for(var/i in 1 to effect_types.len)
			var/datum/status_effect/magical_light/light_eff = effect_types[i]
			if(i != 1 && i != effect_types.len)
				magic_desc += ","
			else if (i == effect_types.len)
				magic_desc += ", and" // Oxford comma :)
			magic_desc += " [light_eff::special_description]"
			if (i == effect_types.len)
				magic_desc += "."

		. += span_notice("The lights are charged with magic that has[magic_desc]")


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
	if(effect_types.len && istype(entered, /mob/living))
		var/mob/living/entered_living = entered
		if(entered_living.can_block_magic(MAGIC_RESISTANCE | MAGIC_RESISTANCE_HOLY))
			return
		for(var/to_apply in src.effect_types)
			if(prob(50/effect_types.len))
				entered_living.apply_status_effect(to_apply, src.potency)

/obj/effect/magical_light/impotent
	initial_effect_count = 0

// *-----------------------------------------------*
// |Special types meant for mostly EVIL ADMIN DEEDS|
// |or future use in like, wizard rituals.         |
// |Not for the random event, holy shit            |
// *-----------------------------------------------*

/obj/effect/magical_light/potent
	potency = 3

// Todo: Give this thing like a mixed color filter/overlay
/obj/effect/magical_light/mixed
	initial_effect_count = 3
