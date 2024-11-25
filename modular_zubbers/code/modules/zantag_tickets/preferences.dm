/datum/preferences/
	var/antag_tickets = -1 //Safety
	var/antag_tickets_old = -1

	var/antag_tickets_spent = 0 //This round.
	var/antag_tickets_earned = 0 //This round.

/datum/preferences/load_preferences()
	if(!savefile)
		stack_trace("Attempted to load the preferences of [parent] without a savefile; did you forget to call load_savefile?")
		load_savefile()
		if(!savefile)
			stack_trace("Failed to load the savefile for [parent] after manually calling load_savefile; something is very wrong.")
			return FALSE
	antag_tickets = savefile.get_entry("antag_tickets")
	if(isnull(antag_tickets))
		antag_tickets = CONFIG_GET(number/antag_ticket_default)
	antag_tickets = clamp(antag_tickets, CONFIG_GET(number/antag_ticket_minimum), CONFIG_GET(number/antag_ticket_maximum))
	antag_tickets_old = antag_tickets
	. = ..()

/datum/preferences/save_preferences()
	if(!savefile)
		CRASH("Attempted to save the preferences of [parent] without a savefile. This should have been handled by load_preferences()")
	savefile.set_entry("antag_tickets", antag_tickets)
	antag_tickets_old = antag_tickets
	. = ..()

/datum/controller/subsystem/ticker/declare_completion(was_forced = END_ROUND_AS_NORMAL)

	set waitfor = FALSE

	for(var/ckey in GLOB.preferences_datums)
		var/datum/preferences/prefs = GLOB.preferences_datums[ckey]
		if(prefs.antag_tickets == prefs.antag_tickets_old)
			continue //Only save if there has been a change.
		prefs.save_preferences()

	. = ..()
