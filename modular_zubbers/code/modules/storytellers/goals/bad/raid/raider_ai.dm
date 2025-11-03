// Raider AI controller for coordinated raiding behavior
/datum/ai_controller/basic_controller/raider
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "Reinforcements incoming!",
		BB_RAIDER_STRIKE_POINT = null,
		BB_RAIDER_ATTACK_METHOD = list(
			/datum/ai_behavior/basic_melee_attack
		),
		BB_RAIDER_INTERESTING_ITEMS = list(
			/obj/item/stack/spacecash,
			/obj/item/stack/sheet,
			/obj/item/gun),
		BB_RAIDER_INTERESTING_TARGETS = list(),
		BB_RAIDER_MY_ROLE = BB_RAIDER_ROLE_MEMBER, // Default role
		BB_RAIDER_VALUABLE_OBJECTS = list( // Subtypes too
			/obj/machinery/rnd/production/protolathe,
			/obj/machinery/rnd/production/protolathe/department,
		),
		BB_RAIDER_HIGH_VALUE_AREAS = list(
			/area/station/command/bridge,
			/area/station/engineering/lobby,
			/area/station/security/lockers,
			/area/station/medical/medbay/central,
			/area/station/science/lobby,
		),
		BB_RAIDER_TEAM = null, // Ref to the raider team datum
		BB_RAIDER_REACH_STRIKE_POINT = FALSE,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	max_target_distance = 100

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/raider_group_formation,
		/datum/ai_planning_subtree/return_to_leader,
		/datum/ai_planning_subtree/raider_strike_point_selection,
		/datum/ai_planning_subtree/raider_coordinated_movement,
		/datum/ai_planning_subtree/raider_attacking_en_route,
		/datum/ai_planning_subtree/raider_looting,
		/datum/ai_planning_subtree/raider_sabotage,
		/datum/ai_planning_subtree/protect_team,
		/datum/ai_planning_subtree/raider_hold_position_at_strike,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)

/datum/ai_movement/jps/long_range
	max_pathing_attempts = 50
	maximum_length = 120
	diagonal_flags = DIAGONAL_DO_NOTHING

// Group formation subtree - finds nearby raiders, elects a leader, updates members, and assigns roles
/datum/ai_planning_subtree/raider_group_formation
	var/max_group_size = 5

/datum/ai_planning_subtree/raider_group_formation/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return
	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		// No team, create a new one and try to form a group
		team = new /datum/raider_team()
		controller.set_blackboard_key(BB_RAIDER_TEAM, team)
		team.leader = pawn
		controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_LEADER)

		// Look for nearby raiders without a team to add
		var/list/nearby_raiders = list()
		for(var/mob/living/basic/trooper/nearby in oview(7, pawn))
			if(nearby.ai_controller?.type == /datum/ai_controller/basic_controller/raider && nearby.stat != DEAD)
				var/datum/raider_team/nearby_team = nearby.ai_controller.blackboard[BB_RAIDER_TEAM]
				if(!nearby_team)
					nearby_raiders += nearby

		var/list/new_members = list()
		for(var/mob/living/member in nearby_raiders)
			if(length(new_members) >= max_group_size - 1)
				break
			new_members += member
			member.ai_controller.set_blackboard_key(BB_RAIDER_TEAM, team)
			RegisterSignal(member, COMSIG_LIVING_DEATH, TYPE_PROC_REF(/datum/raider_team, on_member_death))

		team.members = new_members
		team.AssignRoles()
		return

	// Check leader status
	var/mob/living/leader = team.leader
	if(!leader || leader.stat == DEAD)
		// Elect a new leader among nearby team members
		var/list/candidates = list(pawn)
		for(var/mob/living/member in oview(7, pawn))
			if(istype(member.ai_controller, /datum/ai_controller/basic_controller/raider))
				var/datum/raider_team/other = member.ai_controller.blackboard[BB_RAIDER_TEAM]
				if(other == team)
					candidates += member

		if(length(candidates) < 1)
			return // No candidates, stay as is

		var/mob/living/best_leader = pawn
		var/best_score = pawn.health
		for(var/mob/living/candidate in candidates)
			var/score = candidate.health + (10 - get_dist(pawn, candidate)) // Health + proximity bonus
			if(score > best_score)
				best_score = score
				best_leader = candidate

		team.leader = best_leader
		best_leader.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_LEADER)
		// Reset roles for others if needed
		for(var/mob/living/cand in candidates)
			if(cand != best_leader)
				cand.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_MEMBER)

		// New leader assigns roles
		if(best_leader == pawn)
			team.AssignRoles()

	else
		// Has leader
		if(get_dist(pawn, leader) > 10)
			// Too far, leave team
			controller.clear_blackboard_key(BB_RAIDER_TEAM)
			controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_MEMBER)
			team.members -= pawn
			UnregisterSignal(pawn, COMSIG_LIVING_DEATH)
		else
			if(leader == pawn)
				// Update members as leader
				var/list/current_members = team.members.Copy()
				for(var/mob/living/member in current_members)
					if(!member || member.stat == DEAD || get_dist(pawn, member) > 10)
						team.members -= member
						if(member?.ai_controller)
							member.ai_controller.clear_blackboard_key(BB_RAIDER_TEAM)
							member.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_MEMBER)
						UnregisterSignal(member, COMSIG_LIVING_DEATH)

				// Add new members
				for(var/mob/living/basic/trooper/nearby in oview(7, pawn))
					if(nearby.ai_controller?.type == /datum/ai_controller/basic_controller/raider && nearby != pawn)
						var/datum/raider_team/nearby_team = nearby.ai_controller.blackboard[BB_RAIDER_TEAM]
						if(!nearby_team && length(team.members) < max_group_size - 1)
							team.members += nearby
							nearby.ai_controller.set_blackboard_key(BB_RAIDER_TEAM, team)
							RegisterSignal(nearby, COMSIG_LIVING_DEATH, TYPE_PROC_REF(/datum/raider_team, on_member_death))
				team.AssignRoles()


/datum/ai_planning_subtree/return_to_leader
	var/max_distance_to_leader = 7

/datum/ai_planning_subtree/return_to_leader/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/pawn = controller.pawn
	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return
	var/mob/living/leader = team.leader
	if(!leader)
		return
	if(pawn != leader)
		// Followers stay close to leader
		if(get_dist(pawn, leader) > max_distance_to_leader)
			controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, leader)
			controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)


// Strike point selection subtree - chooses a high-value target area (only for leader)
/datum/ai_planning_subtree/raider_strike_point_selection
	var/search_range = 40
	var/search_cooldown_time = 10 SECONDS

	COOLDOWN_DECLARE(search_cooldown)

/datum/ai_planning_subtree/raider_strike_point_selection/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return
	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return
	// Only leaders select strike points
	if(team.leader != pawn)
		return
	if(controller.blackboard[BB_RAIDER_REACH_STRIKE_POINT] == TRUE)
		return
	var/turf/current_strike = team.strike_point
	if(current_strike)
		if(get_dist(pawn, current_strike) <= 5) // Reached strike point, but hold before new one
			return // Defer to hold subtree
		else
			return // Still en route

	if(COOLDOWN_FINISHED(src, search_cooldown))
		PickStrikePoint(controller, team)
		COOLDOWN_START(src, search_cooldown, search_cooldown_time)

/datum/ai_planning_subtree/raider_strike_point_selection/proc/PickStrikePoint(datum/ai_controller/controller, datum/raider_team/team)
	var/mob/living/pawn = controller.pawn
	var/list/valuable_areas = controller.blackboard[BB_RAIDER_HIGH_VALUE_AREAS]
	var/list/valuable_types = controller.blackboard[BB_RAIDER_VALUABLE_OBJECTS]
	var/list/valuable_objects = controller.blackboard[BB_RAIDER_VALUABLE_OBJECTS]
	if(!length(valuable_areas) || !length(valuable_objects))
		return

	// Find nearby high-value areas
	var/area/selected_area
	for(var/area/area_of_interest in get_areas_in_range(search_range, pawn))
		for(var/value_area in valuable_areas)
			if(istype(area_of_interest, value_area))
				selected_area = area_of_interest
				break
		if(selected_area)
			break

	// If no nearby area, find the nearest global high-value area
	if(!selected_area)
		var/area/closest_area
		var/min_dist = world.maxx
		for(var/area/A in GLOB.areas)
			for(var/value_area in valuable_areas)
				if(istype(A, value_area))
					var/list/area_turfs = get_area_turfs(A)
					if(!length(area_turfs))
						continue
					var/turf/area_turf = pick(area_turfs)
					var/dist = get_dist(pawn, area_turf)
					if(dist < min_dist)
						min_dist = dist
						closest_area = A
					break
		if(closest_area)
			selected_area = closest_area

	if(!selected_area)
		return

	// Within the selected area, find valuable objects (e.g., protolathes)
	var/list/possible_targets = list()
	for(var/obj/machinery/M in selected_area.contents)
		for(var/valuable_target in valuable_objects)
			if(istype(M, valuable_types))
				possible_targets += M
				break

	var/turf/chosen_target
	if(length(possible_targets))
		chosen_target = get_turf(pick(possible_targets))
	else
		// No valuable objects, pick a random turf in the area
		var/list/area_turfs = get_area_turfs(selected_area)
		if(length(area_turfs))
			shuffle(area_turfs)
			for(var/turf/turf as anything in area_turfs)
				if(isopenturf(turf) && !isspaceturf(turf))
					chosen_target = turf
					break

	if(chosen_target)
		team.set_strike_point(chosen_target)
		team.current_objective = "strike"


// Coordinated movement subtree - leader always goes to target, others follow but attack en route without leaving leader alone
/datum/ai_planning_subtree/raider_coordinated_movement

/datum/ai_planning_subtree/raider_coordinated_movement/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return

	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return

	var/atom/strike_point = team.strike_point
	if(!strike_point)
		return

	var/reach_point = controller.blackboard[BB_RAIDER_REACH_STRIKE_POINT] || FALSE
	var/mob/living/leader = team.leader

	if(leader == pawn)
		// Leader always moves towards strike point
		controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, strike_point)
	else if(leader)
		// Followers move towards strike point but stay close to leader
		if(get_dist(pawn, leader) > 3 && !reach_point)
			controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, leader)

/mob/living/basic/carp

// Attacking en route subtree - attack nearby enemies while moving, but members check distance to leader
/datum/ai_planning_subtree/raider_attacking_en_route

/datum/ai_planning_subtree/raider_attacking_en_route/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return

	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return

	var/mob/living/leader = team.leader
	if(!leader)
		return

	// Check for nearby enemies
	var/list/enemies = list()
	for(var/mob/living/target in oview(5, pawn))
		if(!pawn.faction_check_atom(target, FALSE) && target.stat != DEAD)
			enemies += target

	if(length(enemies))
		// For non-leaders, only attack if not too far from leader
		if(pawn != leader && get_dist(pawn, leader) > 5)
			return SUBTREE_RETURN_FINISH_PLANNING
		var/mob/living/target = pick(enemies)
		controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
		var/list/attack_methods = controller.blackboard[BB_RAIDER_ATTACK_METHOD]
		if(length(attack_methods))
			var/datum/ai_behavior/attack_way = pick(attack_methods)
			controller.queue_behavior(attack_way, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETING_STRATEGY)

	var/turf/strike_point = controller.blackboard[BB_RAIDER_STRIKE_POINT]
	if(QDELETED(strike_point))
		return
	var/turf/next_step = get_step_towards(pawn, strike_point)
	if (!next_step.is_blocked_turf(exclude_mobs = TRUE, source_atom = pawn))
		return
	controller.queue_behavior(/datum/ai_behavior/attack_obstructions, BB_RAIDER_STRIKE_POINT)


// Looting subtree - looters pick up valuable items
/datum/ai_planning_subtree/raider_looting

/datum/ai_planning_subtree/raider_looting/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn || controller.blackboard[BB_RAIDER_MY_ROLE] != BB_RAIDER_ROLE_LOOTER || !length(controller.blackboard[BB_RAIDER_INTERESTING_ITEMS]))
		return

	// Look for items to loot
	var/list/lootable_items = list()
	for(var/obj/item/I in oview(3, pawn))
		if(I.type in controller.blackboard[BB_RAIDER_INTERESTING_ITEMS])
			if(!I.anchored && I.w_class <= WEIGHT_CLASS_NORMAL)
				lootable_items += I

	if(length(lootable_items))
		var/obj/item/target_item = pick(lootable_items)
		controller.queue_behavior(/datum/ai_behavior/pick_up_item, target_item)

// Sabotage subtree - saboteurs damage machinery and structures
/datum/ai_planning_subtree/raider_sabotage

/datum/ai_planning_subtree/raider_sabotage/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn || controller.blackboard[BB_RAIDER_MY_ROLE] != BB_RAIDER_ROLE_SABOTEUR)
		return

	// Look for targets to sabotage
	var/list/sabotage_targets = list()
	for(var/obj/machinery/M in oview(3, pawn))
		if(M.can_be_unfasten_wrench(null, TRUE) || M.panel_open)
			sabotage_targets += M

	for(var/obj/structure/S in oview(3, pawn))
		if(S.can_be_unfasten_wrench(null, TRUE))
			sabotage_targets += S

	if(length(sabotage_targets))
		var/atom/target = pick(sabotage_targets)
		controller.queue_behavior(/datum/ai_behavior/attack_obstructions, target)

// Protect team subtree - shooters attack enemies near looters/saboteurs
/datum/ai_planning_subtree/protect_team

/datum/ai_planning_subtree/protect_team/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn || controller.blackboard[BB_RAIDER_MY_ROLE] != BB_RAIDER_ROLE_SHOOTER)
		return

	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return

	// Find looters/saboteurs in group
	var/list/protected_members = list()
	for(var/mob/living/member in team.members)
		if(member && (member.ai_controller?.blackboard[BB_RAIDER_MY_ROLE] == BB_RAIDER_ROLE_LOOTER || member.ai_controller?.blackboard[BB_RAIDER_MY_ROLE] == BB_RAIDER_ROLE_SABOTEUR))
			protected_members += member

	// Check for enemies near protected members
	var/list/enemies = list()
	for(var/mob/living/protected in protected_members)
		for(var/mob/living/target in oview(5, protected))
			if(!pawn.faction_check_atom(target, FALSE) && target.stat != DEAD)
				enemies += target

	if(length(enemies))
		var/mob/living/target = pick(enemies)
		controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
		var/list/attack_methods = controller.blackboard[BB_RAIDER_ATTACK_METHOD]
		if(length(attack_methods))
			var/datum/ai_behavior/attack_way = pick(attack_methods)
			controller.queue_behavior(attack_way, BB_BASIC_MOB_CURRENT_TARGET)

// Hold position at strike point for a time (leader only), then clear for next
/datum/ai_planning_subtree/raider_hold_position_at_strike
	var/hold_time = 5 MINUTES
	COOLDOWN_DECLARE(hold_cooldown)

/datum/ai_planning_subtree/raider_hold_position_at_strike/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return SUBTREE_RETURN_FINISH_PLANNING
	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return SUBTREE_RETURN_FINISH_PLANNING

	var/turf/current_strike = team.strike_point
	if(!current_strike || get_dist(pawn, current_strike) <= 7)
		controller.set_blackboard_key(BB_RAIDER_REACH_STRIKE_POINT, TRUE)
		COOLDOWN_START(src, hold_cooldown, hold_time)


	if(!COOLDOWN_FINISHED(src, hold_cooldown) && controller.blackboard[BB_RAIDER_REACH_STRIKE_POINT] == TRUE && team.leader == pawn)
		// Hold time finished, clear strike point for new selection
		team.strike_point = null
		team.current_objective = null
	return SUBTREE_RETURN_FINISH_PLANNING
