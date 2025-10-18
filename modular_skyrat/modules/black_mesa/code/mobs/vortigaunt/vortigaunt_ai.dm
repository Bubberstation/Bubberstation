/**
 * AI controller for vortigaunt mobs
 *
 * Handles ranged combat behavior and targeting
 */
/datum/ai_controller/basic_controller/vortigaunt
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 3,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 6
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/ranged_skirmish,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper,
		/datum/ai_planning_subtree/target_retaliate
	)
