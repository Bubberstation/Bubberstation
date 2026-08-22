/datum/ai_controller/basic_controller/headcrab
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_BASIC_MOB_CURRENT_TARGET = null,
		BB_BASIC_MOB_MELEE_ATTACK_RANGE = 0,  // No melee attacks
		BB_BASIC_MOB_CURRENT_TARGET_HIDING = FALSE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT  // Allow targeting of unconscious people
	)
