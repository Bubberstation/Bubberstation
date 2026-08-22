/**
 * Melee
 */
/datum/ai_controller/basic_controller/abductor
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * Ranged
 */

/datum/ai_controller/basic_controller/abductor/ranged

