/**
 * If attached to a computer, adds the connectable computer overlays and smooths to other computers.
 */
/datum/element/connectable_computer
	element_flags = ELEMENT_COMPLEX_DETACH
	var/icon/overlay_icon = 'modular_zubbers/icons/obj/machines/computer_connections.dmi'

/datum/element/connectable_computer/Attach(datum/target)
	. = ..()
	if (!is_compatible(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(on_update_overlays))
	RegisterSignal(target, COMSIG_ATOM_POST_DIR_CHANGE, PROC_REF(on_direction_change))

	update_neighbors(target)

/datum/element/connectable_computer/Detach(datum/source, loc)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_UPDATE_OVERLAYS)
	UnregisterSignal(source, COMSIG_ATOM_POST_DIR_CHANGE)

	update_neighbors(loc)

/**
 * Checks if the given target is a modular computer or a normal computer with the connectable 
 * property set
 */
/datum/element/connectable_computer/proc/is_compatible(target)
	if (istype(target, /obj/machinery/modular_computer))
		return TRUE
	
	if (istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/target_computer = target
		return target_computer.connectable
	
	return FALSE

/**
 * Update neighboring computers.
 *
 * Arguments:
 * * location - the location where the machine on which this was called is (or was). This actually 
 * will be either a /obj/machinery or an actual location because of BS related to
 * deleting it
 */
/datum/element/connectable_computer/proc/update_neighbors(location)
	// Clean up overlays on adjacent computers after we're gone.
	for(var/obj/machinery/target in range(1, location))
		if(is_compatible(target))
			target.update_appearance(UPDATE_ICON)

/**
 * Find a connectable computer on this turf.
 *
 * Arguments:
 * * parent - computer/modular computer on which this proc is called. Typed as a machine
 * * search_dir - the direction to search
 */
/datum/element/connectable_computer/proc/find_connectable_computer(obj/machinery/parent, search_dir)
	var/turf/adjacent_turf = get_step(parent, search_dir)

	for(var/obj/machinery/target in adjacent_turf)
		if(target.dir == parent.dir && is_compatible(target))
			return target

	return null

/**
 * Handles COMSIG_ATOM_UPDATE_OVERLAYS for machines.
 *
 * Arguments:
 * * parent_machine - The parent we're manipulating
 * * overlays - The overlays list
 */
/datum/element/connectable_computer/proc/on_update_overlays(obj/machinery/parent_machine, list/overlays)
	SIGNAL_HANDLER

	// Add the connecting overlays.
	var/obj/machinery/left_turf = null
	var/obj/machinery/right_turf = null
	switch(parent_machine.dir)
		if(NORTH)
			left_turf = find_connectable_computer(parent_machine, WEST)
			right_turf = find_connectable_computer(parent_machine, EAST)

		if(EAST)
			left_turf = find_connectable_computer(parent_machine, NORTH)
			right_turf = find_connectable_computer(parent_machine, SOUTH)

		if(SOUTH)
			left_turf = find_connectable_computer(parent_machine, EAST)
			right_turf = find_connectable_computer(parent_machine, WEST)

		if(WEST)
			left_turf = find_connectable_computer(parent_machine, SOUTH)
			right_turf = find_connectable_computer(parent_machine, NORTH)

	if(left_turf)
		overlays += mutable_appearance(overlay_icon, "left")

	if(right_turf)
		overlays += mutable_appearance(overlay_icon, "right")

/datum/element/connectable_computer/proc/on_direction_change(atom/movable/parent_obj, old_dir, new_dir)
	SIGNAL_HANDLER
	
	update_neighbors(parent_obj)
