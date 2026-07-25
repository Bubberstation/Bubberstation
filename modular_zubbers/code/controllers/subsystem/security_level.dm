/datum/controller/subsystem/security_level/set_level(new_level, announce = TRUE)
	. = ..()
	new_level = istext(new_level) ? new_level : number_level_to_text(new_level)
	var/datum/security_level/selected_level = available_levels[new_level]
	if(selected_level.number_level >= SEC_LEVEL_DELTA)
		offset_map_vote()

/// Calls the map vote with a time offset, to account for announcements and VOX playback, etc.
/datum/controller/subsystem/security_level/proc/offset_map_vote(offset = 7 SECONDS)
	if(GLOB.roundend_mapvote_called)
		return

	GLOB.roundend_mapvote_called = TRUE
	if(!SSmap_vote.next_map_config)
		addtimer(CALLBACK(src, PROC_REF(async_map_vote)), offset)

/// Calls a map vote only if there has not yet been an automatically triggered map vote.
/datum/controller/subsystem/security_level/proc/async_map_vote()
	INVOKE_ASYNC(SSvote, TYPE_PROC_REF(/datum/controller/subsystem/vote, initiate_vote), /datum/vote/map_vote, vote_initiator_name = "Map Rotation", forced = TRUE)
