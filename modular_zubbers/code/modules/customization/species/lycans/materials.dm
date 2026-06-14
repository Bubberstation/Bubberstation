/datum/material/silver/on_applied(atom/source, mat_amount, multiplier, from_slot)
	. = ..()

	if (isitem(source))
		source.AddComponent( \
			/datum/component/bane, \
			should_bane_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(is_viable_for_lycan_bane)), \
			damage_multiplier = 1.25, \
		)

/proc/is_viable_for_lycan_bane(atom/target)
	if (!iscarbon(target))
		return FALSE

	return islycan(target)
