/datum/mind
	var/is_offstation_ghost = FALSE

/obj/effect/mob_spawn/ghost_role/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_GHOSTROLE_SPAWNED, PROC_REF(on_mob_created))

/obj/effect/mob_spawn/ghost_role/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_GHOSTROLE_SPAWNED)

/obj/effect/mob_spawn/ghost_role/proc/on_mob_created(datum/source, mob/living/ghostspawn)
	SIGNAL_HANDLER
	var/mob_on_station = is_station_level(ghostspawn.z)
	if(!mob_on_station && istype(ghostspawn))
		if(!ghostspawn.mind)
			return
		// Pirates can spawn offstation but are also antags and should be allowed a vote
		if(isnull(ghostspawn.mind.antag_datums))
			ghostspawn.mind.is_offstation_ghost = TRUE
