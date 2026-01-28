/datum/trigger_type/pass_nearby
/datum/trigger_type/pass_nearby/subscribe_to_parent()
	. = ..()

	RegisterSignal(parent, COMSIG_ATOM_ENTERED, PROC_REF(trigger))

/datum/trigger_type/pass_nearby/unsubscribe_from_parent()
	. = ..()

	UnregisterSignal(parent, list(COMSIG_ATOM_ENTERED, COMSIG_QDELETING))

/datum/trigger_type/pass_nearby/trigger(datum/source, atom/movable/entered)
	..()


/datum/trigger_type/step_on
/datum/trigger_type/step_on/subscribe_to_parent()
	RegisterSignal(parent, COMSIG_ATOM_BUMPED, PROC_REF(trigger))

/datum/trigger_type/step_on/unsubscribe_from_parent()
	UnregisterSignal(parent, list(COMSIG_ATOM_BUMPED, COMSIG_QDELETING))

/datum/trigger_type/step_on/trigger(datum/source, atom/movable/crossed_by)
	..()

/obj/effect/mapping_helpers/trigger_helper/pass_nearby
	name = "Trigger Helper - Pass Nearby"
	trigger_type = /datum/trigger_type/pass_nearby


/obj/effect/mapping_helpers/trigger_helper/step_on
	name = "Trigger Helper - Step On"
	trigger_type = /datum/trigger_type/step_on
