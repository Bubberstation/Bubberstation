/mob/living/basic/carp/advanced/pipe_carp
	name = "carpmospheric technician"
	desc = "Ferocious, highly aggressive fish that thrives in the depths of shoddy engineering work. Drawn to poorly sealed pipes, mismatched connectors, and hastily patched atmospherics, these creatures feast on structural incompetence with alarming efficiency."
	icon = 'modular_zubbers/icons/mob/simple/pipe_carp.dmi'
	greyscale_config = null
	ai_controller = /datum/ai_controller/basic_controller/carp/pipe_carp
	var/static/list/pipes_list = typecacheof(list(/obj/machinery/atmospherics/pipe/heat_exchanging/simple))
	var/static/list/attack_whitelist = typecacheof(list(
		/obj/structure/fence,
		/obj/machinery/door,
		/obj/structure/door_assembly,
		/obj/structure/frame,
		/obj/structure/grille,
		/obj/structure/rack,
		/obj/structure/reagent_dispensers, // Carp can have a little welding fuel, as a treat
		/obj/machinery/vending,
		/obj/structure/window,
		/obj/structure/table,
		/obj/structure/closet,
	))

/mob/living/basic/carp/advanced/pipe_carp/Initialize(mapload, mob/tamer)
	. = ..()
	ai_controller.override_blackboard_key(BB_OBSTACLE_TARGETING_WHITELIST, attack_whitelist)
	ai_controller.interesting_dist = 14

/mob/living/basic/carp/advanced/pipe_carp/setup_eating()
	AddElement(/datum/element/basic_eating, food_types = pipes_list)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, pipes_list)

/datum/ai_controller/basic_controller/carp/pipe_carp
	blackboard = list(
		BB_BASIC_MOB_STOP_FLEEING = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_TARGET_PRIORITY_TRAIT = TRAIT_SCARY_FISHERMAN,
		BB_CARPS_FEAR_FISHERMAN = TRUE,
		BB_SEARCH_RANGE = 14,
		BB_EAT_FOOD_COOLDOWN = 5 MINUTES,
	)

/datum/round_event_control/carp_migration/pipe_carp
	name = "Pipe Carp"
	description = "Summons a school of supermatter loving carp."
	typepath = /datum/round_event/carp_migration/pipe_carp
	weight = 5
	max_occurrences = 1
	admin_setup = null

/datum/round_event/carp_migration/pipe_carp
	fluff_signal = "Unknown engineering entities"
	carp_type = /mob/living/basic/carp/advanced/pipe_carp
	var/turf/pipes_turf
	var/obj/effect/landmark/carpspawn/engineering

/datum/round_event/carp_migration/pipe_carp/setup()
	start_when = rand(15, 25)
	locate_supermatter_components()

/datum/round_event/carp_migration/pipe_carp/proc/locate_supermatter_components()
	var/area/sm_room = get_area_instance_from_text(/area/station/engineering/supermatter/room)
	var/obj/machinery/atmospherics/pipe/heat_exchanging/junction/pipes = locate() in sm_room
	pipes_turf = get_turf(pipes)

	if(SSmapping.current_map?.map_name == "Tramstation") // Not even carp teeth can crush rock!
		var/list/tram_helper = list("x" = 101, "y" = 70, "z" = 2)
		engineering = new(coords2turf(tram_helper))
	else
		var/list/potential_spawns = list()
		for(var/obj/effect/landmark/carpspawn/spawn_landmark in GLOB.landmarks_list)
			if(spawn_landmark.z != GLOB.main_supermatter_engine.z)
				continue
			potential_spawns += spawn_landmark
		engineering = get_closest_atom(/obj/effect/landmark/carpspawn, potential_spawns, pipes)

	message_admins("Pipe carp spawn location is [ADMIN_COORDJMP(engineering)]!")

/datum/round_event/carp_migration/pipe_carp/pick_carp_migration_points(z_level_key)
	var/travel_dir = get_dir(engineering, pipes_turf)
	var/turf/station_turf = get_ranged_target_turf(pipes_turf, travel_dir, rand(48, 64))
	var/turf/exit_turf = get_edge_target_turf(pipes_turf, travel_dir)
	return list(WEAKREF(station_turf), WEAKREF(exit_turf))

/datum/round_event/carp_migration/pipe_carp/start()
	// Stores the most recent fish we spawn
	var/mob/living/basic/carp/fish

	for(var/i in 1 to 3)
		fish = new carp_type(engineering.loc)

		var/z_level_key = "[engineering.z]"
		if (!z_migration_paths[z_level_key])
			z_migration_paths[z_level_key] = pick_carp_migration_points(z_level_key)
		if (z_migration_paths[z_level_key]) // Still possible we failed to set anything here if we're unlucky
			fish.migrate_to(z_migration_paths[z_level_key])

	fishannounce(fish)
