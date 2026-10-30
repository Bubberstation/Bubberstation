#define TIME_TO_AUTO_REMOVE 40 MINUTES

/datum/element/dusts_on_catatonia
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

	/// Set of all attached mobs.
	var/list/attached_mobs = list()

/datum/element/dusts_on_catatonia/Attach(datum/target)
	. = ..()

	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE

	attached_mobs[target] = TRUE

	START_PROCESSING(SSprocessing, src)
	RegisterSignal(target, COMSIG_MOB_MIND_TRANSFERRED_OUT_OF, PROC_REF(on_player_left_body))

/datum/element/dusts_on_catatonia/Detach(datum/target)
	. = ..()

	attached_mobs -= target

	if(!attached_mobs.len)
		STOP_PROCESSING(SSprocessing, src)

/datum/element/dusts_on_catatonia/process()
	for(var/mob/living/attached as anything in attached_mobs)
		if(attached.key || attached.get_ghost() || istype(attached.loc, /obj/vore_belly))
			continue

		if(world.time - attached.lastclienttime < TIME_TO_AUTO_REMOVE)
			continue

		remove_player(attached)

/datum/element/dusts_on_catatonia/proc/on_player_left_body(datum/source, mob/living/old_body, datum/mind/swapping)
	remove_player(old_body)

/datum/element/dusts_on_catatonia/proc/remove_player(mob/living/attached)
	attached.investigate_log("was deleted due to no longer being linked to a player or ghost.", INVESTIGATE_DEATHS)
	do_sparks(10, TRUE, attached, spark_type = /datum/effect_system/basic/spark_spread/quantum)
	attached.ghostize()
	qdel(attached)
	Detach(attached)

#undef TIME_TO_AUTO_REMOVE
