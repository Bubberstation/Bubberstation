/// Whether the alert shows a running count of how many people have signed up so far.
/datum/candidate_poll/var/show_candidate_amount = TRUE

/// Closes the alert. Opting out for the round is Alt-click or the chat link.
/atom/movable/screen/alert/poll_alert/proc/dismiss_poll()
	if(isnull(poll))
		return
	owner.clear_alert("[poll.poll_key]_poll_alert")
