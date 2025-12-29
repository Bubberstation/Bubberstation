/datum/trigger_type
	var/atom/parent
	var/trigger_key
	var/delay = 0
	var/datum/weakref/trigger_component

/datum/trigger_type/New(atom/_parent, _key, list/extra_args = null)
	if(!_parent || !_key)
		qdel(src)
		return

	parent = _parent
	trigger_key = _key

	if(extra_args?.len)
		parse_extra_args(arglist(extra_args))

	subscribe_to_parent()

/datum/trigger_type/Destroy(force, ...)
	unsubscribe_from_parent()
	if(trigger_component)
		var/datum/component/trigger/C = trigger_component.resolve()
		if(C)
			C.on_trigger_qdel(src)
		trigger_component = null
	parent = null
	return ..()

/datum/trigger_type/proc/parse_extra_args()
	return

/datum/trigger_type/proc/subscribe_to_parent()
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(on_parent_qdel))

/datum/trigger_type/proc/unsubscribe_from_parent()
	UnregisterSignal(parent, COMSIG_QDELETING)

/datum/trigger_type/proc/trigger(datum/source, list/arguments)
	SIGNAL_HANDLER
	if(!SStriggers.check_ready(trigger_key, source))
		return

	if(delay > 0)
		addtimer(CALLBACK(src, PROC_REF(delayed_trigger), arguments), delay)
	else
		activate_immediate(arguments)

/datum/trigger_type/proc/delayed_trigger(list/arguments)
	if(QDELETED(src))
		return
	activate_immediate(arguments)

/datum/trigger_type/proc/check_ready(mob/user)
	return TRUE

/datum/trigger_type/proc/activate_immediate(list/arguments)
	SStriggers.activate_trigger(trigger_key, src, arguments)
	var/datum/component/trigger/C = trigger_component.resolve()
	if(C)
		C.post_trigger()

/datum/trigger_type/proc/on_parent_qdel()
	SIGNAL_HANDLER
	qdel(src)
