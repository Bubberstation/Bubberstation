/datum/ai_controller/basic_controller/headcrab
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/headcrab/headcrab.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_BASIC_MOB_CURRENT_TARGET = null,
		BB_BASIC_MOB_MELEE_ATTACK_RANGE = 0,  // No melee attacks
		BB_BASIC_MOB_CURRENT_TARGET_HIDING = FALSE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,  // Allow targeting of unconscious people
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 5,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 10
	)
