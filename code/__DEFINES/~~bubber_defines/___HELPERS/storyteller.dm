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
	for(var/turf/TURF in range(spawn_radius, center_turf))
		if(TURF.x == 1 || TURF.x == world.maxx || TURF.y == 1 || TURF.y == world.maxy)
			if(istype(TURF, /turf/open) && !TURF.density)
				edge_turfs += TURF

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

	if(!(total_vents == 1 && unsafe_vents == 0))
		return !(unsafe_vents > round(total_vents * 0.5))
	return TRUE

/proc/pick_weight_f(list/list_to_pick)
	if(length(list_to_pick) == 0)
		return null

	var/total = 0.0
	for(var/item in list_to_pick)
		var/weight = list_to_pick[item]
		if(!isnum(weight) || weight < 0)
			list_to_pick[item] = 0
			continue
		total += weight

	if(total <= 0)
		return null


	var/list/cumulative = list()
	var/cum_sum = 0.0
	for(var/item in list_to_pick)
		var/weight = list_to_pick[item]
		if(weight <= 0)
			continue
		cum_sum += weight
		cumulative += list(list("item" = item, "cum" = cum_sum))

	if(length(cumulative) == 0)
		return null


	#define PRECISION 1000000
	var/rand_float = rand(1, PRECISION) / PRECISION
	#undef PRECISION

	var/target = rand_float * total
	for(var/entry in cumulative)
		if(entry["cum"] >= target)
			return entry["item"]

	return cumulative[cumulative.len]["item"]

/proc/get_nearest_atoms(atom/center, type = /atom/movable, range = 7)
	var/list/candidates = SSspatial_grid.orthogonal_range_search(center, SPATIAL_GRID_CONTENTS_TYPE_ATMOS, range) // Using ATMOS as example; adjust type if needed
	var/list/nearby_atoms = list()
	var/turf/center_turf = get_turf(center)
	for(var/atom/A in candidates)
		if(istype(A, type) && get_dist(center_turf, get_turf(A)) <= range)
			nearby_atoms += A
	return nearby_atoms
