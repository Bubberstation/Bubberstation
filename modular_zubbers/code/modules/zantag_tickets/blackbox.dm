/datum/controller/subsystem/blackbox/fire()

	. = ..()

	if(SSticker.HasRoundStarted() && (triggertime < 0 || world.time > triggertime + wait/2))
		var/antag_tickets_to_add = CONFIG_GET(number/antag_tickets_per_update)
		if(antag_tickets_to_add > 0)
			update_antag_tickets(antag_tickets_to_add)

/datum/controller/subsystem/blackbox/proc/update_antag_tickets(amount)

	var/max_antag_ticket_gain_per_round = CONFIG_GET(number/antag_ticket_max_earned_per_round)
	var/max_antag_ticket_loss_per_round = CONFIG_GET(number/antag_ticket_max_spent_per_round)

	for(var/client/found_client as anything in GLOB.clients)
		var/ticket_multiplier = found_client.antag_ticket_multiplier()
		if(!ticket_multiplier)
			continue
		var/tickets_to_add = ticket_multiplier*amount
		if(!tickets_to_add)
			continue
		var/datum/preferences/prefs = GLOB.preferences_datums[found_client.ckey]
		if(tickets_to_add > 0)
			if(max_antag_ticket_gain_per_round > 0)
				tickets_to_add = min(tickets_to_add,max_antag_ticket_gain_per_round - prefs.antag_tickets_earned)
				if(tickets_to_add <= 0)
					continue
			prefs.antag_tickets_earned += tickets_to_add
		else
			if(max_antag_ticket_loss_per_round > 0)
				tickets_to_add = max(tickets_to_add,-(max_antag_ticket_loss_per_round - prefs.antag_tickets_spent))
				if(tickets_to_add > 0)
					continue
			prefs.antag_tickets_spent -= tickets_to_add
		found_client.add_antag_tickets(tickets_to_add)

	return TRUE
