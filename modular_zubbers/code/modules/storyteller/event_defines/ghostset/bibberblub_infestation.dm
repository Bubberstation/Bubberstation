/datum/round_event_control/bibberblub_infestation
	name = "Bibberblub Infestation"
	typepath = /datum/round_event/bibberblub_infestation
	track = EVENT_TRACK_MODERATE
	tags = list(TAG_COMMUNAL, TAG_OUTSIDER_ANTAG, TAG_TEAM_ANTAG)
	weight = 10
	max_occurrences = 2
	min_players = 10
	category = EVENT_CATEGORY_ENTITIES
	description = "Spawns a Bibberblub cocoon, ready to hatch"

/datum/round_event/bibberblub_infestation/start()
	var/turf/spawn_loc = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE)
	if(isnull(spawn_loc))
		return //Admins will have already been notified of the spawning failure at this point
	new /obj/effect/mob_spawn/ghost_role/bibberblub(spawn_loc)
	log_game("Bibberblub Cocoon was spawned via an event.")
