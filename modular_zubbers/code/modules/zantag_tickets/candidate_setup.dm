/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)

	var/list/candidates_tickets = candidates_to_tickets(cast_control.get_candidates())

	for(var/i in 1 to antag_count)
		if(!length(candidates_tickets)) //All out of options.
			break
		var/mob/candidate = pick_weight(candidates_tickets)
		candidates_tickets -= candidate
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
