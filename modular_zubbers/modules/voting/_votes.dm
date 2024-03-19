
/datum/vote
	// Specifies if ghosts without linked bodies or ghostroles are allowed to vote
	var/allow_ghosts = TRUE


// Checks if a mob can partake in voting. Feel free to add overrides when adding your own votes!
// This is called directly from /datum/controller/subsystem/vote so some nullchecks are excluded as they are included before this is called
/datum/vote/proc/can_mob_vote(mob/voter)
	if(SSticker.HasRoundStarted() && !allow_ghosts)
		// Handle the pesky ghosts and lobby people first
		if(!voter.mind || QDELETED(voter.mind.current) || voter.mind.is_offstation_ghost)
			return FALSE
		else if(!istype(voter, /mob/dead)) && is_centcom_level(voter.z)
			return FALSE

	return TRUE

/datum/vote/transfer_vote
	allow_ghosts = FALSE
