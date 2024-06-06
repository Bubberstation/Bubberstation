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

	if(is_special_character(actual_mob, allow_fake_antags = FALSE)) //Antagonist.
		if(actual_mob.stat) //Dead. Crit, etc.
			return 0
		if(actual_mob.is_imprisoned_by_security()) //Restrained, Incapacitated, in certain security areas.
			return 0
		return -1

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

/mob/proc/is_imprisoned_by_security()

	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE

	if(HAS_TRAIT(src, TRAIT_INCAPACITATED))
		return TRUE

	var/area/mob_area = get_area(src)

	for(var/area/area_path as anything in GLOB.imprisoning_areas)
		if(istype(mob_area,area_path))
			return TRUE

	return FALSE