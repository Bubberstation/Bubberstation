/datum/vote
	/// Provide a reminder notification to those who haven't voted
	var/vote_reminder = FALSE
	/// Has the vote reminder fired yet
	var/reminder_fired = FALSE

/datum/controller/subsystem/vote/fire()
	. = ..()
	if(!current_vote.vote_reminder || current_vote.reminder_fired)
		return

	if(current_vote.time_remaining > 45)
		return

	current_vote.reminder_fired = TRUE

	// We give a reminder to latejoiners who may have missed the original vote notification.
	for(var/client/late_voter as anything in GLOB.clients)
		if(LAZYFIND(voted, late_voter.ckey)) // Skip people who already voted
			continue

		if(current_vote.vote_sound && (late_voter.prefs.read_preference(/datum/preference/toggle/sound_announcements)))
			SEND_SOUND(late_voter, sound(current_vote.vote_sound))

		to_chat(late_voter, span_yellowteamradio("It's time to make your choices for [current_vote.name]! Type <b>vote</b> or click <a href='byond://winset?command=vote'>here</a> to place your votes."))

