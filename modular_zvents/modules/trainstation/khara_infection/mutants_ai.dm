/datum/ai_planning_subtree/targeted_mob_ability/check_range
	var/min_range = 0
	var/max_range = 10

/datum/ai_planning_subtree/targeted_mob_ability/check_range/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/atom/target = controller.blackboard[target_key]
	if(!target || !controller.pawn)
		return
	var/distance_to_target = get_dist(controller.pawn, target)
	if(distance_to_target >= max_range || distance_to_target <= min_range)
		return
	return ..()

/datum/ai_planning_subtree/targeted_mob_ability/check_range/bone_shards
	ability_key = BB_MOB_ABILITY_BONESHARD
	min_range = 5
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/check_range/leap
	ability_key = BB_MOB_ABILITY_LEAP
	min_range = 5
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/check_range/rumble
	ability_key = BB_MOB_ABILITY_RUMBLE
	max_range = 4
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/check_range/meat_ball
	ability_key = BB_MOB_ABILITY_MEAT_BALL
	min_range = 5
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/check_range/slash
	ability_key = BB_MOB_AILITY_SLASH
	max_range = 1
	finish_planning = FALSE

/datum/ai_planning_subtree/targeted_mob_ability/check_range/charge
	ability_key = BB_MOB_ABILITY_FAST_CHARGE
	min_range = 3
	finish_planning = FALSE

/datum/ai_controller/basic_controller/corrupted_arachnid
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
	)

	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target/increased_range,
		/datum/ai_planning_subtree/clear_retaliate,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/targeted_mob_ability/arachnid_restrain,
		/datum/ai_planning_subtree/targeted_mob_ability/check_range/leap,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/ai_controller/basic_controller/khara_reaper
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
	)

	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target/increased_range,
		/datum/ai_planning_subtree/clear_retaliate,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/targeted_mob_ability/check_range/charge,
		/datum/ai_planning_subtree/targeted_mob_ability/check_range/slash,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)


/datum/ai_controller/basic_controller/boss_spreader
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/clear_retaliate,
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/targeted_mob_ability/check_range/rumble,
		/datum/ai_planning_subtree/targeted_mob_ability/check_range/meat_ball,
		/datum/ai_planning_subtree/targeted_mob_ability/check_range/bone_shards,
	)
