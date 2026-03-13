/datum/component/trigger
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	// assoc: key = "some_key" -> list(/datum/trigger_type, ...)
	var/list/key_to_triggers = list()
	var/glowing = TRUE
	var/del_on_first_use = TRUE

/datum/component/trigger/Initialize(_key, datum/trigger_type/_trigger_type, delay = 0, _glowing = TRUE, del_on_use = TRUE, list/extra_args = null)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	if(_glowing != null)
		glowing = _glowing

	if(_key && _trigger_type)
		add_trigger_to_key(_key, _trigger_type, delay, extra_args)

	if(glowing && length(key_to_triggers))
		add_outline()

	del_on_first_use = del_on_use

/datum/component/trigger/proc/add_trigger_to_key(key, datum/trigger_type/_trigger_type, delay = 0, list/extra_args = null)
	if(!key || !_trigger_type)
		return

	var/list/existing = key_to_triggers[key]
	if(!existing)
		existing = list()
		key_to_triggers[key] = existing

	var/datum/trigger_type/new_trigger = new _trigger_type(parent, key, extra_args)
	new_trigger.delay = delay
	existing += new_trigger
	new_trigger.trigger_component = WEAKREF(src)

	RegisterSignal(new_trigger, COMSIG_QDELETING, PROC_REF(on_trigger_qdel))

	if(glowing && length(key_to_triggers) == 1 && length(existing) == 1)
		add_outline()

	SStriggers.register_trigger(new_trigger)

/datum/component/trigger/InheritComponent(datum/component/trigger/old_comp, i_am_original, _key, datum/trigger_type/_trigger_type, delay = 0, _glowing = TRUE, list/extra_args)
	if(_glowing != null)
		set_glowing(_glowing)
	if(_key && _trigger_type)
		add_trigger_to_key(_key, _trigger_type, delay, extra_args)


/datum/component/trigger/proc/post_trigger()
	if(del_on_first_use)
		qdel(src)

/datum/component/trigger/proc/add_outline()
	var/atom/A = parent
	A.add_filter("trigger_outline", 2, list("type" = "outline", "color" = "#f1e976", "size" = 1))

/datum/component/trigger/proc/remove_outline()
	var/atom/A = parent
	A.remove_filter("trigger_outline")

/datum/component/trigger/proc/set_glowing(new_glowing)
	if(glowing == new_glowing)
		return
	glowing = new_glowing
	if(glowing && length(key_to_triggers))
		add_outline()
	else
		remove_outline()

/datum/component/trigger/proc/on_trigger_qdel(datum/source)
	SIGNAL_HANDLER
	for(var/key in key_to_triggers)
		key_to_triggers[key] -= source
		if(!length(key_to_triggers[key]))
			key_to_triggers -= key

	if(!length(key_to_triggers) && !QDELING(src))
		qdel(src)

/datum/component/trigger/Destroy()
	remove_outline()
	for(var/key in key_to_triggers)
		for(var/datum/trigger_type/T as anything in key_to_triggers[key])
			qdel(T)
	key_to_triggers.Cut()
	return ..()
