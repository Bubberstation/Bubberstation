/client/verb/check_antag_tickets()
	set name = "Check Antag Tickets"
	set category = "OOC"

	var/antag_ticket_rate = CONFIG_GET(number/antag_tickets_per_five_minutes)

	if(!antag_ticket_rate)
		to_chat(span_notice("Antag tickets are currently disabled."))
		return

	var/antag_ticket_count = get_antag_tickets()
	var/antag_ticket_gain = antag_ticket_multiplier()*antag_ticket_rate

	to_chat(src,span_notice("You currently have <b>[antag_ticket_count]</b> antag tickets, and are [antag_ticket_gain >= 0 ? "gaining" : "losing"] <b>[abs(antag_ticket_gain)]</b> antag tickets every 5 minutes."))
