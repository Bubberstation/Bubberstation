/**
 * AI Controllers
 */

/// AI controller for HECU melee troops
/datum/ai_controller/basic_controller/hecu
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/human_mobs/blackops.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/// AI controller for HECU ranged troops
/datum/ai_controller/basic_controller/hecu/ranged
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/human_mobs/ranged.bt.json"

/// AI controller for security guards
/datum/ai_controller/basic_controller/sec
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/human_mobs/blackops.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_BASIC_MOB_HATED_FACTIONS = list(FACTION_HECU, FACTION_BLACKOPS)
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/// AI controller for ranged security guards
/datum/ai_controller/basic_controller/sec/ranged
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/human_mobs/ranged.bt.json"

/// AI controller for black ops
/datum/ai_controller/basic_controller/blackops
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/human_mobs/blackops.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/// AI controller for ranged black ops
/datum/ai_controller/basic_controller/blackops/ranged
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/human_mobs/ranged.bt.json"
