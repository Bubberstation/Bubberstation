/**
 * Melee
 */
/datum/ai_controller/basic_controller/abductor
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/abductor()
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/abductor
	)

/datum/targetting_datum/basic/abductor
	stat_attack = HARD_CRIT

/datum/ai_planning_subtree/basic_melee_attack_subtree/abductor
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/abductor

/datum/ai_behavior/basic_melee_attack/abductor
	action_cooldown = 1 SECONDS


/**
 * Ranged
 */

/datum/ai_controller/basic_controller/abductor/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/abductor,
	)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/abductor
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/abductor

/datum/ai_behavior/basic_ranged_attack/abductor
	action_cooldown = 2.5 SECONDS
