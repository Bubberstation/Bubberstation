/client/proc/get_antag_tickets()
	return prefs.antag_tickets ? prefs.antag_tickets : 0

/client/proc/add_antag_tickets(amount_to_add=0)

	if(!amount_to_add || !prefs)
		return

	prefs.antag_tickets = clamp(prefs.antag_tickets + amount_to_add, CONFIG_GET(number/antag_ticket_minimum), CONFIG_GET(number/antag_ticket_maximum))

	return TRUE

/client/proc/antag_ticket_multiplier()

	var/datum/mind/our_mind = src.mob?.mind

	if(!our_mind)
		return 0

	var/mob/living/actual_mob = our_mind.current

	if(!actual_mob)
		return 0

	if(is_special_character(actual_mob, allow_fake_antags = FALSE)) //Antagonist.
		return -1

	if(our_mind.assigned_role && our_mind.assigned_role.faction == FACTION_STATION && !src.is_afk()) //Non-antagonist crew.
		return 1

	return 0