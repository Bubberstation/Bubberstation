SUBSYSTEM_DEF(triggers)
	name = "Action triggers"
	flags = SS_KEEP_TIMING
	wait = 1 SECONDS

	var/list/key_to_listeners = list()          // "key" -> list(/datum/component/listener)
	var/list/periodic_triggers = list()         // /datum/trigger_type/periodic

/datum/controller/subsystem/triggers/proc/register_listener(key, datum/component/listener/L)
	if(!key_to_listeners[key])
		key_to_listeners[key] = list()
	key_to_listeners[key] |= L

/datum/controller/subsystem/triggers/proc/unregister_listener(key, datum/component/listener/L)
	if(!key_to_listeners[key])
		return
	key_to_listeners[key] -= L
	if(!length(key_to_listeners[key]))
		key_to_listeners -= key


/datum/controller/subsystem/triggers/proc/register_trigger(datum/trigger_type/T)
	if(istype(T, /datum/trigger_type/periodic))
		periodic_triggers += T


/datum/controller/subsystem/triggers/proc/check_ready(key, mob/user)
	var/list/listeners = key_to_listeners[key]
	if(!listeners)
		return FALSE
	if(!user && usr)
		user = usr
	for(var/datum/component/listener/L as anything in listeners)
		if(!L.check_ready(user, key))
			return FALSE
	return TRUE

/datum/controller/subsystem/triggers/proc/activate_trigger(key, datum/trigger_type/source, list/args)
	var/list/listeners = key_to_listeners[key]
	if(!listeners)
		return
	for(var/datum/component/listener/L as anything in listeners)
		INVOKE_ASYNC(L, TYPE_PROC_REF(/datum/component/listener, apply_action), source, args, key)

/datum/controller/subsystem/triggers/fire()
	for(var/datum/trigger_type/periodic/P as anything in periodic_triggers)
		if(QDELETED(P))
			periodic_triggers -= P
			continue
		P.trigger()
