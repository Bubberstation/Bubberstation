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
