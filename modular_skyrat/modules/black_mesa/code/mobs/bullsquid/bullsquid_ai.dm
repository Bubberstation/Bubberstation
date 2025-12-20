/datum/ai_controller/basic_controller/bullsquid
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_MELEE_ATTACK_RANGE = 1,
		BB_BASIC_MOB_CURRENT_TARGET = null,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/bullsquid_attack,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/// Handles the bullsquid's acid spit attack based on distance.
/// Works alongside basic_melee_attack_subtree which handles biting.
/datum/ai_planning_subtree/bullsquid_attack
	COOLDOWN_DECLARE(acid_cooldown)
	/// Time between acid spit attacks
	var/acid_cooldown_time = 3 SECONDS
	/// Minimum range before we'll try to spit acid
	var/min_spit_range = 2
	/// Maximum range at which we can spit acid
	var/max_spit_range = 6

/datum/ai_planning_subtree/bullsquid_attack/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return

	var/mob/living/basic/blackmesa/xen/bullsquid/pawn = controller.pawn
	if(QDELETED(pawn))
		return

	var/distance = get_dist(pawn, target)

	// Let basic_melee_attack_subtree handle melee range combat
	if(distance <= 1)
		return

	// Try acid spit if in valid range and attack is ready
	if(distance >= min_spit_range && distance <= max_spit_range && COOLDOWN_FINISHED(src, acid_cooldown))
		controller.queue_behavior(/datum/ai_behavior/basic_ranged_attack, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETING_STRATEGY)
		COOLDOWN_START(src, acid_cooldown, acid_cooldown_time)
