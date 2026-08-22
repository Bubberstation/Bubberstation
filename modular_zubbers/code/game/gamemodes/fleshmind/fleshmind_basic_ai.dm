#define MECHIVER_CORPSE_RANGE 10

/datum/ai_controller/basic_controller/fleshmind
	ai_movement = /datum/ai_movement/jps

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
		BB_AGGRO_RANGE = 14
	)

/datum/ai_controller/basic_controller/fleshmind/globber


/datum/ai_controller/basic_controller/fleshmind/floater


/datum/ai_controller/basic_controller/fleshmind/stunner


/datum/ai_controller/basic_controller/fleshmind/treader


/datum/ai_controller/basic_controller/fleshmind/mechiver
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_STOP_FLEEING = TRUE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 14,
	)

/datum/ai_controller/basic_controller/fleshmind/phaser



/**
 * MECHIVER AI PLANNING
 */


#undef MECHIVER_CORPSE_RANGE
