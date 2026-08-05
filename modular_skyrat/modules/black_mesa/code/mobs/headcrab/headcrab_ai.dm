/datum/ai_controller/basic_controller/headcrab
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_BASIC_MOB_CURRENT_TARGET = null,
		BB_BASIC_MOB_MELEE_ATTACK_RANGE = 0,  // No melee attacks
		BB_BASIC_MOB_CURRENT_TARGET_HIDING = FALSE,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT  // Allow targeting of unconscious people
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/headcrab_hunt
	)

/// Handles the headcrab's hunting behavior, trying to leap at targets when in range
/datum/ai_planning_subtree/headcrab_hunt
	/// Time between jump attempts
	var/jump_cooldown_time = 1 SECONDS  // Reduced cooldown for more frequent jumps
	COOLDOWN_DECLARE(jump_cooldown)

	/// Preferred range to start jumping
	var/preferred_jump_range = 4
	/// Maximum range at which we can leap
	var/max_jump_range = 10  // Increased range for better mobility

/datum/ai_planning_subtree/headcrab_hunt/SelectBehaviors(datum/ai_controller/controller, delta_time)
	. = ..()
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return

	var/mob/living/living_pawn = controller.pawn
	if(QDELETED(living_pawn))
		return

	if(!COOLDOWN_FINISHED(src, jump_cooldown))
		return

	var/distance = get_dist(living_pawn, target)

	// Step back to avoid attacking from standing on the corpse.
	if(target.stat >= HARD_CRIT && distance == 0)
		var/turf/away = get_step_away(living_pawn, target)
		if(away)
			living_pawn.Move(away)
		distance = get_dist(living_pawn, target)

	// Always jump at target if in range
	if(distance <= max_jump_range)
		COOLDOWN_START(src, jump_cooldown, jump_cooldown_time)
		// Telegraph the jump with sound
		playsound(living_pawn, 'modular_skyrat/modules/black_mesa/sound/mobs/headcrab/attack2.ogg', 50, TRUE)

		// Calculate jump speed based on distance - faster at close range for better accuracy
		var/jump_speed = 3
		if(distance <= 3)
			jump_speed = 4 // Faster at close range
		else if(distance >= 7)
			jump_speed = 2 // Slower at long range

		addtimer(CALLBACK(src, PROC_REF(execute_jump), living_pawn, target, distance, jump_speed), 0.3 SECONDS)
