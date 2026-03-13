/obj/effect/mapping_helpers/trigger_helper
	name = "Trigger Map Helper"
	icon_state = "circuit"
	var/trigger_key = "default_key"
	var/trigger_type = /datum/trigger_type/hand_punch
	var/delay = 0
	var/make_glowing = TRUE
	var/list/extra_params = list()
	var/del_on_use = TRUE

	var/EDITOR_TARGET = /atom		// null first non-helper
									// path
									// UID


/obj/effect/mapping_helpers/trigger_helper/Initialize(mapload)
	. = ..()
	if(!mapload)
		return

	var/atom/target = resolve_target()
	if(!target)
		stack_trace("Trigger helper [name] failed to find target at [loc] (EDITOR_TARGET = [EDITOR_TARGET])")
		return

	target.AddComponent(/datum/component/trigger, \
		trigger_key, trigger_type, delay, make_glowing, del_on_use, extra_params)

	qdel(src)

/obj/effect/mapping_helpers/trigger_helper/proc/resolve_target()
	if(istext(EDITOR_TARGET) && length(EDITOR_TARGET) > 5)
		var/atom/A = locate(EDITOR_TARGET)
		if(A && get_turf(A) == get_turf(src))
			return A

	if(ispath(EDITOR_TARGET, /atom))
		for(var/atom/A in loc)
			if(istype(A, EDITOR_TARGET) && !istype(A, /obj/effect/mapping_helpers))
				return A

	for(var/atom/movable/AM in loc)
		if(!istype(AM, /obj/effect/mapping_helpers))
			return AM

	return null


/obj/effect/mapping_helpers/listener_helper
	name = "Listener Map Helper"
	icon_state = "component"
	layer = OBJ_LAYER + 0.1

	var/listener_key = "default_key"
	var/listener_type = /datum/listener_type
	var/delete_after = FALSE
	var/list/extra_params = list()

	var/EDITOR_TARGET = /atom		// null first non-helper
									// path
									// UID

/obj/effect/mapping_helpers/listener_helper/Initialize(mapload)
	. = ..()
	if(!mapload)
		return

	var/atom/target = resolve_target()
	if(!target)
		stack_trace("Listener helper [name] failed to find target at [loc] (EDITOR_TARGET = [EDITOR_TARGET])")
		return

	target.AddComponent(/datum/component/listener, \
		listener_key, listener_type, delete_after, extra_params)

	qdel(src)

/obj/effect/mapping_helpers/listener_helper/proc/resolve_target()
	if(istext(EDITOR_TARGET) && length(EDITOR_TARGET) > 5)
		var/atom/A = locate(EDITOR_TARGET)
		if(A && get_turf(A) == get_turf(src))
			return A

	if(ispath(EDITOR_TARGET, /atom))
		for(var/atom/A in loc)
			if(istype(A, EDITOR_TARGET) && !istype(A, /obj/effect/mapping_helpers))
				return A

	for(var/atom/movable/AM in loc)
		if(!istype(AM, /obj/effect/mapping_helpers))
			return AM
	return null

