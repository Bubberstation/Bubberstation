/client/verb/check_antag_tickets()
	set name = "Check Antag Tickets"
	set category = "OOC"

	var/antag_ticket_rate = CONFIG_GET(number/antag_tickets_per_update)

	if(!antag_ticket_rate)
		to_chat(src,span_notice("Antag tickets are currently disabled."))
		return

	var/antag_ticket_count = get_antag_tickets()
	var/antag_ticket_gain = antag_ticket_multiplier()*antag_ticket_rate

	to_chat(src,span_notice("You currently have <b>[antag_ticket_count]</b> antag tickets, and are [antag_ticket_gain >= 0 ? "gaining" : "losing"] <b>[abs(antag_ticket_gain)]</b> antag tickets every [DisplayTimeText(SSblackbox.wait,1)]."))

/client/verb/antag_tickets_info()
	set name = "What are antag tickets?"
	set category = "OOC"

	var/antag_ticket_rate = CONFIG_GET(number/antag_tickets_per_update)

	if(!antag_ticket_rate)
		to_chat(span_notice("Antag tickets are currently disabled, so you don't have to worry about them."))
		return

	var/information = "\
	Antag tickets are a way to balance playtime between being an antagonist and being a non-antagonist. \
	Having more antag tickets makes you more likely to be chosen as an antagonist, while having less makes you less likely to be chosen as one. \
	Antag tickets are gained when you're playing as a crew role while not being an antagonist, while antag tickets are spent when you're playing as an antagonist. \
	Note that as an antagonist, you do not lose antag tickets when you're handcuffed, restrained, dead, crit, incapacitated, or in prison."

	to_chat(src,span_notice(information))
