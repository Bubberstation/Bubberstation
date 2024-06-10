/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)

	var/list/candidates_tickets = list() //M = ticket count

	var/maximum_tickets_possible = CONFIG_GET(number/antag_ticket_maximum)

	for(var/mob/candidate as anything in cast_control.get_candidates())
		if(!candidate.client)
			continue
		candidates_tickets[candidate] = maximum_tickets_possible + candidate.client.get_antag_tickets()

	for(var/i in 1 to antag_count)
		if(!candidates_tickets.len)
			break
		var/mob/candidate = pick_weight(candidates_tickets)
		candidates_tickets -= candidate
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
