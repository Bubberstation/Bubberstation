/datum/ai_controller/basic_controller/dolphin
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/dolphin,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/// Like the basic strategy, but exclusively attacks shitlisted people and space carp
/datum/targeting_strategy/basic/dolphin

/datum/targeting_strategy/basic/dolphin/faction_check(datum/ai_controller/controller, mob/living/living_mob, mob/living/the_target)
	if (controller.blackboard[BB_ALWAYS_IGNORE_FACTION] || controller.blackboard[BB_TEMPORARILY_IGNORE_FACTION])
		return FALSE
	if (the_target in controller.blackboard[BB_BASIC_MOB_RETALIATE_LIST])
		return FALSE
	if (FACTION_CARP in the_target.faction)
		return FALSE
	return TRUE
