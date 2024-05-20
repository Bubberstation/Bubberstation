//The component that you add to mining weapons.
/datum/component/mining_burden/Attach(datum/target)
	. = ..()
	if(!isitem(target))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(target, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))

/datum/component/mining_burden/Detach(datum/target)
	. = ..()
	if(!isitem(target))
		return COMPONENT_INCOMPATIBLE
	UnregisterSignal(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

/datum/element/mining_burden/proc/on_dropped(datum/source, mob/user)
	SIGNAL_HANDLER
	var/datum/status_effect/stacking/mining_burden/status_effect = equipper.has_status_effect(/datum/status_effect/stacking/mining_burden)
	if(status_effect)
		status_effect.add_stacks(-1)

/datum/element/mining_burden/proc/on_equipped(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	var/datum/status_effect/stacking/mining_burden/status_effect = equipper.has_status_effect(/datum/status_effect/stacking/mining_burden)
	if(status_effect)
		status_effect.add_stacks(bleed_stacks_per_hit)
	else
		equipper.apply_status_effect(/datum/status_effect/stacking/mining_burden, 1)
