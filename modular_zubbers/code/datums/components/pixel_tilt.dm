/datum/component/pixel_tilt
	dupe_mode = COMPONENT_DUPE_UNIQUE
	//whether or not parent is tilting
	var/tilting = TRUE
	//the maximum amount of tilt we can achieve
	var/maximum_tilt = 45
	//if we are tilted
	var/is_tilted = FALSE
	//how many degrees we are tilted
	var/how_tilted = 0

/datum/component/pixel_tilt/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/pixel_tilt/RegisterWithParent()
	RegisterSignal(parent, COMSIG_KB_MOB_PIXEL_TILT_DOWN, PROC_REF(pixel_tilt_down))
	RegisterSignal(parent, COMSIG_KB_MOB_PIXEL_TILT_UP, PROC_REF(pixel_tilt_up))
	RegisterSignals(parent, list(COMSIG_LIVING_RESET_PULL_OFFSETS, COMSIG_LIVING_SET_PULL_OFFSET, COMSIG_MOVABLE_MOVED), PROC_REF(unpixel_tilt))
	RegisterSignal(parent, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(pre_move_check))

/datum/component/pixel_tilt/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_KB_MOB_PIXEL_TILT_DOWN)
	UnregisterSignal(parent, COMSIG_KB_MOB_PIXEL_TILT_UP)
	UnregisterSignal(parent, COMSIG_LIVING_RESET_PULL_OFFSETS)
	UnregisterSignal(parent, COMSIG_LIVING_SET_PULL_OFFSET)
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(parent, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE)

/datum/component/pixel_tilt/proc/pixel_tilt_down()
	SIGNAL_HANDLER
	tilting = TRUE
	return COMSIG_KB_ACTIVATED

/datum/component/pixel_tilt/proc/pixel_tilt_up()
	SIGNAL_HANDLER
	tilting = FALSE

/datum/component/pixel_tilt/proc/pre_move_check(mob/source, new_loc, direct)
	SIGNAL_HANDLER
	if(tilting)
		pixel_tilt(source, direct)
		return COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE

/datum/component/pixel_tilt/proc/pixel_tilt(mob/source, direct)
	var/mob/living/tilter = parent
	if(tilting)
		switch(direct)
			if(EAST)
				if(how_tilted <= maximum_tilt)
					tilter.transform = turn(tilter.transform, 1)
					how_tilted++
					is_tilted = TRUE
			if(WEST)
				if(how_tilted >= -maximum_tilt)
					tilter.transform = turn(tilter.transform, -1)
					how_tilted--
					is_tilted = TRUE

/datum/component/pixel_tilt/proc/unpixel_tilt(mob/source, direct)
	SIGNAL_HANDLER
	if(is_tilted)
		var/mob/living/tilter = parent
		tilter.transform = turn(tilter.transform, -how_tilted)
	qdel(src)
