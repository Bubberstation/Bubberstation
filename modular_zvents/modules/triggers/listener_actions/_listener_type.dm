/datum/listener_type
	var/atom/parent

/datum/listener_type/New(atom/_parent, ...)
	if(!_parent)
		qdel(src)
		return
	parent = _parent


/datum/listener_type/Destroy()
	parent = null
	return ..()

/datum/listener_type/proc/apply_action(datum/trigger_type/trigger, list/extra_args, key)
	return

/datum/listener_type/proc/parse_extra_args()
	return

/datum/listener_type/proc/check_ready(mob/user, key)
	return TRUE
