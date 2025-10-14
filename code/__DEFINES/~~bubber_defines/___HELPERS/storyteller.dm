#define LOG_CATEGORY_STORYTELLER "storyteller"
#define LOG_CATEGORY_STORYTELLER_PLANNER "storyteller_planner"
#define LOG_CATEGORY_STORYTELLER_ANALYZER "storyteller_analyzer"
#define LOG_CATEGORY_STORYTELLER_BALANCER "storyteller_balancer"
#define LOG_CATEGORY_STORYTELLER_METRICS "storyteller_metrics"
#define ADMIN_CATEGORY_STORYTELLER "Admin.Storyteller"

/proc/log_storyteller(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER, text, data)

/proc/log_storyteller_planner(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_PLANNER, text, data)

/proc/log_storyteller_analyzer(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_ANALYZER, text, data)

/proc/log_storyteller_balancer(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_BALANCER, text, data)

/proc/log_storyteller_metrics(text, list/data)
	logger.Log(LOG_CATEGORY_STORYTELLER_METRICS, text, data)


/proc/pick_map_spawn_location(spawn_radius = 10, z_level)
	RETURN_TYPE(/list)

	var/list/corners = list(
		list(x=1, y=1, z=z_level),
		list(x=1, y=world.maxy, z=z_level),
		list(x=world.maxx, y=1, z=z_level),
		list(x=world.maxx, y=world.maxy, z=z_level)
	)

	var/list/selected_corner = pick(corners)
	var/turf/center_turf = locate(selected_corner["x"], selected_corner["y"], selected_corner["z"])
	if(!center_turf)
		return list()


	var/list/edge_turfs = list()
	for(var/turf/T in range(spawn_radius, center_turf))
		if(T.x == 1 || T.x == world.maxx || T.y == 1 || T.y == world.maxy)
			if(istype(T, /turf/open) && !T.density)
				edge_turfs += T

	if(!length(edge_turfs))
		edge_turfs += center_turf

	return edge_turfs
