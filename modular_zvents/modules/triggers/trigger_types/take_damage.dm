/datum/trigger_type/take_damage
/datum/trigger_type/take_damage/subscribe_to_parent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_TAKE_DAMAGE, PROC_REF(trigger))

/datum/trigger_type/take_damage/unsubscribe_from_parent()
	. = ..()

	UnregisterSignal(parent, list(COMSIG_ATOM_TAKE_DAMAGE))

/datum/trigger_type/take_damage/trigger(datum/source, damage, damagetype, def_zone, blocked)
	..()


/obj/effect/mapping_helpers/trigger_helper/take_damage
	name = "Trigger Helper - Take Damage"
	trigger_type = /datum/trigger_type/take_damage
