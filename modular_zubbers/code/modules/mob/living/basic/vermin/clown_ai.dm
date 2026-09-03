/datum/ai_controller/basic_controller/clown_bug
	behavior_tree_json = "modular_zubbers/code/modules/mob/living/basic/vermin/clown_bug.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
