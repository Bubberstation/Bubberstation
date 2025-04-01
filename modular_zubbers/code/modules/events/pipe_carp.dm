/mob/living/basic/carp/advanced/pipe_carp
	name = "pipe carp"
	desc = "Ferocious, highly aggressive fish that thrives in the depths of shoddy engineering work. Drawn to poorly sealed pipes, mismatched connectors, and hastily patched atmospherics, these creatures feast on structural incompetence with alarming efficiency."
	icon = 'modular_zubbers/icons/mob/simple/pipe_carp.dmi'
	greyscale_config = null
	var/static/list/pipes_list = typecacheof(list(/obj/machinery/atmospherics/pipe/heat_exchanging/simple))
	var/static/list/attack_whitelist = typecacheof(list(
		/obj/machinery/atmospherics/pipe/heat_exchanging/simple,
		/obj/machinery/door,
		/obj/structure/door_assembly,
		/obj/structure/frame,
		/obj/structure/grille,
		/obj/structure/rack,
		/obj/structure/reagent_dispensers, // Carp can have a little welding fuel, as a treat
		/obj/machinery/vending,
		/obj/structure/window,
	))

/mob/living/basic/carp/advanced/pipe_carp/Initialize(mapload, mob/tamer)
	. = ..()
	ai_controller.override_blackboard_key(BB_OBSTACLE_TARGETING_WHITELIST, attack_whitelist)
	ai_controller.interesting_dist = AI_DEFAULT_INTERESTING_DIST * 2

/mob/living/basic/carp/advanced/pipe_carp/setup_eating()
	AddElement(/datum/element/basic_eating, food_types = pipes_list)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, pipes_list)

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

/datum/round_event/carp_migration/pipe_carp/setup()
	start_when = rand(15, 25)

/datum/round_event/carp_migration/pipe_carp/start()
	var/area/sm_room = get_area_instance_from_text(/area/station/engineering/supermatter/room)
	var/obj/machinery/atmospherics/pipe/heat_exchanging/junction/pipes = locate() in sm_room
	var/list/potential_spawns = list()
	for(var/obj/effect/landmark/carpspawn/spawn_landmark in GLOB.landmarks_list)
		if(spawn_landmark.z != GLOB.main_supermatter_engine.z)
			continue
		potential_spawns += spawn_landmark

	var/obj/effect/landmark/carpspawn/pipe_carp_spawn = get_closest_atom(/obj/effect/landmark/carpspawn, potential_spawns, pipes)
	message_admins("Pipe carp spawn location is [ADMIN_LOOKUPFLW(pipe_carp_spawn)]!")

	// Stores the most recent fish we spawn
	var/mob/living/basic/carp/fish

	//for(var/obj/effect/landmark/carpspawn/spawn_point in GLOB.landmarks_list)
	for(var/i in 1 to 3)
		fish = new carp_type(pipe_carp_spawn.loc)

		var/z_level_key = "[pipe_carp_spawn.z]"
		if (!z_migration_paths[z_level_key])
			z_migration_paths[z_level_key] = pick_carp_migration_points(z_level_key)
		if (z_migration_paths[z_level_key]) // Still possible we failed to set anything here if we're unlucky
			fish.migrate_to(z_migration_paths[z_level_key])

	fishannounce(fish)
