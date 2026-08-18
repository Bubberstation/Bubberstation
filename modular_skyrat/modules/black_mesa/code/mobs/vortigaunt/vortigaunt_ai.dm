/**
 * AI controller for vortigaunt mobs
 *
 * Handles ranged combat behavior and targeting
 */
/datum/ai_controller/basic_controller/vortigaunt
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/vortigaunt/vortigaunt.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 3,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 6
	)

	ai_movement = /datum/ai_movement/basic_avoidance

