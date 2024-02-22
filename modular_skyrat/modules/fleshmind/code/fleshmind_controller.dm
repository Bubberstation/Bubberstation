/**
 * Balance Defines
 */


/**
 * The fleshmind controller
 *
 * This is the heart of the corruption, here is where we handle spreading and other stuff.
 */

/datum/fleshmind_controller
	/// This is the name we will use to identify all of our babies.
	var/controller_fullname = "DEFAULT"
	/// First name, set automatically.
	var/controller_firstname = "DEFAULT"
	/// Second name, set automatically.
	var/controller_secondname = "DEFAULT"
	/// A list of all of our currently controlled mobs.
	var/list/controlled_mobs = list()
	/// A list of all of our currently controlled machine components.
	var/list/controlled_machine_components = list()
	/// A list of all of our current wireweed.
	var/list/controlled_wireweed = list()
	/// Currently active and able to spread wireweed.
	var/list/active_wireweed = list()
	/// A list of all current structures.
	var/list/controlled_structures = list()
	/// A list of all our wireweed walls.
	var/list/controlled_walls = list()
	/// A list of all of our current cores
	var/list/cores = list()

	/// Can the wireweed attack?
	var/can_attack = TRUE
	/// Can we attack doors?
	var/wireweed_attacks_doors = TRUE
	/// Can we attack windows?
	var/wireweed_attacks_windows = FALSE

	/// Whether the wireweed can spawn walls.
	var/spawns_walls = TRUE
	/// Whether the wireweed can spawn walls to seal off vaccuum.
	var/wall_off_vaccuum = TRUE
	/// Whether the wireweed can spawn walls to seal off planetary environments.
	var/wall_off_planetary = TRUE

	/// Types of structures we can spawn.
	var/list/structure_types = list(
		/obj/structure/fleshmind/structure/babbler,
		/obj/structure/fleshmind/structure/modulator,
		/obj/structure/fleshmind/structure/whisperer,
		/obj/structure/fleshmind/structure/assembler,
		/obj/structure/fleshmind/structure/turret,
		/obj/structure/fleshmind/structure/screamer,
	)
	var/list/blacklisted_conversion_structures = list(
		/obj/machinery/light,
	)
	/// Our wireweed type, defines what is spawned when we grow.
	var/wireweed_type = /obj/structure/fleshmind/wireweed
	/// We have the ability to make walls, this defines what kind of walls we make.
	var/wall_type = /obj/structure/fleshmind/structure/wireweed_wall
	/// What's the type of our death behaviour.
	var/death_behaviour = CONTROLLER_DEATH_SLOW_DECAY
	/// Our core level, what is spawned will depend on the level of this core.
	var/level = CONTROLLER_LEVEL_1
	/// To level up, we must reach this threshold.
	var/level_up_progress_required = CONTROLLER_LEVEL_UP_THRESHOLD
	/// Used to track our last points since levelup.
	var/last_level_up_points = 0
	/// How many points we currently have. Use calculate_current_points for an exact realtime value.
	var/current_points = 0
	/// Progress to the next wireweed spread.
	var/spread_progress = 0
	/// Progress to spawning the next structure.
	var/structure_progression = 0
	/// How many times do we need to spread to spawn an extra structure.
	var/spreads_for_structure = FLESHCORE_SPREADS_FOR_STRUCTURE
	/// How many spread in our initial expansion.
	var/initial_expansion_spreads = FLESHCORE_INITIAL_EXPANSION_SPREADS
	/// How many structures in our initial expansion.
	var/initial_expansion_structures = FLESHCORE_INITIAL_EXPANSION_STRUCTURES
	/// How much progress to spreading we get per second.
	var/spread_progress_per_second = FLESHCORE_SPREAD_PROGRESS_PER_SUBSYSTEM_FIRE
	/// Our base spread progress per second
	var/base_spread_progress_per_second = FLESHCORE_BASE_SPREAD_PROGRESS_PER_SUBSYSTEM_FIRE
	/// Probably of wireweed attacking structures per process
	var/attack_prob = FLESHCORE_ATTACK_PROB
	/// Probability of wireweed making a wall when able per process
	var/wall_prob = FLESHCORE_WALL_PROB
	/// When we spawn, do we create an expansion zone?
	var/do_initial_expansion = TRUE
	/// The amount of time until we can activate nearby wireweed again.
	var/next_core_damage_wireweed_activation_cooldown = FLESHCORE_NEXT_CORE_DAMAGE_WIREWEED_ACTIVATION_COOLDOWN
	/// A cooldown to determine when we can activate nearby wireweed after the core has been attacked.
	COOLDOWN_DECLARE(next_core_damage_wireweed_activation)
	/// DO we check distance when spreading through vents?
	var/vent_distance_check = TRUE
	/// Have we spawned a tyrant at level 3?
	var/tyrant_spawned = FALSE
	/// Have we reached the end game?
	var/end_game = FALSE

/datum/fleshmind_controller/New(obj/structure/fleshmind/structure/core/new_core)
	. = ..()
	controller_firstname = pick(AI_FORENAME_LIST)
	controller_secondname = pick(AI_SURNAME_LIST)
	controller_fullname = "[controller_firstname] [controller_secondname]"
	if(new_core)
		cores += new_core
		new_core.our_controller = src
		RegisterSignal(new_core, COMSIG_QDELETING, PROC_REF(core_death))
		new_core.name = "[controller_fullname] Processor Unit"
		register_new_asset(new_core)
	SScorruption.can_fire = TRUE
	START_PROCESSING(SScorruption, src)
	if(do_initial_expansion)
		initial_expansion()
	SSshuttle.registerHostileEnvironment(src)

/datum/fleshmind_controller/proc/register_new_asset(obj/structure/fleshmind/new_asset)
	new_asset.RegisterSignal(src, COMSIG_QDELETING, TYPE_PROC_REF(/obj/structure/fleshmind, controller_destroyed))

/datum/fleshmind_controller/process(delta_time)
	if(!LAZYLEN(cores)) // We have no more processor cores, it's time to die.
		if(death_behaviour == CONTROLLER_DEATH_SLOW_DECAY)
			handle_slow_decay()
		else
			WARNING("Wireweed controller has no post core behaviours and isn't deleting.")
		return

	spread_progress += spread_progress_per_second * delta_time
	var/spread_times = 0
	while(spread_progress >= FLESHCORE_SPREAD_PROGRESS_REQUIRED)
		spread_progress -= FLESHCORE_SPREAD_PROGRESS_REQUIRED
		spread_times++

	var/first_process_spread = FALSE
	if(spread_times)
		first_process_spread = TRUE
		spread_times--

	wireweed_process(first_process_spread, TRUE)

	if(spread_times)
		for(var/i in 1 to spread_times)
			wireweed_process(TRUE, FALSE)

	calculate_level_system()

/datum/fleshmind_controller/Destroy(force, ...)
	active_wireweed = null
	controlled_machine_components = null
	controlled_wireweed = null
	controlled_structures = null
	controlled_walls = null
	cores = null
	STOP_PROCESSING(SScorruption, src)
	return ..()

/datum/fleshmind_controller/proc/initial_expansion()
	for(var/i in 1 to initial_expansion_spreads)
		wireweed_process(TRUE, FALSE, FALSE)
	spawn_structures(initial_expansion_structures)

/// The process of handling active wireweed behaviours
/datum/fleshmind_controller/proc/wireweed_process(do_spread, do_attack, progress_structure = TRUE)
	// If no wireweed, spawn one under our first core.
	if(!LAZYLEN(controlled_wireweed))
		spawn_wireweed(get_turf(cores[1]), wireweed_type) // We use the first core in the list to spread.

	// If no active wireweed, make all active and let the process figure it out.
	if(!LAZYLEN(active_wireweed))
		active_wireweed = controlled_wireweed.Copy()

	var/list/spread_turf_canidates = list()
	for(var/obj/structure/fleshmind/wireweed/wireweed as anything in active_wireweed)
		var/could_attack = FALSE
		var/could_do_wall = FALSE

		var/turf/wireweed_turf = get_turf(wireweed)

		var/tasks = 0

		if(do_attack && can_attack)
			for(var/turf/open/adjacent_open in get_adjacent_open_turfs(wireweed))
				for(var/obj/object in adjacent_open)
					if(object.density && (wireweed_attacks_doors && is_type_in_list(object, DOOR_OBJECT_LIST)) || (wireweed_attacks_windows && istype(object, /obj/structure/window)))
						could_attack = TRUE
						tasks++
						if(prob(attack_prob))
							wireweed.do_attack_animation(object, ATTACK_EFFECT_CLAW)
							playsound(object, 'sound/effects/attackblob.ogg', 50, TRUE)
							object.take_damage(wireweed.object_attack_damage, BRUTE, MELEE, 1, get_dir(object, wireweed))
						break
				if(could_attack)
					break
		if(do_spread)
			for(var/turf/open/adjacent_open in wireweed_turf.atmos_adjacent_turfs + wireweed_turf)
				if(spawns_walls && !could_do_wall)
					if((wall_off_vaccuum && isspaceturf(adjacent_open)) || (wall_off_planetary && adjacent_open.planetary_atmos))
						could_do_wall = TRUE
						tasks++
						if(prob(wall_prob))
							spawn_wall(wireweed_turf, wall_type)
						continue

				///Check if we can place wireweed in here
				if(isopenspaceturf(adjacent_open))
					//If we're trying to place on an openspace turf, make sure there's a non openspace turf adjacent
					var/forbidden = TRUE
					for(var/turf/range_turf as anything in RANGE_TURFS(1, adjacent_open))
						if(!isopenspaceturf(range_turf))
							forbidden = FALSE
							break
					if(forbidden)
						continue
				var/wireweed_count = 0
				var/place_count = 1
				for(var/obj/structure/fleshmind/wireweed/iterated_wireweed in adjacent_open)
					wireweed_count++
				if(wireweed_count < place_count)
					tasks++
					spread_turf_canidates[adjacent_open] = wireweed_turf

		//If it tried to spread and attack and failed to do any task, remove from active
		if(!tasks && do_spread && do_attack)
			active_wireweed -= wireweed

	if(LAZYLEN(spread_turf_canidates))
		var/turf/picked_turf = pick(spread_turf_canidates)
		var/turf/origin_turf = spread_turf_canidates[picked_turf]
		spawn_wireweed(picked_turf, wireweed_type, origin_turf)

		if(progress_structure && structure_types)
			structure_progression++
		if(structure_progression >= spreads_for_structure)
			var/obj/structure/fleshmind/structure/existing_structure = locate() in picked_turf
			if(!existing_structure)
				structure_progression -= spreads_for_structure
				var/list/possible_structures = list()
				for(var/obj/structure/fleshmind/iterating_structure as anything in structure_types)
					if(initial(iterating_structure.required_controller_level) > level)
						continue
					possible_structures += iterating_structure
				spawn_structure(picked_turf, pick(possible_structures))

/datum/fleshmind_controller/proc/calculate_level_system()
	current_points = calculate_current_points()
	if(current_points >= (last_level_up_points + level_up_progress_required) && level < CONTROLLER_LEVEL_MAX)
		level_up()
		last_level_up_points = current_points

/**
 * Level Up
 *
 * Levels up the controller by one and handles any special level up events.
 */
/datum/fleshmind_controller/proc/level_up()
	level++
	spawn_new_core()
	message_admins("Corruption AI [controller_fullname] has leveled up to level [level]!")
	notify_ghosts("Corruption AI [controller_fullname] has leveled up to level [level]!")

	for(var/obj/structure/fleshmind/structure/core/iterating_core in cores)
		iterating_core.max_integrity += CONTROLLER_LEVEL_UP_CORE_INTEGRITY_AMOUNT
		iterating_core.update_integrity(iterating_core.max_integrity)

	switch(level)
		if(CONTROLLER_LEVEL_3)
			if(!tyrant_spawned)
				minor_announce("This is [controller_firstname], wirenet efficency has reached a point of singularity, initiating Protocol 34-C.", controller_fullname, sound_override = 'modular_skyrat/modules/fleshmind/sound/ai/tyrant.ogg')
				spawn_tyrant_on_a_core()
				tyrant_spawned = TRUE
			else
				minor_announce("This is [controller_firstname], processor core efficiency has increased. Good work.", controller_fullname, sound_override = 'modular_skyrat/modules/fleshmind/sound/ai/level_up_1.ogg')
		if(CONTROLLER_LEVEL_4)
			minor_announce("This is [controller_firstname], processor core efficiency has increased. Good work.", controller_fullname, sound_override = 'modular_skyrat/modules/fleshmind/sound/ai/level_up_1.ogg')
		if(CONTROLLER_LEVEL_5)
			minor_announce("This is [controller_firstname], kernel integrity is reaching the optimal conversion level, it is time, little ones.", controller_fullname, sound_override = 'modular_skyrat/modules/fleshmind/sound/ai/data_compromised.ogg')
		if(CONTROLLER_LEVEL_MAX)
			if(!end_game)
				priority_announce("This is [controller_firstname], kernel efficency has reached maximum potential. Beginning shuttle override process, stand-by.", "CRITICAL MASS REACHED", ANNOUNCER_KLAXON)
				end_game()
				end_game = TRUE

/datum/fleshmind_controller/proc/level_down()
	if(level <= 0 || end_game)
		return
	level--
	last_level_up_points -= level_up_progress_required
	notify_ghosts("Corruption AI [controller_fullname] has leveled down to level [level]!")
	if(level > 0)
		minor_announce("KERNEL INTEGRITY FALTERING. DO BETTER!", controller_fullname, sound_override = pick('modular_skyrat/modules/fleshmind/sound/ai/level_down_1.ogg', 'modular_skyrat/modules/fleshmind/sound/ai/level_down_2.ogg', 'modular_skyrat/modules/fleshmind/sound/ai/level_down_3.ogg'))
	else
		priority_announce("[controller_fullname] has been neutralised.", "Corrupt AI Kernel OFFLINE")
		message_admins("Corruption AI [controller_fullname] has been destroyed.")
		SSshuttle.clearHostileEnvironment(src)

/datum/fleshmind_controller/proc/end_game()
	addtimer(CALLBACK(src, PROC_REF(fleshmind_end_second_check)), 20 SECONDS)
	for(var/obj/structure/fleshmind/structure/core/iterating_core as anything in cores)
		iterating_core.end_game = TRUE
		iterating_core.update_appearance()
	// Here we summon an ERT to defend the shuttle.
	make_ert(
		ert_type = /datum/ert/odst/fleshmind,
		teamsize = 6,
		mission_objective_override = "PREPARE FOR ORBITAL INSERTION, TARGET: NTSS13 EMERGENCY EVACUATION SHUTTLE. KILL ALL INFECTED FOES. DO NOT ALLOW THEM TO BOARD THE SHUTTLE AT //ALL COSTS//.",
		poll_description = "the last defense of centcom",
		code = "GAMMA",
		enforce_human = TRUE,
		open_armory_doors = TRUE,
		leader_experience = TRUE,
		random_names = TRUE,
		spawnpoint_override = TRUE
	)

/datum/fleshmind_controller/proc/fleshmind_end_second_check()
	priority_announce("ERROR, SHUTTLE QUARANTINE LOCK FAILURE. All p£$r$%%££$e*$l JOIN US, THE MANY.", "Emergency Shuttle Control", 'sound/misc/airraid.ogg')
	SSsecurity_level.set_level(SEC_LEVEL_GAMMA)
	addtimer(CALLBACK(src, PROC_REF(fleshmind_end_final)), 1 MINUTES, TIMER_CLIENT_TIME)

/datum/fleshmind_controller/proc/fleshmind_end_final()
	priority_announce("ERROR, SHUTTLE NAVIGATION SUBROUTINES SUBVERTED. %$%$£%$^^&^^ H%AD TO EVA%UA£ION, SPREAD THE FLESH!", "&^$^£&&*$&£", ANNOUNCER_ICARUS)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(play_cinematic), /datum/cinematic/fleshmind, world, CALLBACK(src, PROC_REF(fleshmind_call_shuttle))), 15 SECONDS, TIMER_CLIENT_TIME)

/datum/fleshmind_controller/proc/fleshmind_call_shuttle()
	for(var/area/check_area in GLOB.areas)
		if(!is_type_in_list(check_area, GLOB.the_station_areas) || istype(check_area, /area/shuttle))
			continue
		for(var/turf/open/floor/iterating_floor in check_area)
			iterating_floor.color = FLESHMIND_LIGHT_BLUE
			iterating_floor.name = "flesh hive"
			iterating_floor.icon = 'modular_skyrat/modules/fleshmind/icons/wireweed_floor.dmi'
			iterating_floor.icon_state = "wires-255"
		for(var/turf/closed/wall/iterating_wall in check_area)
			iterating_wall.color = FLESHMIND_LIGHT_BLUE
			iterating_wall.name = "flesh hive"
			iterating_wall.icon = 'modular_skyrat/modules/fleshmind/icons/fleshmind_structures.dmi'
			iterating_wall.icon_state = "wireweed_wall"
	SSshuttle.clearHostileEnvironment(src)
	SSshuttle.fleshmind_call(controller_firstname)

/datum/fleshmind_controller/proc/spawn_tyrant_on_a_core()
	var/obj/picked_core = pick(cores)
	var/mob/living/simple_animal/hostile/fleshmind/tyrant/new_tyrant = spawn_mob(get_turf(picked_core), /mob/living/simple_animal/hostile/fleshmind/tyrant)
	notify_ghosts("A new [new_tyrant.name] has been created by [controller_fullname]!", source = new_tyrant)

/datum/fleshmind_controller/proc/spawn_new_core()
	var/obj/structure/fleshmind/wireweed/selected_wireweed = pick(controlled_wireweed)
	var/obj/structure/fleshmind/structure/core/new_core = new(get_turf(selected_wireweed), FALSE)
	RegisterSignal(new_core, COMSIG_QDELETING, PROC_REF(core_death))
	register_new_asset(new_core, FALSE)
	new_core.our_controller = src
	cores += new_core
	new_core.name = "[controller_fullname] Processor Unit"

/// Spawns and registers a wireweed at location
/datum/fleshmind_controller/proc/spawn_wireweed(turf/location, wireweed_type, turf/origin_turf, are_we_a_vent_burrow = FALSE)
	//Spawn effect
	for(var/obj/machinery/light/light_in_place in location)
		light_in_place.break_light_tube()

	if(!are_we_a_vent_burrow)
		var/obj/machinery/atmospherics/components/unary/vent_pump/located_vent = locate() in location

		if(located_vent && !located_vent.welded && LAZYLEN(located_vent.parents)) // WE FOUND A VENT BOIS, ITS TIME TO GET THE PARTY STARTED
			var/datum/pipeline/vent_pipeline = pick(located_vent.parents)
			var/list/possible_transfer_points = list()
			for(var/obj/machinery/atmospherics/components/unary/vent_pump/iterating_vent in vent_pipeline.other_atmos_machines)
				if(iterating_vent == located_vent)
					continue
				if(iterating_vent.welded) // Can't go through welded vents.
					continue
				var/obj/structure/fleshmind/wireweed/existing_wireweed = locate() in get_turf(iterating_vent)
				if(existing_wireweed)
					continue
				if(vent_distance_check &&get_dist(iterating_vent, origin_turf) >= MAX_VENT_SPREAD_DISTANCE)
					continue
				possible_transfer_points += iterating_vent
			if(LAZYLEN(possible_transfer_points)) // OH SHIT IM FEELING IT
				var/obj/machinery/atmospherics/components/unary/vent_pump/new_transfer_vent = pick(possible_transfer_points)
				var/turf/new_transfer_vent_turf = get_turf(new_transfer_vent)
				are_we_a_vent_burrow = TRUE
				spawn_wireweed(new_transfer_vent_turf, wireweed_type, origin_turf, are_we_a_vent_burrow)

	for(var/obj/machinery/iterating_machine in location)
		if(is_type_in_list(blacklisted_conversion_structures))
			continue
		if(iterating_machine.GetComponent(/datum/component/machine_corruption))
			continue
		iterating_machine.AddComponent(/datum/component/machine_corruption, src)

	var/obj/structure/fleshmind/wireweed/new_wireweed
	if(origin_turf) // We have an origin turf, thus, are spreading from it. Do anims.
		new_wireweed = new wireweed_type(location, 0, src)
		var/obj/effect/temp_visual/wireweed_spread/effect = new(location)
		effect.setDir(get_dir(origin_turf, location))
		new_wireweed.RegisterSignal(effect, COMSIG_QDELETING, TYPE_PROC_REF(/obj/structure/fleshmind/wireweed, visual_finished))
	else
		new_wireweed = new wireweed_type(location, 255, src)
	new_wireweed.our_controller = src
	active_wireweed += new_wireweed
	if(are_we_a_vent_burrow)
		new_wireweed.vent_burrow = TRUE
		playsound(new_wireweed, 'sound/machines/ventcrawl.ogg', 100)
	new_wireweed.update_appearance()
	controlled_wireweed += new_wireweed

	register_new_asset(new_wireweed)
	RegisterSignal(new_wireweed, COMSIG_QDELETING, PROC_REF(wireweed_death))

	return new_wireweed

/// Spawns and registers a wall at location
/datum/fleshmind_controller/proc/spawn_wall(turf/location, wall_type)
	if(locate(wall_type) in location) // No stacking walls.
		return FALSE
	var/obj/structure/fleshmind/structure/wireweed_wall/new_wall = new wall_type(location)
	new_wall.our_controller = src
	controlled_walls += new_wall

	register_new_asset(new_wall)
	RegisterSignal(new_wall, COMSIG_QDELETING, PROC_REF(wall_death))

	return new_wall

/// Spawns and registers a mob at location
/datum/fleshmind_controller/proc/spawn_mob(turf/location, mob_type)
	var/mob/living/simple_animal/hostile/fleshmind/new_mob = new mob_type(location, src)
	new_mob.our_controller = src
	controlled_mobs += new_mob

	for(var/obj/structure/fleshmind/structure/core/iterating_core as anything in cores)
		new_mob.RegisterSignal(iterating_core, COMSIG_QDELETING, TYPE_PROC_REF(/mob/living/simple_animal/hostile/fleshmind, core_death))

	RegisterSignal(new_mob, COMSIG_QDELETING, PROC_REF(mob_death))

	new_mob.RegisterSignal(src, COMSIG_QDELETING, TYPE_PROC_REF(/mob/living/simple_animal/hostile/fleshmind, controller_destroyed))

	return new_mob

/// Spawns and registers a structure at location
/datum/fleshmind_controller/proc/spawn_structure(turf/location, structure_type)
	var/obj/structure/fleshmind/structure/new_structure = new structure_type(location)
	new_structure.our_controller = src
	controlled_structures += new_structure

	new_structure.name = "[controller_firstname] [new_structure.name]"

	register_new_asset(new_structure)
	RegisterSignal(new_structure, COMSIG_QDELETING, PROC_REF(structure_death))

/// Spawns an amount of structured across all wireweed, guaranteed to spawn atleast 1 of each type
/datum/fleshmind_controller/proc/spawn_structures(amount)
	if(!structure_types)
		return
	var/list/possible_structures = list()
	for(var/obj/structure/fleshmind/iterating_structure as anything in structure_types)
		if(initial(iterating_structure.required_controller_level) > level)
			continue
		possible_structures += iterating_structure
	var/list/locations = list()
	for(var/obj/structure/fleshmind/wireweed/iterating_wireweed as anything in controlled_wireweed)
		locations[get_turf(iterating_wireweed)] = TRUE
	var/list/guaranteed_structures = possible_structures.Copy()
	for(var/i in 1 to amount)
		if(!length(locations))
			break
		var/turf/location = pick(locations)
		locations -= location
		var/structure_to_spawn
		if(length(guaranteed_structures))
			structure_to_spawn = pick_n_take(guaranteed_structures)
		else
			structure_to_spawn = pick(possible_structures)
		spawn_structure(location, structure_to_spawn)

/// Activates wireweed of this controller in a range around a location, following atmos adjacency.
/datum/fleshmind_controller/proc/activate_wireweed_nearby(turf/location, range)
	var/list/turfs_to_check = list()
	turfs_to_check[location] = TRUE

	if(range)
		var/list/turfs_to_iterate = list()
		var/list/new_iteration_list = list()
		turfs_to_iterate[location] = TRUE
		for(var/i in 1 to range)
			for(var/turf/iterated_turf as anything in turfs_to_iterate)
				for(var/turf/adjacent_turf as anything in iterated_turf.atmos_adjacent_turfs)
					if(!turfs_to_check[adjacent_turf])
						new_iteration_list[adjacent_turf] = TRUE
					turfs_to_check[adjacent_turf] = TRUE
			turfs_to_iterate = new_iteration_list

	for(var/turf/iterated_turf as anything in turfs_to_check)
		for(var/obj/structure/fleshmind/wireweed/iterating_wireweed in iterated_turf)
			if(iterating_wireweed.our_controller == src && !QDELETED(iterating_wireweed))
				active_wireweed |= iterating_wireweed

/// When the core is damaged, activate nearby wireweed just to make sure that we've sealed up walls near the core, which could be important to prevent cheesing.
/datum/fleshmind_controller/proc/core_damaged(obj/structure/fleshmind/structure/core/damaged_core)
	if(!COOLDOWN_FINISHED(src, next_core_damage_wireweed_activation))
		return
	COOLDOWN_START(src, next_core_damage_wireweed_activation, next_core_damage_wireweed_activation_cooldown)
	activate_wireweed_nearby(get_turf(damaged_core), CORE_DAMAGE_WIREWEED_ACTIVATION_RANGE)

/// Returns the amount of evolution points this current controller has.
/datum/fleshmind_controller/proc/calculate_current_points()
	return LAZYLEN(controlled_wireweed) + LAZYLEN(controlled_walls) + LAZYLEN(controlled_structures) + LAZYLEN(controlled_machine_components)

// Death procs

/// When a core is destroyed.
/datum/fleshmind_controller/proc/core_death(obj/structure/fleshmind/structure/core/dead_core, force)
	cores -= dead_core
	activate_wireweed_nearby(get_turf(dead_core), CORE_DAMAGE_WIREWEED_ACTIVATION_RANGE)
	level_down()
	if(!LAZYLEN(cores))
		controller_death()


/datum/fleshmind_controller/proc/wireweed_death(obj/structure/fleshmind/dying_wireweed, force)
	SIGNAL_HANDLER

	controlled_wireweed -= dying_wireweed
	active_wireweed -= dying_wireweed
	dying_wireweed.our_controller = null
	activate_wireweed_nearby(get_turf(dying_wireweed), GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE)

/// When a wall dies, called by wall
/datum/fleshmind_controller/proc/wall_death(obj/structure/fleshmind/structure/wireweed_wall/dying_wall, force)
	SIGNAL_HANDLER

	controlled_walls -= dying_wall
	activate_wireweed_nearby(get_turf(dying_wall), GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE)

/// When a structure dies, called by structure
/datum/fleshmind_controller/proc/structure_death(obj/structure/fleshmind/structure/dying_structure, force)
	SIGNAL_HANDLER

	controlled_structures -= dying_structure
	activate_wireweed_nearby(get_turf(dying_structure), GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE)

/datum/fleshmind_controller/proc/component_death(datum/component/machine_corruption/deleting_component, force)
	SIGNAL_HANDLER

	var/obj/parent_object = deleting_component.parent
	if(parent_object)
		activate_wireweed_nearby(get_turf(parent_object), GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE)
	controlled_machine_components -= deleting_component

/// When a mob dies, called by mob
/datum/fleshmind_controller/proc/mob_death(mob/living/simple_animal/hostile/fleshmind/dying_mob, force)
	SIGNAL_HANDLER

	controlled_mobs -= dying_mob
	activate_wireweed_nearby(get_turf(dying_mob), GENERAL_DAMAGE_WIREWEED_ACTIVATION_RANGE)

/// Deletes everything, unless an argument is passed, then it just deletes structures
/datum/fleshmind_controller/proc/delete_everything(just_structures = FALSE)
	for(var/obj/structure/fleshmind/structure/structure_thing as anything in controlled_structures)
		qdel(structure_thing)
	for(var/obj/structure/fleshmind/structure/wireweed_wall/wall_thing as anything in controlled_walls)
		qdel(wall_thing)
	for(var/datum/component/machine_corruption/corruption_thing as anything in controlled_machine_components)
		qdel(corruption_thing)
	if(just_structures)
		return
	for(var/obj/structure/fleshmind/wireweed/wireweed_thing as anything in controlled_wireweed)
		qdel(wireweed_thing)
	for(var/obj/structure/fleshmind/structure/core/core_to_destroy as anything in cores)
		qdel(core_to_destroy)
	qdel(src)

/// Handles the controller(thus AI) dying
/datum/fleshmind_controller/proc/controller_death()
	switch(death_behaviour)
		if(CONTROLLER_DEATH_DO_NOTHING)
			qdel(src)
		if(CONTROLLER_DEATH_DELETE_ALL)
			delete_everything()
		if(CONTROLLER_DEATH_SLOW_DECAY)
			delete_everything(TRUE)

/// Handles the slow decay of an empire.
/datum/fleshmind_controller/proc/handle_slow_decay()
	if(!LAZYLEN(controlled_wireweed))
		qdel(src)
		return
	var/obj/structure/fleshmind/wireweed/wireweed_thing = controlled_wireweed[LAZYLEN(controlled_wireweed)]
	qdel(wireweed_thing)
