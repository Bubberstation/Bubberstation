/datum/ai_controller/basic_controller/fleshmind
	ai_traits = NONE // Placeholder
	idle_behavior = /datum/idle_behavior/idle_random_walk
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 // Varies, will have to find a good number for this

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target/fleshmind,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/attack_obstacle_in_path/low_priority_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/fleshmind
	)

/datum/ai_planning_subtree/random_speech/fleshmind
	speech_chance = 10
	speak = list("The flesh yearns for your soul.", "The flesh is broken without you.", "The flesh does not discriminate.", "Join the flesh.")
	sound = list(
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light1.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light2.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light3.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light4.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light5.ogg',
	)
/datum/ai_planning_subtree/simple_find_target/fleshmind

/datum/ai_planning_subtree/simple_find_target/fleshmind/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	controller.queue_behavior(/datum/ai_behavior/find_potential_targets/fleshmind, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETING_STRATEGY, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

/datum/ai_behavior/find_potential_targets/fleshmind

/datum/ai_behavior/find_potential_targets/fleshmind/pick_final_target(datum/ai_controller/controller, list/filtered_targets)
	. = ..()
	SEND_SIGNAL(controller.pawn, COSMIG_CONTROLLER_SET_TARGET)


