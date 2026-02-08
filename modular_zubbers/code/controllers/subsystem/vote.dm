/datum/vote
	/// Provide a reminder notification to those who haven't voted
	var/vote_reminder = FALSE
	/// Has the vote reminder fired yet
	var/reminder_fired = FALSE

/datum/controller/subsystem/vote
	dependencies = list(
		/datum/controller/subsystem/persistence,
		/datum/controller/subsystem/map_vote,
	)

/// Bubber vote fire proc, original at code/controllers/subsystem/vote.dm
/datum/controller/subsystem/vote/fire()
	if(!current_vote)
		return

	current_vote.time_remaining = round((current_vote.started_time + CONFIG_GET(number/vote_period) - world.time) / 10)
	if(current_vote.time_remaining < 0)
		end_vote()
		return

	// We give a reminder to latejoiners who may have missed the original vote notification.
	if(!current_vote.vote_reminder || current_vote.reminder_fired)
		return

	if(current_vote.time_remaining > 45)
		return

	current_vote.reminder_fired = TRUE

	for(var/client/late_voter as anything in GLOB.clients)
		if(LAZYFIND(voted, late_voter.ckey)) // Skip people who already voted
			continue

		if(current_vote.vote_sound && (late_voter.prefs.read_preference(/datum/preference/toggle/sound_announcements)))
			SEND_SOUND(late_voter, sound(current_vote.vote_sound))

		to_chat(late_voter, vote_font(fieldset_block("[current_vote.name] Vote", "It's time to make your choices! Type 'vote' or click <a href='byond://winset?command=vote'>here</a> to place your votes.", "boxed_message purple_box")))

/**
 * Ranked choice voting, where voters rank options in order of preference.
 * If an option doesn't reach the threshold, lowest votes are transferred to next preferences.
 */
/datum/controller/subsystem/vote/proc/submit_ranked_vote(mob/voter, their_vote, rank)
	if(!current_vote)
		return
	if(!voter?.ckey)
		return
	if(CONFIG_GET(flag/no_dead_vote) && voter.stat == DEAD && !voter.client?.holder)
		return
	if(!current_vote.can_mob_vote(voter))
		return

	var/ckey = voter.ckey
	voted += ckey

	// Clear previous ranking for this option if any
	var/old_rank = current_vote.choices_by_ckey["[ckey]_[their_vote]"]
	if(old_rank)
		// Remove the old first place vote if we're changing from rank 1
		if(old_rank == 1)
			current_vote.choices[their_vote]--
		current_vote.choices_by_ckey["[ckey]_[their_vote]"] = null

	// Add new ranking
	if(rank > 0)
		current_vote.choices_by_ckey["[ckey]_[their_vote]"] = rank
		// Only count first place votes in the total
		if(rank == 1)
			current_vote.choices[their_vote]++

	return TRUE

/datum/controller/subsystem/vote/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/voter = usr

	switch(action)
		if("voteRanked")
			return submit_ranked_vote(voter, params["voteOption"], params["voteRank"])
