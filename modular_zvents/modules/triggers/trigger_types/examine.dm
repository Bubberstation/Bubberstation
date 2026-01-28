/datum/trigger_type/examine
/datum/trigger_type/examine/subscribe_to_parent()
	. = ..()

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(trigger))

/datum/trigger_type/examine/unsubscribe_from_parent()
	. = ..()

	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE))

/datum/trigger_type/examine/trigger(datum/source, mob/user, list/examine_list)
	..()


/obj/effect/mapping_helpers/trigger_helper/examine
	name = "Trigger Helper - Examine"
	trigger_type = /datum/trigger_type/examine
