/// Whether the alert shows a running count of how many people have signed up so far.
/datum/candidate_poll/var/show_candidate_amount = TRUE

/// Hides the alert and opts out of further prompts, same as the "Never For This Round" chat link.
/atom/movable/screen/alert/poll_alert/proc/dismiss_poll()
	if(isnull(poll))
		return
	var/alert_category = "[poll.poll_key]_poll_alert"
	if(poll.ignoring_category && !(owner.ckey in GLOB.poll_ignore[poll.ignoring_category]))
		poll.do_never_for_this_round(owner)
	else
		poll.remove_candidate(owner, silent = TRUE)
	owner.clear_alert(alert_category)
