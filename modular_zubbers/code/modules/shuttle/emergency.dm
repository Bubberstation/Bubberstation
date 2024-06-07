/obj/docking_port/mobile/emergency/check()
	. = ..()
	if(!timer)
		return
	if(mode == SHUTTLE_CALL)
		if(!SSshuttle.canRecall())
			SSmapping.mapvote() //Do a map vote if we're at the point of no return.
