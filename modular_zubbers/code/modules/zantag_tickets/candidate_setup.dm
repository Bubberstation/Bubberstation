/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)

	var/list/candidates_tickets = candidates_to_tickets(cast_control.get_candidates())
	if(!length(candidates_tickets))
		message_admins(span_yellowteamradio("Antag tickets system failed to find any candidates!"))
		log_game("Antag tickets system failed to find any candidates!")
		return

	//Logging purposes.
	var/total_tickets = 0
	for(var/candidate in candidates_tickets)
		var/candidate_weight = candidates_tickets[candidate]
		total_tickets += candidate_weight
	var/average_tickets = round(total_tickets / length(candidates_tickets),1)

	for(var/i in 1 to antag_count)
		if(!length(candidates_tickets)) //All out of options.
			break
		var/mob/candidate = pick_weight(candidates_tickets)
		candidates_tickets -= candidate
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
		var/our_weight = candidates_tickets[candidate]
		if(!total_tickets)
			total_tickets = our_weight
		var/percent_chance = round( (our_weight/total_tickets)*100, 1)
		log_antag_tickets("[key_name(candidate)] was made an antagonist with a [percent_chance]% chance to roll (self tickets: [our_weight], total tickets: [total_tickets], average tickets: [average_tickets]).")
