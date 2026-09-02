/**
 * AI Controllers
 */

/// AI controller for Gordon Freeman boss
/datum/ai_controller/basic_controller/gordon_freeman
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/gordon_freeman/gordon_freeman.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
