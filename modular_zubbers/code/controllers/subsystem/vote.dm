/datum/vote
	/// Provide a reminder notification to those who haven't voted
	var/vote_reminder = FALSE
	/// Has the vote reminder fired yet
	var/reminder_fired = FALSE

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

		to_chat(late_voter, custom_boxed_message("purple_box", vote_font("[span_bold("[current_vote.name] Vote")]\n<hr>It's time to make your choices! Type 'vote' or click <a href='byond://winset?command=vote'>here</a> to place your votes.")))

