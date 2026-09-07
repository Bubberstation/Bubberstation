/**
 * AI Controller
 * Handles the zombie's behavior and targeting
 */
/datum/ai_controller/basic_controller/headcrab_zombie
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/headcrab_zombie/headcrab_zombie.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_CURRENT_TARGET = null,
		BB_BASIC_MOB_CURRENT_TARGET_HIDING = FALSE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT
	)

	ai_movement = /datum/ai_movement/basic_avoidance
