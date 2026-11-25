/**
 * Melee
 */
/datum/ai_controller/basic_controller/abductor
	behavior_tree_json = "modular_skyrat/modules/awaymissions_skyrat/mothership_astrum/abductor.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_BASIC_MOB_MELEE_DELAY = 1 SECONDS,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * Ranged
 */

/datum/ai_controller/basic_controller/abductor/ranged
	behavior_tree_json = "modular_skyrat/modules/awaymissions_skyrat/mothership_astrum/ranged.bt.json"

