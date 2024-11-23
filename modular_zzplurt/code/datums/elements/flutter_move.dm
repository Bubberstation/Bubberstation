/// Default amount of drift force to apply when flying
#define DEFAULT_FUNCTIONAL_FORCE 1 NEWTONS // Equal to moth wings
/// Default minimum air pressure to allow movement
#define DEFAULT_MIN_PRESSURE 86 // Roughly equal to moth wings

/**
 * Flutter movement element
 *
 * A mob with this element can move normally in pressurized zero-gravity environments.
 */
/datum/element/flutter_move
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2

	/// Amount of drift force to apply when flying
	var/functional_force = DEFAULT_FUNCTIONAL_FORCE

	/// Minimum air pressure to allow movement
	var/min_pressure = DEFAULT_MIN_PRESSURE

/datum/element/flutter_move/Attach(datum/target, input_force, input_pressure)
	. = ..()

	// Check for living target
	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE

	// Set functional force
	if(input_force)
		functional_force = input_force

	// Set minimum pressure
	if(input_pressure)
		min_pressure = input_pressure

	// Register movement signal
	RegisterSignal(target, COMSIG_MOB_CLIENT_MOVE_NOGRAV, PROC_REF(on_moved))

/datum/element/flutter_move/Detach(datum/source)
	. = ..()

	// Unregister movement signal
	UnregisterSignal(source, COMSIG_MOB_CLIENT_MOVE_NOGRAV)

/// Check if this mob should be allowed to move
/datum/element/flutter_move/proc/can_fly(mob/living/source)
	// Check if being pulled
	if(source.pulledby)
		return FALSE

	// Check if being thrown
	if(source.throwing)
		return FALSE

	// Define current turf
	var/turf/current_turf = get_turf(source)

	// Check if current turf exists
	if(!current_turf)
		return FALSE

	// Define current air
	var/datum/gas_mixture/environment = current_turf.return_air()

	// Check for air pressure
	if(environment?.return_pressure() < min_pressure)
		return FALSE

	// All checks passed - Allow flying
	return TRUE

/// When moving, check for valid air pressure. Apply force if valid.
/datum/element/flutter_move/proc/on_moved(mob/living/source)
	SIGNAL_HANDLER

	// Check if flight is allowed
	if(!can_fly(source))
		return

	// Apply movement
	// Based on code from functional_wings.dm
	var/max_drift_force = (DEFAULT_INERTIA_SPEED / source.cached_multiplicative_slowdown - 1) / INERTIA_SPEED_COEF + 1
	source.newtonian_move(dir2angle(source.client.intended_direction), instant = TRUE, drift_force = functional_force, controlled_cap = max_drift_force)
	source.setDir(source.client.intended_direction)

#undef DEFAULT_FUNCTIONAL_FORCE
#undef DEFAULT_MIN_PRESSURE
