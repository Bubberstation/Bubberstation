/datum/preferences/
	var/antag_tickets = -1 //Safety

/datum/preferences/load_preferences()
	. = ..()
	if(!.)
		return
	antag_tickets = savefile.get_entry("antag_tickets")
	if(isnull(antag_tickets))
		antag_tickets = CONFIG_GET(number/antag_ticket_default)
	antag_tickets = clamp(antag_tickets, CONFIG_GET(number/antag_ticket_minimum), CONFIG_GET(number/antag_ticket_maximum))
