/**
 * AI controller for houndeye basic mob
 * Handles charging behavior and basic targeting
 */
/datum/ai_controller/basic_controller/houndeye
	// This tree is extremely basic shit, consider making them run further away when their attack finishes
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/houndeye/houndeye.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_LOW_PRIORITY_HUNTING_TARGET = null,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 3,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 4
	)

	ai_movement = /datum/ai_movement/basic_avoidance
