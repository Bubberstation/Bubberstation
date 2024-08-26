/datum/ai_controller/basic_controller/fleshmind
	ai_traits = NONE // Placeholder
	idle_behavior = /datum/idle_behavior/idle_random_walk/no_target
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
		/datum/ai_planning_subtree/basic_melee_attack_subtree/floater,
		/datum/ai_planning_subtree/use_mob_ability/explode,
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
		/datum/ai_planning_subtree/maintain_distance,
		/datum/ai_planning_subtree/ranged_skirmish,
		/datum/ai_planning_subtree/use_mob_ability/dispense_nanites,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/mechiver
	blackboard = list(
		BB_BASIC_MOB_STOP_FLEEING = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target,
		/datum/ai_planning_subtree/simple_find_wounded_target,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/attack_obstacle_in_path/low_priority_target,
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

/datum/ai_controller/basic_controller/fleshmind/tyrant
	planning_subtrees = list(
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/maintain_distance,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/tyrant,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind,
	)

/datum/ai_planning_subtree/basic_melee_attack_subtree/floater
	end_planning = FALSE

/datum/ai_planning_subtree/use_mob_ability/explode
	ability_key = BB_FLOATER_EXPLODE
	finish_planning = TRUE

/datum/ai_planning_subtree/use_mob_ability/explode/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!isliving(target))
		return
	if(get_dist(target.loc, controller.pawn) >= 2)
		return
	return ..()

/datum/ai_planning_subtree/use_mob_ability/dispense_nanites
	ability_key = BB_TREADER_DISPENSE_NANITES
	finish_planning = FALSE

/datum/ai_planning_subtree/basic_melee_attack_subtree/tyrant
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/tyrant

/datum/ai_behavior/basic_melee_attack/tyrant
	terminate_after_action = TRUE
