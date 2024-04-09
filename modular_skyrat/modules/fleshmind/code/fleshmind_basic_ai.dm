/datum/ai_controller/basic_controller/fleshmind
	ai_traits = NONE // Placeholder
	idle_behavior = /datum/idle_behavior/idle_random_walk
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 // Varies, will have to find a good number for this

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = null,
	)

	planning_subtrees = list(
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
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/maintain_distance,
		/datum/ai_planning_subtree/ranged_skirmish,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_controller/basic_controller/fleshmind/floater
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/use_mob_ability/explode,
		/datum/ai_planning_subtree/random_speech/blackboard/fleshmind
	)

/datum/ai_planning_subtree/use_mob_ability/explode

/datum/ai_planning_subtree/use_mob_ability/explode/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if (!isliving(target))
		return // Don't explode
	var/time_on_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] || 0
	if (time_on_target < 5 SECONDS) // Five seconds
		return
	return ..()

