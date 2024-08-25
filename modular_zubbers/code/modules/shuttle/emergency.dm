/obj/docking_port/mobile/emergency/check()
	. = ..()
	if(mode == SHUTTLE_CALL && !SSshuttle.canRecall())
		SSmapping.mapvote() //Do a map vote if we're at the point of no return.
