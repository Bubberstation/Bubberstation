/turf/open/floor/white/mad_grass
	name = "perfect grass"
	desc = "The grass is perfect, it looks amazing and appealing, you should just lay down in it for a while."
	icon_state = "grass"
	color = "#FF0000"//doesnt actually appear red in game, does to make differntiating grass and this satan grass easier.
	slowdown = 20//>:3
	tiled_turf = FALSE

/turf/open/floor/white/mad_grass/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/valley_of_madness)
	color = null

/datum/status_effect/deadly_madness
	alert_type = null
	id = "madness_turf_effect"
	tick_interval = 2 SECONDS
	remove_on_fullheal = TRUE

/datum/status_effect/deadly_madness/proc/insane(mob/living/source)
	if(source.mob_mood.sanity <= SANITY_CRAZY)
		source.adjust_brute_loss(1000)

/datum/status_effect/deadly_madness/on_apply()
	RegisterSignal(owner, COMSIG_CARBON_SANITY_UPDATE, PROC_REF(insane))
	return ..()

/datum/status_effect/deadly_madness/on_remove()
	UnregisterSignal(owner, COMSIG_CARBON_SANITY_UPDATE)
	return ..()

/datum/element/valley_of_madness

/datum/element/valley_of_madness/Attach(atom/target)
	. = ..()
	if(. == ELEMENT_INCOMPATIBLE)
		return .
	RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(on_entered))
	RegisterSignal(target, COMSIG_ATOM_EXITED, PROC_REF(on_exited))

/datum/element/valley_of_madness/Detach(atom/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ENTERED)
	UnregisterSignal(source, COMSIG_ATOM_EXITED)
	for(var/obj/effect/glowing_rune/rune_to_remove in source)
		qdel(rune_to_remove)
	for(var/mob/living/victim in source)
		victim.remove_status_effect(/datum/status_effect/deadly_madness)

/datum/element/valley_of_madness/proc/on_entered(turf/source, atom/movable/entered, ...)
	SIGNAL_HANDLER

	if(ismecha(entered))
		var/obj/vehicle/sealed/mecha/victim = entered
		victim.take_damage(20, armour_penetration = 100)
		return
	if(!isliving(entered))
		return
	var/mob/living/victim = entered
	victim.apply_status_effect(/datum/status_effect/deadly_madness)

/datum/element/valley_of_madness/proc/on_exited(turf/source, atom/movable/gone)
	SIGNAL_HANDLER
	if(!isliving(gone))
		return
	var/mob/living/leaver = gone
	leaver.remove_status_effect(/datum/status_effect/deadly_madness)

