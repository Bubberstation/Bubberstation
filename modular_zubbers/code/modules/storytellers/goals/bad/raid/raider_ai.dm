// Raider AI controller for coordinated raiding behavior
/datum/ai_controller/basic_controller/raider
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = DEAD,
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
		BB_RAIDER_TEAM = null, // Ref to the raider team datum
		BB_RAIDER_REACH_STRIKE_POINT = FALSE,
		BB_RAIDER_DESTRUCTION_TARGET = null, // Current target for destruction
		BB_RAIDER_LOOT_TARGET = null, // Current target for looting
		BB_RAIDER_SEARCH_COOLDOWN_END = 0,
		BB_RAIDER_HOLD_COOLDOWN_END = 0,
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
			controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, leader)
		else
			if(leader == pawn)
				// Update members as leader
				var/list/current_members = team.members.Copy()
				for(var/mob/living/member in current_members)
					if(!member || member.stat == DEAD)
						team.members -= member
						if(member?.ai_controller)
							member.ai_controller.clear_blackboard_key(BB_RAIDER_TEAM)
							member.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_MEMBER)
						UnregisterSignal(member, COMSIG_LIVING_DEATH)

				// Add new members
				for(var/mob/living/basic/trooper/nearby in oview(7, pawn))
					if(istype(nearby.ai_controller?.type, /datum/ai_controller/basic_controller/raider) && nearby != pawn)
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


// Strike point selection subtree - leader selects nearest unvisited area, picks a turf or valuable object within it
/datum/ai_planning_subtree/raider_strike_point_selection
	var/search_cooldown_time = 10 SECONDS

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

	if(world.time >= controller.blackboard[BB_RAIDER_SEARCH_COOLDOWN_END])
		PickStrikePoint(controller, team)
		controller.set_blackboard_key(BB_RAIDER_SEARCH_COOLDOWN_END, world.time + search_cooldown_time)

/datum/ai_planning_subtree/raider_strike_point_selection/proc/PickStrikePoint(datum/ai_controller/controller, datum/raider_team/team)
	var/mob/living/pawn = controller.pawn
	var/list/valuable_types = controller.blackboard[BB_RAIDER_VALUABLE_OBJECTS]
	var/area/current_area = get_area(pawn)

	// Find the nearest unvisited area (excluding current)
	var/area/selected_area
	var/min_dist = INFINITY
	for(var/area/A in get_areas_in_range(40, pawn))
		if(A == current_area || (A.type in team.visited_areas))
			continue
		var/list/area_turfs = get_area_turfs(A)
		if(!length(area_turfs))
			continue
		var/turf/area_turf = pick(area_turfs)
		var/dist = get_dist(pawn, area_turf)
		if(dist < min_dist)
			min_dist = dist
			selected_area = A

	// If all areas visited, reset visited_areas to cycle again
	if(!selected_area)
		team.visited_areas = list()
		// Re-run selection to pick the nearest now (excluding current)
		for(var/area/A in GLOB.areas)
			if(A == current_area)
				continue
			var/list/area_turfs = get_area_turfs(A)
			if(!length(area_turfs))
				continue
			var/turf/area_turf = pick(area_turfs)
			var/dist = get_dist(pawn, area_turf)
			if(dist < min_dist)
				min_dist = dist
				selected_area = A

	if(!selected_area)
		return

	// Within the selected area, find valuable objects or a random turf
	var/list/possible_targets = list()
	for(var/obj/machinery/M in selected_area.contents)
		for(var/valuable_type in valuable_types)
			if(istype(M, valuable_type))
				possible_targets += M
				break

	var/turf/chosen_target
	if(length(possible_targets))
		chosen_target = get_turf(pick(possible_targets))
	else
		// No valuable objects, pick a random open turf in the area
		var/list/area_turfs = get_area_turfs(selected_area)
		if(length(area_turfs))
			shuffle(area_turfs)
			for(var/turf/turf as anything in area_turfs)
				if(isopenturf(turf) && !isspaceturf(turf) && !turf.density)
					chosen_target = turf
					break

	if(chosen_target)
		team.set_strike_point(chosen_target)
		team.current_objective = "strike"


// Coordinated movement subtree - leader moves to strike point (with JPS pathing including door breaking), team follows leader
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
		// Leader moves towards strike point using JPS for long-range pathing, will handle obstructions en route
		// Leader checks if team is close; if not, waits or moves slower
		var/all_close = TRUE
		for(var/mob/living/member in team.members)
			if(get_dist(pawn, member) > 5)
				all_close = FALSE
				break
		if(all_close)
			controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, strike_point)
		else
			// Wait for team to catch up
			controller.queue_behavior(/datum/ai_behavior/idle_until_target_close, team.members[1]) // Idle until a straggler is close, adjust as needed
	else if(leader)
		// Followers move towards leader to stay together
		if(get_dist(pawn, leader) > 3 && !reach_point)
			controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, leader)
		else
			controller.queue_behavior(/datum/ai_behavior/travel_towards_atom, strike_point)



// Attacking en route subtree - attack nearby enemies while moving, but members check distance to leader; also break doors/obstructions
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

	if(pawn != leader && get_dist(pawn, leader) > 7)
		// If too far from leader, cancel current tasks and return
		controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)

	// Check for nearby enemies
	var/list/enemies = list()
	for(var/mob/living/target in oview(5, pawn))
		if(!pawn.faction_check_atom(target, FALSE) && target.stat != DEAD)
			enemies += target

	if(length(enemies))
		if(pawn != leader && get_dist(pawn, leader) < 10)
			var/mob/living/target = pick(enemies)
			controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
			var/list/attack_methods = controller.blackboard[BB_RAIDER_ATTACK_METHOD]
			if(length(attack_methods))
				var/datum/ai_behavior/attack_way = pick(attack_methods)
				controller.queue_behavior(attack_way, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETING_STRATEGY)


	var/atom/target_point = team.strike_point
	if(pawn != leader)
		target_point = leader // Members focus on path to leader if following
	if(QDELETED(target_point))
		return
	var/turf/next_step = get_step_towards(pawn, target_point)
	if(iswallturf(next_step))
		controller.queue_behavior(/datum/ai_behavior/plant_c4, next_step)
		return SUBTREE_RETURN_FINISH_PLANNING

	for(var/atom/obstruction in next_step.get_all_contents())
		if(obstruction.density)
			controller.queue_behavior(/datum/ai_behavior/basic_melee_attack, obstruction)
			return SUBTREE_RETURN_FINISH_PLANNING


// Looting subtree - looters pick up valuable items, using BB_RAIDER_LOOT_TARGET
/datum/ai_planning_subtree/raider_looting

/datum/ai_planning_subtree/raider_looting/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn || controller.blackboard[BB_RAIDER_MY_ROLE] != BB_RAIDER_ROLE_LOOTER || !length(controller.blackboard[BB_RAIDER_INTERESTING_ITEMS]))
		return

	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return
	var/mob/living/leader = team.leader
	if(!leader || get_dist(pawn, leader) > 7)
		// If too far from leader, cancel looting
		controller.clear_blackboard_key(BB_RAIDER_LOOT_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	// Look for items to loot or use existing target
	var/atom/target_item = controller.blackboard[BB_RAIDER_LOOT_TARGET]
	if(QDELETED(target_item))
		var/list/lootable_items = list()
		for(var/obj/item/I in oview(3, pawn))
			if(I.type in controller.blackboard[BB_RAIDER_INTERESTING_ITEMS])
				if(!I.anchored && I.w_class <= WEIGHT_CLASS_NORMAL)
					lootable_items += I

		if(length(lootable_items))
			target_item = pick(lootable_items)
			controller.set_blackboard_key(BB_RAIDER_LOOT_TARGET, target_item)

	var/should_finish = FALSE
	if(target_item)
		controller.queue_behavior(/datum/ai_behavior/pick_up_item, BB_RAIDER_LOOT_TARGET)
		should_finish = TRUE
	else
		controller.clear_blackboard_key(BB_RAIDER_LOOT_TARGET)
	if(should_finish)
		return SUBTREE_RETURN_FINISH_PLANNING
// Sabotage subtree - saboteurs damage machinery and structures, using BB_RAIDER_DESTRUCTION_TARGET
/datum/ai_planning_subtree/raider_sabotage

/datum/ai_planning_subtree/raider_sabotage/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn || controller.blackboard[BB_RAIDER_MY_ROLE] != BB_RAIDER_ROLE_SABOTEUR)
		return

	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return
	var/mob/living/leader = team.leader
	if(!leader || get_dist(pawn, leader) > 7)
		// If too far from leader, cancel sabotage
		controller.clear_blackboard_key(BB_RAIDER_DESTRUCTION_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	// Look for targets to sabotage or use existing target
	var/atom/target = controller.blackboard[BB_RAIDER_DESTRUCTION_TARGET]
	if(QDELETED(target))
		var/list/sabotage_targets = list()
		for(var/obj/machinery/M in oview(3, pawn))
			if(M.can_be_unfasten_wrench(null, TRUE) || M.panel_open)
				sabotage_targets += M

		for(var/obj/structure/S in oview(3, pawn))
			if(S.can_be_unfasten_wrench(null, TRUE))
				sabotage_targets += S

		if(length(sabotage_targets))
			target = pick(sabotage_targets)
			controller.set_blackboard_key(BB_RAIDER_DESTRUCTION_TARGET, target)

	var/should_finish = FALSE
	if(target)
		controller.queue_behavior(/datum/ai_behavior/attack_obstructions, BB_RAIDER_DESTRUCTION_TARGET)
		should_finish = TRUE
	else
		controller.clear_blackboard_key(BB_RAIDER_DESTRUCTION_TARGET)

	if(should_finish)
		return SUBTREE_RETURN_FINISH_PLANNING

// Protect team subtree - shooters attack enemies near looters/saboteurs
/datum/ai_planning_subtree/protect_team

/datum/ai_planning_subtree/protect_team/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn || controller.blackboard[BB_RAIDER_MY_ROLE] != BB_RAIDER_ROLE_SHOOTER)
		return

	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return

	var/mob/living/leader = team.leader
	if(!leader || get_dist(pawn, leader) > 7)
		// If too far from leader, cancel protection tasks
		controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

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
	return SUBTREE_RETURN_FINISH_PLANNING

// Hold position at strike point for a time (leader only), then mark area as visited and clear for next
/datum/ai_planning_subtree/raider_hold_position_at_strike
	var/hold_time = 2 MINUTES

/datum/ai_planning_subtree/raider_hold_position_at_strike/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/pawn = controller.pawn
	if(!pawn)
		return SUBTREE_RETURN_FINISH_PLANNING
	var/datum/raider_team/team = controller.blackboard[BB_RAIDER_TEAM]
	if(!team)
		return SUBTREE_RETURN_FINISH_PLANNING

	var/turf/current_strike = team.strike_point
	if(!current_strike || get_dist(pawn, current_strike) > 7)
		return SUBTREE_RETURN_FINISH_PLANNING

	controller.set_blackboard_key(BB_RAIDER_REACH_STRIKE_POINT, TRUE)
	if(controller.blackboard[BB_RAIDER_HOLD_COOLDOWN_END] <= world.time)
		controller.set_blackboard_key(BB_RAIDER_HOLD_COOLDOWN_END, world.time + hold_time)

	if(world.time >= controller.blackboard[BB_RAIDER_HOLD_COOLDOWN_END] && controller.blackboard[BB_RAIDER_REACH_STRIKE_POINT] == TRUE && team.leader == pawn)
		// Hold time finished, mark area as visited, clear strike point for new selection
		var/area/current_area = get_area(current_strike)
		if(current_area && !(current_area.type in team.visited_areas))
			team.visited_areas += current_area.type
		team.strike_point = null
		team.current_objective = null
		controller.set_blackboard_key(BB_RAIDER_REACH_STRIKE_POINT, FALSE)
		// Clear targets
		controller.clear_blackboard_key(BB_RAIDER_DESTRUCTION_TARGET)
		controller.clear_blackboard_key(BB_RAIDER_LOOT_TARGET)
		for(var/mob/living/member in team.members)
			if(member.ai_controller)
				member.ai_controller.clear_blackboard_key(BB_RAIDER_DESTRUCTION_TARGET)
				member.ai_controller.clear_blackboard_key(BB_RAIDER_LOOT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

// Behavior for planting C4 on a target wall
/datum/ai_behavior/plant_c4
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH
	required_distance = 1

/datum/ai_behavior/plant_c4/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/pawn = controller.pawn
	var/turf/target = controller.blackboard[target_key]
	if(!target || !istype(target, /turf/closed/wall))
		finish_action(controller, FALSE)
		return


	var/obj/item/grenade/c4/c4 = locate() in pawn.contents
	if(!c4)
		c4 = new /obj/item/grenade/c4(pawn)

	if(c4)
		c4.plant_c4(target, pawn)
		finish_action(controller, TRUE)
	else
		finish_action(controller, FALSE)

/datum/ai_behavior/plant_c4/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)

// New behavior for idling until a target is close (for leader waiting)
/datum/ai_behavior/idle_until_target_close
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/idle_until_target_close/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if(get_dist(pawn, target) <= 3)
		finish_action(controller, TRUE)

/datum/ai_behavior/idle_until_target_close/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
