GLOBAL_VAR_INIT(roundend_mapvote_called, FALSE)

/obj/docking_port/mobile/emergency/check()
	. = ..()
	if(mode == SHUTTLE_CALL && !SSshuttle.canRecall() && !GLOB.roundend_mapvote_called)
		var/datum/vote/current_vote = SSvote.current_vote
		if(!istype(current_vote, /datum/vote/map_vote))
			INVOKE_ASYNC(SSvote, TYPE_PROC_REF(/datum/controller/subsystem/vote, initiate_vote), /datum/vote/map_vote, vote_initiator_name = "Map Rotation", forced = TRUE) //Do a map vote if we're at the point of no return.
			GLOB.roundend_mapvote_called = TRUE
