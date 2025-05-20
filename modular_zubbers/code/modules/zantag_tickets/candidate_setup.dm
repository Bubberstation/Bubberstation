/datum/round_event/antagonist/candidate_setup(datum/round_event_control/antagonist/cast_control)
	var/datum/antagonist/A = cast_control.antag_datum
	var/antag_name = A.name

	var/list/candidates_tickets = candidates_to_tickets(cast_control.get_candidates())

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
		if(tgui_alert(candidate, "You have been selected to be \an [antag_name]. Do you accept?", "Antagonist Selection", list("No", "Yes"), timeout = 10 SECONDS) != "Yes")
			continue
			// If the player accepts, we set up their mind and add them to the list of minds to finalize
			// If they don't, we remove them from the list of candidates and try again
		setup_minds += candidate.mind
		candidate_roles_setup(candidate)
		var/our_weight = candidates_tickets[candidate]
		var/percent_chance = round( (our_weight/total_tickets)*100, 1)
		log_antag_tickets("[key_name(candidate)] was made an antagonist with a [percent_chance]% chance to roll (self tickets: [our_weight], total tickets: [total_tickets], average tickets: [average_tickets]).")
