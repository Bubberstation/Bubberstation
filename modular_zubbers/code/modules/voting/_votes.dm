
/datum/vote
	// Specifies if people who haven't spent INGAME_TIME_NEEDED minutes in the round are allowed to vote
	var/allow_ghosts = TRUE

#define INGAME_TIME_NEEDED 30

// Checks if a mob can partake in voting. Feel free to add overrides when adding your own votes!
// This is called directly from /datum/controller/subsystem/vote so some nullchecks are excluded as they are included before this is called
/datum/vote/proc/can_mob_vote(mob/voter)
	if(SSticker.HasRoundStarted() && !allow_ghosts)
		if(GLOB.client_minutes_in_round[voter.client.ckey] >= INGAME_TIME_NEEDED)
			return TRUE
		else
			return FALSE

	return TRUE

#undef INGAME_TIME_NEEDED
/datum/vote/transfer_vote
	allow_ghosts = FALSE
	// Has this vote been run before?
	var/has_ran = FALSE

/datum/vote/transfer_vote/can_mob_vote(mob/voter)
	if(has_ran)
		return TRUE
	return ..()

/datum/vote/transfer_vote/finalize_vote(winning_option)
	has_ran = TRUE
	return ..()
