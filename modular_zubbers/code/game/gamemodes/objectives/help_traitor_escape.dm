/datum/objective/jailbreak/traitor
	name = "help traitor escape"

/datum/objective/jailbreak/traitor/is_valid_target(datum/mind/possible_target)
	. = ..()
	if(!.)
		return FALSE
	if(possible_target.has_antag_datum(/datum/antagonist/traitor))
		return TRUE
	return FALSE
