/**
 * AI controller for the Nihilanth boss mob
 *
 * Handles ranged combat behavior and targeting
 */
/datum/ai_controller/basic_controller/nihilanth
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/nihilanth/nihilanth.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 3,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 5,
		BB_MAX_PATHING_ATTEMPTS = 2,
		BB_TARGETING_TIMEOUT = 30 SECONDS // Don't waste time searching if no targets found
	)

	ai_movement = /datum/ai_movement/basic_avoidance
