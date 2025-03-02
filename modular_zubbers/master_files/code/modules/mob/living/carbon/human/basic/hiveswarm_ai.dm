// needs logic for chaff
#define DANGEROUS_DELTA_P 50

/datum/ai_controller/basic_controller/hiveswarm
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_AGGRO_RANGE = 14
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/attack_obstacle_in_path/low_priority_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/ai_controller/basic_controller/hiveswarm/basic
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/find_and_hunt_target/hunt_objs_with_materials,
	)

/datum/ai_controller/basic_controller/hiveswarm/bomber
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_AGGRO_RANGE = 3
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability/continue_planning/hiveswarm_bomb
	)

/datum/ai_controller/basic_controller/hiveswarm/harvester
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/destroy_walls,
		/datum/ai_planning_subtree/targeted_mob_ability/hiveswarm_range
	)

/datum/ai_controller/basic_controller/hiveswarm/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/check_faction,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/ranged_skirmish
	)

/datum/ai_planning_subtree/targeted_mob_ability/hiveswarm_range
	ability_key = BB_HIVESWARM_LASER_ABILITY

/datum/ai_planning_subtree/targeted_mob_ability/continue_planning/hiveswarm_bomb
	ability_key = BB_HIVESWARM_BOMB_ABILITY
	use_ability_behaviour = /datum/ai_behavior/targeted_mob_ability/min_range/short

/datum/ai_planning_subtree/destroy_walls
	var/find_wall_behavior = /datum/ai_behavior/find_station_wall

/datum/ai_planning_subtree/destroy_walls/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard_key_exists(BB_TARGET_MINERAL_WALL))
		controller.queue_behavior(/datum/ai_behavior/mine_station_wall, BB_TARGET_MINERAL_WALL)
		return SUBTREE_RETURN_FINISH_PLANNING
	controller.queue_behavior(find_wall_behavior, BB_TARGET_MINERAL_WALL)

/datum/ai_behavior/mine_station_wall
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	action_cooldown = 5 SECONDS

/datum/ai_behavior/mine_station_wall/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/turf/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/mine_station_wall/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/basic/living_pawn = controller.pawn
	var/turf/closed/mineral/target = controller.blackboard[target_key]
	if(!controller.ai_interact(target = target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/mine_station_wall/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)

/datum/ai_behavior/find_station_wall
/datum/ai_behavior/find_station_wall/perform/(seconds_per_tick, datum/ai_controller/controller, found_wall_key)
	var/mob/living_pawn = controller.pawn

	for(var/turf/closed/potential_wall in oview(9, living_pawn))
		if(!validate_wall(controller, potential_wall))
			continue
		controller.set_blackboard_key(found_wall_key, potential_wall)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

/datum/ai_behavior/find_station_wall/proc/validate_wall(datum/ai_controller/controller, turf/target_wall)
	var/turf/target = target_wall
	if (!isclosedturf(target) || isindestructiblewall(target))
		return FALSE
	if(target.is_nearby_planetary_atmos())
		return FALSE
	if(target.return_turf_delta_p() >= DANGEROUS_DELTA_P)
		return FALSE
	return TRUE


/datum/ai_planning_subtree/find_and_hunt_target/hunt_objs_with_materials
	target_key = BB_OBJECT_TARGET
	hunting_behavior = /datum/ai_behavior/hunt_target/interact_with_target/hunt_ores
	finding_behavior = /datum/ai_behavior/find_hunt_target/objs_with_materials
	hunt_targets = list(/obj/item)
	hunt_range = 5

/datum/ai_behavior/find_hunt_target/objs_with_materials

/datum/ai_behavior/find_hunt_target/objs_with_materials/valid_dinner(mob/living/source, obj/item/dinner, radius, datum/ai_controller/controller, seconds_per_tick)
	if(!isturf(dinner.loc))
		return FALSE
	if(!istype(dinner))
		return FALSE
	var/list/materials = dinner.get_material_composition()
	if(!LAZYLEN(materials))
		return FALSE

	return can_see(source, dinner, radius)
