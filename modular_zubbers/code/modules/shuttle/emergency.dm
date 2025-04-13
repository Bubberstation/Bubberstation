GLOBAL_VAR_INIT(roundend_mapvote_called, FALSE)

/obj/docking_port/mobile/emergency/check()
	. = ..()
	if(mode == SHUTTLE_CALL && !SSshuttle.canRecall() && !GLOB.roundend_mapvote_called)
		var/datum/vote/current_vote = SSvote.current_vote
		if(!istype(current_vote, /datum/vote/map_vote))
			SSsecurity_level.offset_map_vote()
