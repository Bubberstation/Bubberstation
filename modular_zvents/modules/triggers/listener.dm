/datum/component/listener
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/key
	var/datum/listener_type/real_listener
	var/delete_after

/datum/component/listener/Initialize(_key, datum/listener_type/_listener_type, _delete_after, list/extra_args)
	. = ..()
	if(!isatom(parent) || !_key || !_listener_type)
		stack_trace("Failed to apply action listenner on: [parent]")
		return COMPONENT_INCOMPATIBLE
	key = _key
	delete_after = _delete_after
	real_listener = new _listener_type(parent, args)
	SStriggers.register_listener(key, src)
	if(length(extra_args))
		real_listener.parse_extra_args(arglist(extra_args))


/datum/component/listener/Destroy()
	SStriggers.unregister_listener(key, src)
	if(real_listener)
		qdel(real_listener)
	return ..()

/datum/component/listener/proc/apply_action(datum/trigger_type/trigger, list/args, key)
	real_listener.apply_action(trigger, args, key)
	if(delete_after)
		qdel(real_listener)
		qdel(src)

/datum/component/listener/proc/check_ready(mob/user, key)
	return real_listener.check_ready(user, key)
