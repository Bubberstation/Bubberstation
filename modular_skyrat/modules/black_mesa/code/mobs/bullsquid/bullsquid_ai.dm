/datum/ai_controller/basic_controller/bullsquid
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_MELEE_ATTACK_RANGE = 1,
		BB_BASIC_MOB_CURRENT_TARGET = null,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
