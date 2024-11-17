/// Amount of drift force to apply when flying
#define FLUTTER_FUNCTIONAL_FORCE 2 NEWTONS
/// Minimum air pressure to allow movement
#define FLUTTER_MIN_PRESSURE WARNING_LOW_PRESSURE

/**
 * Flutter movement element
 *
 * A mob with this element can move normally in pressurized zero-gravity environments.
 */
/datum/element/flutter_move
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2

/datum/element/flutter_move/Attach(datum/target)
	. = ..()

	// Check for living target
	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE

	// Register movement signal
	RegisterSignal(target, COMSIG_MOB_CLIENT_MOVE_NOGRAV, PROC_REF(on_moved))

/datum/element/flutter_move/Detach(datum/source)
	. = ..()

	// Unregister movement signal
	UnregisterSignal(source, COMSIG_MOB_CLIENT_MOVE_NOGRAV)

/// When moving, check for valid air pressure. Apply force if valid.
/datum/element/flutter_move/proc/on_moved(mob/living/source)
	SIGNAL_HANDLER

	// Define current turf
	var/turf/current_turf = get_turf(source)

	// Check if current turf exists
	if(!current_turf)
		return

	// Define current air
	var/datum/gas_mixture/environment = current_turf.return_air()

	// Check for air pressure
	if(environment?.return_pressure() < FLUTTER_MIN_PRESSURE)
		return

	// Apply movement
	// Based on code from functional_wings.dm
	var/max_drift_force = (DEFAULT_INERTIA_SPEED / source.cached_multiplicative_slowdown - 1) / INERTIA_SPEED_COEF + 1
	source.newtonian_move(dir2angle(source.client.intended_direction), instant = TRUE, drift_force = FLUTTER_FUNCTIONAL_FORCE, controlled_cap = max_drift_force)
	source.setDir(source.client.intended_direction)

#undef FLUTTER_FUNCTIONAL_FORCE
#undef FLUTTER_MIN_PRESSURE
