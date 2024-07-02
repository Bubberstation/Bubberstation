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

	if(!isliving(src.mob))
		return 0

	var/mob/living/actual_mob = our_mind.current

	if(!actual_mob)
		return 0

	if(length(our_mind.antag_datums))

		var/highest_result //If this is null, then we're not actually an antagonist.
		for(var/datum/antagonist/antag as anything in our_mind.antag_datums)
			var/antag_multiplier = antag.get_antag_ticket_multiplier()
			if(!isnum(antag_multiplier))
				continue
			if(!isnum(highest_result))
				highest_result = 0
			highest_result = max(highest_result,antag_multiplier)

		if(isnum(highest_result))
			if(actual_mob.stat) //Dead. Crit, etc.
				return 0
			if(HAS_TRAIT(actual_mob, TRAIT_RESTRAINED))
				return 0
			if(HAS_TRAIT(actual_mob, TRAIT_INCAPACITATED))
				return 0
			if(actual_mob.is_imprisoned_in_security())
				return 0
			return -highest_result

	if(our_mind.assigned_role && our_mind.assigned_role.faction == FACTION_STATION && !src.is_afk()) //Non-antagonist crew.
		return 1

	return 0


GLOBAL_LIST_INIT(imprisoning_areas,list(
	/area/station/security/holding_cell,
	/area/station/security/courtroom/holding,
	/area/station/security/interrogation,
	/area/station/security/execution,
	/area/station/security/checkpoint/escape,
	/area/station/security/prison
))

/mob/proc/is_imprisoned_in_security()

	var/area/mob_area = get_area(src)

	for(var/area/area_path as anything in GLOB.imprisoning_areas)
		if(istype(mob_area,area_path))
			return TRUE

	return FALSE

/proc/candidates_to_tickets(list/possible_candidates)
	var/base_weight = CONFIG_GET(number/antag_ticket_base_weight)
	var/absolute_minimum = CONFIG_GET(number/antag_ticket_final_minimum)
	var/list/candidates_tickets = list() //M = ticket count
	for(var/mob/candidate as anything in possible_candidates)
		if(!candidate.client)
			continue
		var/candidate_tickets = max(absolute_minimum,base_weight + candidate.client.get_antag_tickets())
		if(candidate_tickets <= 0)
			continue
		candidates_tickets[candidate] = candidate_tickets
	return candidates_tickets

/proc/log_antag_tickets(text, list/data)
	logger.Log(LOG_CATEGORY_ANTAG_TICKETS, text, data)
