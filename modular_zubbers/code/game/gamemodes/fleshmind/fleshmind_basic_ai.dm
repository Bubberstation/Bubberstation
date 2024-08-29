/datum/ai_controller/basic_controller/fleshmind
	ai_traits = NONE // Placeholder
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 // Varies, will have to find a good number for this

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
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
	)
	idle_behavior = /datum/idle_behavior/idle_random_walk // We want these to be walking around
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
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

