/// Keep track of and debuff the sacrificed
/datum/component/sacrificed
	var/reason = ""

/datum/component/sacrificed/Initialize(mob/sacrificed_mob, given_reason = "4noraisin")
	if(!ismob(sacrificed_mob))
		return COMPONENT_INCOMPATIBLE
	. = ..()
	reason = given_reason
	ADD_TRAIT(parent, TRAIT_CULT_SACRIFICE, given_reason)
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, PROC_REF(after_sacrifice_revive))
	ADD_TRAIT(parent, TRAIT_CULT_SACRIFICE, source)

/datum/component/sacrificed/proc/after_sacrifice_revive()
	return

