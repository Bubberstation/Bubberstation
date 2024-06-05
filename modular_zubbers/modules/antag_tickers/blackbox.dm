/datum/controller/subsystem/blackbox/fire()

	. = ..()

	if(SSticker.HasRoundStarted() && (triggertime < 0 || world.time > triggertime + (5 MINUTES)))
		var/antag_tickets_to_add = CONFIG_GET(number/antag_tickets_per_five_minutes)
		if(antag_tickets_to_add > 0)
			update_antag_tickets(antag_tickets_to_add)

/datum/controller/subsystem/blackbox/proc/update_antag_tickets(amount)

	for(var/client/found_client as anything in GLOB.clients)
		var/ticket_multiplier = found_client.antag_ticket_multiplier()
		if(!ticket_multiplier)
			continue
		update_antag_tickets(ticket_multiplier*amount)

	return TRUE
