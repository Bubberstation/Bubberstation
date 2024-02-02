/datum/antagonist/traitor/forge_single_generic_objective()
	if(prob(KILL_PROB))

		var/datum/objective/gimmick/gimmick_objective = new()
		gimmick_objective.owner = owner
		return gimmick_objective

	var/datum/objective/steal/steal_objective = new()
	steal_objective.owner = owner
	steal_objective.find_target()
	return steal_objective

//Removes telecrystal rewards from progtot secondary objectives
/datum/traitor_objective/New(datum/uplink_handler/handler)
	. = ..()
	telecrystal_reward = 0

/datum/traitor_objective/succeed_objective()
	. = ..()
	telecrystal_reward = 0
