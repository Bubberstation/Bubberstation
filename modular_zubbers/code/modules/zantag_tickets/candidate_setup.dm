/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)

	var/list/candidates_tickets = candidates_to_tickets(cast_control.get_candidates())
	var/total_candidates = length(candidates_tickets)
	var/total_tickets = 0
	var/absolute_maximum = CONFIG_GET(number/antag_ticket_maximum)

	//Get people with max tickets and move them to another list.
	var/list/candidates_with_max_tickets = list()
	for(var/mob/candidate as anything in candidates_tickets)
		var/ticket_count = candidates_tickets[candidate]
		if(ticket_count >= absolute_maximum) //You have the max
			//Move to the VIP list.
			candidates_with_max_tickets += candidate
			candidates_tickets -= candidate
		else //Only include non-vip people for total ticket logging.
			total_tickets += ticket_count

	var/antag_spawns_left = antag_count

	//These are the people who have the maximum amount of tickets.
	while(antag_spawns_left > 0 && length(candidates_with_max_tickets) > 0) //Keep going until we have no antag spawns left or no one else who has max tickets.
		antag_spawns_left--
		var/mob/candidate = pick(candidates_with_max_tickets)
		candidates_with_max_tickets -= candidate
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
		log_antag_tickets("[key_name(candidate)] was made a(n) [cast_control.name] as they had the maximum number of tickets, beating [length(candidates_with_max_tickets)] others with maximum tickets.")

	//These are the people who don't.
	while(antag_spawns_left > 0 && length(candidates_tickets) > 0) //Keep going until we have no antag spawns left or no one else.
		antag_spawns_left--
		var/mob/candidate = pick_weight(candidates_tickets)
		var/our_tickets = candidates_tickets[candidate]
		var/chance_to_get = (our_tickets/total_tickets)*100
		candidates_tickets -= candidate
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
		log_antag_tickets("[key_name(candidate)] was made a(n) [cast_control.name] with [our_tickets] tickets ([chance_to_get]% chance).")

	log_antag_tickets("There were [total_candidates] people who wanted to be a(n) [cast_control.name], and [antag_count - antag_spawns_left] candidate(s) got the role.")
