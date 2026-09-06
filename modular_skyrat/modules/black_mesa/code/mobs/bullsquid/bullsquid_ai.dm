/datum/ai_controller/basic_controller/bullsquid
	behavior_tree_json = "modular_skyrat/modules/black_mesa/code/mobs/bullsquid/bullsquid.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_MELEE_ATTACK_RANGE = 1,
		BB_BASIC_MOB_CURRENT_TARGET = null,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 3,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 6
	)

	ai_movement = /datum/ai_movement/basic_avoidance
