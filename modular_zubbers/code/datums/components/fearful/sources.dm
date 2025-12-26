// Adjusted clausophobia check to look for Santa themself rather than the clothing
/datum/terror_handler/simple_source/clausophobia/check_condition(seconds_per_tick, terror_buildup)
	. = ..()
	if(!.)
		return

	var/certified_jolly = FALSE

	for(var/mob/living/carbon/human/possible_claus in view(5, owner))
		var/datum/antagonist/santa/jolly = possible_claus.mind?.has_antag_datum(/datum/antagonist/santa)
		if(jolly)
			certified_jolly = TRUE
			break

	if(!certified_jolly)
		return FALSE

	if(SPT_PROB(15, seconds_per_tick))
		to_chat(owner, span_userdanger("Santa Claus is here! I gotta get out of here!"))

	return TRUE
