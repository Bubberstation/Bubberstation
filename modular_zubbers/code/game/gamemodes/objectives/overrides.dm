GLOBAL_LIST_INIT(traitor_objective_weights, list(
		/datum/objective/prison_breakout = OBJECTIVE_BREAKOUT_WEIGHT,
		/datum/objective/gimmick = OBJECTIVE_GIMMICK_WEIGHT,
		/datum/objective/steal = OBJECTIVE_STEAL_WEIGHT,
		/datum/objective/steal/heirloom_thief = OBJECTIVE_HEIRLOOM_STEAL_WEIGHT,
		/datum/objective/jailbreak/traitor = OBJECTIVE_HELP_ESCAPE_TRAITOR_WEIGHT,
		/datum/objective/jailbreak = OBJECTIVE_HELP_ESCAPE_WEIGHT,
	))

/datum/antagonist/traitor/forge_single_generic_objective()
	var/objective_type = pick_weight(GLOB.traitor_objective_weights)
	var/datum/objective/our_objective = new objective_type
	our_objective.owner = owner
	var/target = our_objective.find_target()
	if(isnull(target))
		our_objective.owner = null
		QDEL_NULL(our_objective)
		return prime_gimmick_objective()
	return our_objective

/// Used to prime a gimmick objective, since these are usually
/// a replacement for other objectives.
/datum/antagonist/traitor/proc/prime_gimmick_objective()
	var/datum/objective/gimmick/gimmick_objective = new()
	gimmick_objective.owner = owner
	return gimmick_objective

/datum/objective/jailbreak
	name = "help escape" // This was confusing, and it's not an actual jailbreak
