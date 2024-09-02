#define MECHIVER_CORPSE_RANGE 10

/datum/ai_controller/basic_controller/fleshmind
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
		BB_AGGRO_RANGE = 14
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/attack_obstacle_in_path/low_priority_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)
/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	speech_chance = 5

/datum/ai_controller/basic_controller/fleshmind/globber
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/maintain_distance,
		/datum/ai_planning_subtree/ranged_skirmish,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/floater
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/stunner
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/treader
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/use_mob_ability/dispense_nanites,
		/datum/ai_planning_subtree/ranged_skirmish,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/mechiver
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_STOP_FLEEING = TRUE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 14,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_wounded_target,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/search_for_dead,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/mechiver,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/phaser
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/ai_planning_subtree/use_mob_ability/dispense_nanites
	ability_key = BB_TREADER_DISPENSE_NANITES

/datum/ai_planning_subtree/use_mob_ability/dispense_nanites/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	var/list/valid_mobs = list()
	for(var/mob/living/iterating_mob in view(DEFAULT_VIEW_RANGE, controller.pawn))
		if(faction_check(iterating_mob.faction, pawn.faction))
			if(iterating_mob.health < iterating_mob.maxHealth * 0.5)
				valid_mobs += iterating_mob
	if(!LAZYLEN(valid_mobs))
		return
	return ..()

/**
 * MECHIVER AI PLANNING
 */
/datum/ai_planning_subtree/basic_melee_attack_subtree/mechiver

/datum/ai_planning_subtree/basic_melee_attack_subtree/mechiver/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(!controller.blackboard[BB_BASIC_MOB_STOP_FLEEING])
		return
	if(controller.blackboard[BB_MECHIVER_DEAD_TARGET])
		return
	return ..()

/datum/ai_planning_subtree/search_for_dead

/datum/ai_planning_subtree/search_for_dead/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard[BB_MECHIVER_CONTAINED_MOB])
		return
	if(controller.blackboard[BB_MECHIVER_DEAD_TARGET])
		controller.queue_behavior(/datum/ai_behavior/convert_easy_pickings, BB_MECHIVER_DEAD_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	controller.queue_behavior(/datum/ai_behavior/find_and_set/incapacitated, BB_MECHIVER_DEAD_TARGET, /mob/living, MECHIVER_CORPSE_RANGE)

/datum/ai_behavior/find_and_set/incapacitated
	action_cooldown = 2 SECONDS

/datum/ai_behavior/find_and_set/incapacitated/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/mob/living/pawn = controller.pawn
	var/list/corpses = list()
	for(var/mob/living/iterating_mobs in view(search_range, pawn))
		if(faction_check(pawn, iterating_mobs.faction))
			continue
		if(iterating_mobs.health < (iterating_mobs.maxHealth * MECHIVER_CONSUME_HEALTH_THRESHOLD))
			corpses += iterating_mobs
	if(LAZYLEN(corpses))
		return get_closest_atom(/mob/living, corpses, controller.pawn)

/datum/ai_behavior/convert_easy_pickings
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

/datum/ai_behavior/convert_easy_pickings/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	if(target.health > (target.maxHealth * MECHIVER_CONSUME_HEALTH_THRESHOLD)) // Don't do this
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/convert_easy_pickings/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/target = controller.blackboard[target_key]
	var/mob/living/basic/pawn = controller.pawn

	if(QDELETED(target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	controller.set_blackboard_key(BB_MECHIVER_CONTAINED_MOB, target)
	SEND_SIGNAL(pawn, COMSIG_MECHIVER_CONVERT, target)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/convert_easy_pickings/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	if(succeeded)
		controller.clear_blackboard_key(target_key)
		controller.set_blackboard_key(BB_BASIC_MOB_STOP_FLEEING, FALSE)

#undef MECHIVER_CORPSE_RANGE
