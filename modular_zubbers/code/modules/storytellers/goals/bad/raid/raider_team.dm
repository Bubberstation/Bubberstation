// Raider team datum - stores team data and acts as initial state for the team
/datum/raider_team
	// Type path for the leader mob
	var/leader_type
	// List of type paths for member mobs
	var/list/member_types = list()
	// The type of drop pod
	var/drop_pod_style = /datum/pod_style/syndicate
	// Spawned leader instance
	var/mob/living/basic/leader
	// List of spawned member instances
	var/list/members = list()
	// Faction for the team
	var/team_faction = ROLE_SYNDICATE
	// Max members (including leader)
	var/max_team_size = 5
	// Type for reinforcement mobs
	var/reinforcement_type
	// Shared strike point
	var/turf/strike_point
	// Shared current objective
	var/current_objective
	// List of visited area types to cycle through stations
	var/list/visited_areas = list()

/datum/raider_team/New()
	..()
	// Initialize any additional setup if needed

// Deploy the team around a target turf
/datum/raider_team/proc/deploy(turf/target_turf)
	if(!target_turf)
		return

	notify_ghosts("A raider team strikes!", target_turf, "Raid")
	// Find open turfs around the target
	var/list/spawn_turfs = list()
	for(var/turf/open/open_turf in RANGE_TURFS(3, target_turf))
		spawn_turfs += open_turf
	if(!length(spawn_turfs))
		stack_trace("Raid failed to spawn at turf [target_turf]")
		return

	// Spawn leader
	var/turf/leader_turf = pick_n_take(spawn_turfs)
	var/obj/structure/closet/supplypod/leader_pod = podspawn(list(
		"target" = leader_turf,
		"path" = /obj/structure/closet/supplypod/podspawn/no_return,
		"style" = drop_pod_style,
		"spawn" = leader_type,
	))

	leader = locate(leader_type) in leader_pod.contents
	leader.faction = list(team_faction)
	leader.ai_controller = new /datum/ai_controller/basic_controller/raider(leader)
	leader.ai_controller.set_blackboard_key(BB_RAIDER_TEAM, src)
	leader.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_LEADER)
	RegisterSignal(leader, COMSIG_LIVING_DEATH, PROC_REF(on_leader_death))

	// Spawn members
	var/list/spawned_members = list()
	for(var/member_type in member_types)
		var/turf/member_turf = pick_n_take(spawn_turfs)
		var/obj/structure/closet/supplypod/member_pod = podspawn(list(
			"target" = member_turf,
			"path" = /obj/structure/closet/supplypod/podspawn/no_return,
			"style" = drop_pod_style,
			"spawn" = member_type,
		))

		var/mob/living/basic/member = locate(member_type) in member_pod.contents
		member.faction = list(team_faction)
		member.ai_controller = new /datum/ai_controller/basic_controller/raider(member)
		member.ai_controller.set_blackboard_key(BB_RAIDER_TEAM, src)
		RegisterSignal(member, COMSIG_LIVING_DEATH, PROC_REF(on_member_death))
		spawned_members += member

	members = spawned_members
	AssignRoles()

// Get team composition (list of all team mobs, including leader)
/datum/raider_team/proc/get_team_composition()
	var/list/composition = list(leader)
	composition += members
	return composition

// Summon small reinforcement (add 1-2 extra members)
/datum/raider_team/proc/summon_reinforcement(turf/spawn_turf)
	if(!spawn_turf || !leader || leader.stat == DEAD)
		return

	// Spawn 1-2 reinforcements
	var/num_reinforcements = rand(1, 2)
	for(var/i in 1 to num_reinforcements)
		var/turf/reinf_turf = pick(oview(3, spawn_turf))
		if(!istype(reinf_turf, /turf/open) || reinf_turf.density)
			continue
		var/mob/living/basic/reinf = new reinforcement_type(reinf_turf)
		reinf.faction = list(team_faction)
		reinf.ai_controller = new /datum/ai_controller/basic_controller/raider(reinf)
		reinf.ai_controller.set_blackboard_key(BB_RAIDER_TEAM, src)
		RegisterSignal(reinf, COMSIG_LIVING_DEATH, PROC_REF(on_member_death))
		members += reinf

	AssignRoles()

/datum/raider_team/proc/AssignRoles()
	var/list/roles_to_assign = list(BB_RAIDER_ROLE_SHOOTER, BB_RAIDER_ROLE_LOOTER, BB_RAIDER_ROLE_SABOTEUR)
	var/list/required_roles = list(BB_RAIDER_ROLE_LOOTER, BB_RAIDER_ROLE_SABOTEUR) // Ensure at least one looter and saboteur
	var/list/assigned = list()

	// Assign required roles first
	for(var/role in required_roles)
		if(length(members))
			var/mob/living/member = pick(members)
			member.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, role)
			assigned += member
			members -= member // Remove to avoid reassigning

	// Assign remaining roles, preferring shooter if possible
	for(var/mob/living/member in members)
		if(member?.ai_controller)
			var/role = length(roles_to_assign) ? pick(roles_to_assign) : BB_RAIDER_ROLE_SHOOTER // Prefer shooter for extras
			member.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, role)
	UpdateBehevours()

/datum/raider_team/proc/UpdateBehevours()
	if(leader)
		leader?.ai_controller.change_ai_movement_type(/datum/ai_movement/jps/long_range)
	for(var/mob/living/basic/member in members)
		member?.ai_controller.change_ai_movement_type(/datum/ai_movement/basic_avoidance)

/datum/raider_team/proc/set_strike_point(turf/target)
	if(QDELETED(target))
		return

	strike_point = target
	for(var/mob/living/basic/member in members)
		if(member.ai_controller)
			member.ai_controller.set_blackboard_key(BB_RAIDER_STRIKE_POINT, target)
			member.ai_controller.set_blackboard_key(BB_RAIDER_REACH_STRIKE_POINT, FALSE)

/datum/raider_team/proc/on_member_death(datum/source)
	SIGNAL_HANDLER
	if(!isbasicmob(source))
		return
	var/mob/living/basic/team_member = source
	members -= team_member
	if(team_member.ai_controller)
		team_member.ai_controller.clear_blackboard_key(BB_RAIDER_TEAM)
		team_member.ai_controller.set_blackboard_key(BB_RAIDER_MY_ROLE, BB_RAIDER_ROLE_MEMBER)
	UnregisterSignal(source, COMSIG_LIVING_DEATH)


/datum/raider_team/proc/on_leader_death(datum/source)
	SIGNAL_HANDLER
	leader = null
	UnregisterSignal(source, COMSIG_LIVING_DEATH)
	// Trigger group formation in members to elect new leader
	for(var/mob/living/basic/member in members)
		if(member.ai_controller)
			member.ai_controller.queue_behavior(/datum/ai_planning_subtree/raider_group_formation)


/datum/raider_team/syndicate
	leader_type = /mob/living/basic/trooper/robust/syndicate/elite
	member_types = list(
		/mob/living/basic/trooper/robust/syndicate/esword,
		/mob/living/basic/trooper/robust/syndicate/esword,
		/mob/living/basic/trooper/robust/syndicate/c20r,
		/mob/living/basic/trooper/robust/syndicate/c20r,
	)
