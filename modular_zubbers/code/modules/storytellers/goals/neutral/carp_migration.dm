/datum/round_event_control/carp_migration
	id = "carp_migration"
	story_category = STORY_GOAL_NEUTRAL
	tags = STORY_TAG_WIDE_IMPACT | STORY_TAG_AFFECTS_ENVIRONMENT | STORY_TAG_ENTITIES
	typepath = /datum/round_event/carp_migration

	min_players = 5
	required_round_progress = STORY_ROUND_PROGRESSION_EARLY
	requierd_threat_level = STORY_GOAL_THREAT_ELEVATED

/datum/round_event/carp_migration
	STORYTELLER_EVENT

	allow_random = FALSE
	var/carps_to_spawn = 0


/datum/round_event/carp_migration/__setup_for_storyteller(threat_points, ...)
	. = ..()

	start_when = rand(30, 50)
	carps_to_spawn = 5 + round(threat_points / 200)

/datum/round_event/carp_migration/__start_for_storyteller()
	var/datum/space_level/zstation = SSmapping.levels_by_trait(ZTRAIT_STATION)[1]
	var/list/spawn_loc = pick_map_spawn_location(10, zstation.z_value)
	if (!spawn_loc)
		return kill()

	for(var/i = 0 to carps_to_spawn)
		var/mob/living/basic/carp/fish
		if(prob(95))
			fish = new carp_type(pick(spawn_loc))
		else
			fish = new boss_type(pick(spawn_loc))

			fishannounce(fish)

		var/z_level_key = zstation.z_value
		if (!z_migration_paths[z_level_key])
			z_migration_paths[z_level_key] = pick_carp_migration_points(z_level_key)
		if (z_migration_paths[z_level_key])
			fish.migrate_to(z_migration_paths[z_level_key])

	notify_ghosts("The school of space carp has arrived and is migrating through the station's vicinity.", pick(spawn_loc),"Lifesign Alert")
