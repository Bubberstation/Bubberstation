/**
 * AI controller for houndeye basic mob
 * Handles charging behavior and basic targeting
 */
/datum/ai_controller/basic_controller/houndeye
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_LOW_PRIORITY_HUNTING_TARGET = null,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/houndeye,
		/datum/ai_planning_subtree/target_retaliate
	)

/**
 * Custom melee attack subtree for houndeye that includes charging
 */
/datum/ai_planning_subtree/basic_melee_attack_subtree/houndeye
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/houndeye

/**
 * Custom melee attack behavior that includes sonic blast
 */
/datum/ai_behavior/basic_melee_attack/houndeye
	action_cooldown = 50 // Longer cooldown between sonic blasts
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT
	required_distance = 5

/datum/ai_behavior/basic_melee_attack/houndeye/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	var/mob/living/basic/blackmesa/xen/houndeye/living_pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]

	if(QDELETED(target))
		finish_action(controller, FALSE)
		return

	if(living_pawn.charging_sonic || world.time < living_pawn.next_sonic_blast)
		return

	// Attempt to use sonic blast if possible
	if(can_sonic_blast(living_pawn, target))
		living_pawn.charging_sonic = TRUE
		living_pawn.next_sonic_blast = world.time + action_cooldown
		do_sonic_blast(living_pawn, target)
		finish_action(controller, TRUE)
		return

	return ..() // Otherwise do normal melee attack

/**
 * Check if we can use sonic blast on the target
 */
/datum/ai_behavior/basic_melee_attack/houndeye/proc/can_sonic_blast(mob/living/basic/blackmesa/xen/houndeye/living_pawn, atom/target)
	if(!isliving(target))
		return FALSE

	var/dist = get_dist(living_pawn, target)
	if(dist <= 5 && dist > 1) // Use sonic blast at medium range
		return TRUE
	return FALSE

/**
 * Perform the sonic blast attack
 */
/datum/ai_behavior/basic_melee_attack/houndeye/proc/do_sonic_blast(mob/living/basic/blackmesa/xen/houndeye/living_pawn, atom/target)
	// Start charging and prevent movement
	living_pawn.face_atom(target)
	living_pawn.set_anchored(TRUE)

	living_pawn.visible_message(span_warning("[living_pawn] begins to charge up energy!"))
	playsound(living_pawn, pick(living_pawn.charge_sounds), 100, TRUE)

	// Visual effect for charging
	var/obj/effect/temp_visual/spirit_hound_charge/charge_effect = new(living_pawn.loc)
	charge_effect.attached_mob = living_pawn

	// After a delay, release the blast
	addtimer(CALLBACK(src, PROC_REF(release_sonic_blast), living_pawn, target), 1.5 SECONDS)

	// Reset anchoring and state after the blast
	addtimer(CALLBACK(src, PROC_REF(reset_movement), living_pawn), 1.5 SECONDS)

/**
 * Helper proc to reset movement restrictions
 */
/datum/ai_behavior/basic_melee_attack/houndeye/proc/reset_movement(mob/living/basic/blackmesa/xen/houndeye/living_pawn)
	if(QDELETED(living_pawn))
		return
	living_pawn.set_anchored(FALSE)
	living_pawn.charging_sonic = FALSE

/**
 * Release the charged up sonic blast
 */
/datum/ai_behavior/basic_melee_attack/houndeye/proc/release_sonic_blast(mob/living/basic/blackmesa/xen/houndeye/living_pawn, atom/target)
	if(QDELETED(living_pawn) || QDELETED(target))
		return

	// Create the blast effect
	var/list/turfs_to_hit = list()

	// Get turfs in a cone shape in front of the houndeye
	for(var/turf/T in view(4, living_pawn))
		if(get_dist(living_pawn, T) > 4)
			continue
		if(angle2dir_cardinal(get_angle(living_pawn, T)) != living_pawn.dir)
			continue
		turfs_to_hit += T
		new /obj/effect/temp_visual/sonicblast(T)

	// Deal damage to everything in the blast
	for(var/turf/T in turfs_to_hit)
		for(var/mob/living/L in T)
			if(L == living_pawn)
				continue
			var/dist_mod = 1 - (get_dist(living_pawn, L) / 5) // Less damage at max range
			var/damage = round(15 * dist_mod) // Base 15 damage, reduced by distance
			L.apply_damage(damage, BRUTE)
			L.apply_damage(damage, STAMINA) // Add stamina damage
			if(prob(50))
				L.Knockdown(10) // Shorter knockdown, 50% chance
			to_chat(L, span_warning("You're hit by [living_pawn]'s sonic blast!"))

		// Break windows and weak objects, but less severely
		for(var/obj/O in T)
			if(istype(O, /obj/structure/window))
				O.take_damage(30)
			else if(istype(O, /obj/structure/table) || istype(O, /obj/structure/rack))
				O.take_damage(10)

	// Play the blast sound
	playsound(living_pawn, 'sound/effects/explosion/explosioncreak2.ogg', 100, TRUE)
	living_pawn.visible_message(span_danger("[living_pawn] releases a powerful sonic blast!"))
