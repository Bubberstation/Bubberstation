#define MECHIVER_CORPSE_RANGE 10

/datum/ai_controller/basic_controller/fleshmind
	behavior_tree_json = "modular_zubbers/code/game/gamemodes/fleshmind/fleshmind.bt.json"
	ai_movement = /datum/ai_movement/jps

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
		BB_AGGRO_RANGE = 14,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 4,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 7,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

/datum/ai_controller/basic_controller/fleshmind/fleshmind_melee
	behavior_tree_json = "modular_zubbers/code/game/gamemodes/fleshmind/fleshmind_melee.bt.json"

/datum/ai_controller/basic_controller/fleshmind/fleshmind_ranged
	behavior_tree_json = "modular_zubbers/code/game/gamemodes/fleshmind/fleshmind_ranged.bt.json"

/datum/ai_controller/basic_controller/fleshmind/treader
	behavior_tree_json = "modular_zubbers/code/game/gamemodes/fleshmind/treader.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
		BB_AGGRO_RANGE = 14,
		BB_TARGETING_STRATEGY_FRIEND = /datum/targeting_strategy/basic/same_faction/low_health,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 4,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 7
	)

/datum/targeting_strategy/basic/same_faction/low_health

/datum/targeting_strategy/basic/same_faction/low_health/is_valid_target(mob/living/living_mob, atom/the_target, vision_range, datum/ai_controller/controller)
	. = ..()
	if(!.)
		return FALSE
	if(isliving(the_target))
		var/mob/living/live_target = the_target
		if(live_target.health < live_target.maxHealth * 0.5)
			return TRUE
	return FALSE

/// Mechiver basic controller
/// Attempts to avoid alive players, running away from them, attacking only if cornered
/// Suicide dashes toward a hardcrit or dead player with the goal to convert them
/datum/ai_controller/basic_controller/fleshmind/mechiver
	behavior_tree_json = "modular_zubbers/code/game/gamemodes/fleshmind/mechiver.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_MECHIVER_TARGETING_STRAT = /datum/targeting_strategy/basic/mechiver,
		BB_MECHIVER_TARGET_EVASION_PRIORITY = /datum/target_priority_strategy/proximity,
		BB_MECHIVER_TARGET_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 14,
		// Stays really far
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 7,
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 9
	)

/datum/targeting_strategy/basic/mechiver
	minimum_stat_key = BB_MECHIVER_TARGET_STAT
	flip_stat_check = TRUE

/datum/targeting_strategy/basic/mechiver/is_valid_target(mob/living/living_mob, atom/the_target, vision_range, datum/ai_controller/controller)
	. = ..()
	if(!.)
		if(!isliving(the_target))
			return FALSE
		if(custom_faction_check ? faction_check(living_mob.ai_controller, living_mob, the_target) : TARGETING_FACTION_CHECK(src, living_mob.ai_controller, living_mob, the_target))
			return FALSE
		if(!ishuman(living_mob) && living_mob.health <= (living_mob.maxHealth * MECHIVER_CONSUME_HEALTH_THRESHOLD))
			return TRUE
	return

/datum/target_priority_strategy/proximity

/datum/target_priority_strategy/proximity/get_target_priority(datum/ai_controller/controller, atom/target)
	return -(get_dist(controller.pawn, target))

#undef MECHIVER_CORPSE_RANGE
