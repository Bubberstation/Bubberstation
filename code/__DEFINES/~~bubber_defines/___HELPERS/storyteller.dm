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


/proc/get_inventory(atom/holder, recursive = TRUE)
	RETURN_TYPE(/list)

	. = list()
	if(!holder || istype(holder) || !length(holder.contents))
		return .

	for(var/atom/atom in holder.contents)
		. += atom
		if(length(atom.contents) && recursive)
			. += get_inventory(atom)

	return .


/proc/is_safe_area(area/to_check)
	var/list/vents = to_check.air_vents
	var/total_vents = length(vents)
	var/unsafe_vents = 0

	var/static/list/safe_gases = list(
		/datum/gas/oxygen = list(16, 100),
		/datum/gas/nitrogen,
		/datum/gas/carbon_dioxide = list(0, 10)
	)

	for(var/obj/machinery/atmospherics/components/unary/vent_pump/vent in vents)
		var/turf/open/T = get_turf(vent)
		var/datum/gas_mixture/floor_gas_mixture = T.air
		if(!floor_gas_mixture)
			unsafe_vents += 1
			continue

		var/list/floor_gases = floor_gas_mixture.gases
		if(!check_gases(floor_gases, safe_gases))
			unsafe_vents += 1
			continue

		if((floor_gas_mixture.temperature <= 270) || (floor_gas_mixture.temperature >= 360))
			unsafe_vents += 1
			continue

		var/pressure = floor_gas_mixture.return_pressure()
		if((pressure <= 20) || (pressure >= 550))
			unsafe_vents += 1
			continue

	if(unsafe_vents >= round(total_vents * 0.5))
		return FALSE
	return TRUE
