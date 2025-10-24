/**
 * AI Controller
 * Handles the zombie's behavior and targeting
 */
/datum/ai_controller/basic_controller/headcrab_zombie
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_CURRENT_TARGET = null,
		BB_BASIC_MOB_CURRENT_TARGET_HIDING = FALSE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/target_retaliate
	)
