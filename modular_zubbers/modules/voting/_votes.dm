
/datum/vote
	// Specifies if ghosts without linked bodies or ghostroles are allowed to vote
	var/allow_ghosts = TRUE


// Checks if a mob can partake in voting. Feel free to add overrides when adding your own votes!
// This is called directly from /datum/controller/subsystem/vote so some nullchecks are excluded as they are included before this is called
/datum/vote/proc/can_mob_vote(mob/voter)
	if(SSticker.HasRoundStarted() && !allow_ghosts)
		// Handle the lobby people first
		if(istype(voter, /mob/dead/new_player))
			return FALSE
		// Check if there is a mind. This should only be a case on ghosts, but also doubles down as a nullcheck for the next check
		// We also check the is_offstation_ghost because it stays with your mind even after dying. No cheating this!
		else if(!voter.mind || QDELETED(voter.mind.current) || voter.mind.is_offstation_ghost)
			return FALSE
		// Check if the person is living. If they are, check if they're on the centcom level
		else if(istype(voter, /mob/living) && (is_centcom_level(voter.z)))
			return FALSE

	return TRUE

/datum/vote/transfer_vote
	allow_ghosts = FALSE
