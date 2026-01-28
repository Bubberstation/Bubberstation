/datum/trigger_type/periodic
	var/interval = 10 SECONDS

/datum/trigger_type/periodic/New(atom/_parent, _delay = 0, _interval = 10 SECONDS)
	interval = _interval
	..(_parent, _delay)

/datum/trigger_type/periodic/trigger()
	..()

/datum/trigger_type/delayed_once
	var/initial_delay

/datum/trigger_type/delayed_once/New(atom/_parent, _delay = 0, _initial_delay = 30 SECONDS)
	initial_delay = _initial_delay
	..(_parent, _delay)

/datum/trigger_type/delayed_once/subscribe_to_parent()
	addtimer(CALLBACK(src, PROC_REF(trigger)), initial_delay)

/datum/trigger_type/delayed_once/unsubscribe_from_parent()
	UnregisterSignal(parent, COMSIG_QDELETING)


/obj/effect/mapping_helpers/trigger_helper/periodic
	name = "Trigger Helper - Periodic"
	trigger_type = /datum/trigger_type/periodic
	delay = 0
	extra_params = list(10 SECONDS)

/obj/effect/mapping_helpers/trigger_helper/periodic/frequent
	extra_params = list(5 SECONDS)

// Подтипы для delayed_once
/obj/effect/mapping_helpers/trigger_helper/delayed_once
	name = "Trigger Helper - Delayed Once"
	trigger_type = /datum/trigger_type/delayed_once
	delay = 30 SECONDS
	extra_params = list(30 SECONDS)

/obj/effect/mapping_helpers/trigger_helper/delayed_once/short
	name = "Trigger Helper - Delayed Once (Short)"
	delay = 10 SECONDS
	extra_params = list(10 SECONDS)
