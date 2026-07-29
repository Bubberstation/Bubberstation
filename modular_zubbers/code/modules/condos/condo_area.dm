/area/misc/condo
	name = "Condo"
	icon = 'modular_zubbers/code/modules/condos/icons/area.dmi'
	icon_state = "condo"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT | HIDDEN_AREA | UNLIMITED_FISHING
	static_lighting = TRUE
	mood_bonus = /area/centcom/holding::mood_bonus
	mood_message = /area/centcom/holding::mood_message
	var/condo_number = 0
	var/obj/machinery/cafe_condo_teleporter/parent_object
	var/datum/turf_reservation/reservation

/area/misc/condo/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/condo_still_rockin = FALSE
		var/list/living_mobs = get_all_contents_type(/mob/living) //Got to catch anyone hiding in anything
		for(var/mob/living/living_mob as anything in living_mobs) //Check to see if theres any living mobs with a mind left.
			if(living_mob.mind)
				condo_still_rockin = TRUE
				break

		if(condo_still_rockin)
			dont_come_knockin()
		else
			burn_the_sheets()

/// Still somebody in the condo; just leave peacefully
/area/misc/condo/proc/dont_come_knockin(atom/movable/gone)
	log_game("[gone] has left condo [condo_number]")

/// Nobody left inside! Remove this condo from the active list and unload it.
/area/misc/condo/proc/burn_the_sheets(atom/movable/gone)
	log_game("[gone] has left condo [condo_number]")
	var/list/all_atoms = get_all_contents()
	for(var/atom/movable/potential_blacklisted_atom in all_atoms)
		if(is_type_in_list(potential_blacklisted_atom, SScondos.item_blacklist) || HAS_TRAIT(potential_blacklisted_atom, TRAIT_CONTRABAND))
			potential_blacklisted_atom.forceMove(get_turf(parent_object))
	if(isnull(reservation))
		return
	for(var/turf/turf_to_empty as anything in reservation.reserved_turfs) //remove this once clearing turf reservations is actually reliable
		turf_to_empty.empty()
	SScondos.active_condos -= "[condo_number]"
	parent_object = null
	QDEL_NULL(reservation)
