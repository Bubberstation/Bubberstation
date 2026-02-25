/proc/cmp_threat_level_asc(datum/train_station/A, datum/train_station/B)
	var/numA = SStrain_controller.threat_levels_by_number[A.threat_level] || 0
	var/numB = SStrain_controller.threat_levels_by_number[B.threat_level] || 0
	return numA - numB

/datum/trainmap_path
	var/datum/trainmap_object/start
	var/datum/trainmap_object/end
	var/angle = 0

/datum/trainmap_path/proc/calculate_angle()
	if(!start || !end)
		return
	angle = SStrain_controller.global_map.calculate_angle(
		start.position_x, start.position_y,
		end.position_x, end.position_y
	)

/datum/trainmap_object
	var/name = "Map object"
	var/desc = "Generic object"
	var/datum/train_station/associated_station

	var/position_x = 0
	var/position_y = 0
	var/angle = 0

/datum/trainmap_object/proc/set_position(x, y)
	position_x = x
	position_y = y

/datum/train_global_map
	var/list/objects = list()
	var/list/paths = list()
	var/datum/trainmap_object/train_position

	var/center_x = 500
	var/center_y = 500
	var/min_radius = 280
	var/max_radius = 420

/datum/train_global_map/New()
	. = ..()
	train_position = new /datum/trainmap_object()
	train_position.name = "Поезд"
	train_position.desc = "Текущая позиция состава"

/datum/train_global_map/proc/generate()
	objects.Cut()
	paths.Cut()

	if(!length(SStrain_controller.region_order))
		SStrain_controller.connect_stations()

	var/list/valid_stations = list()
	for(var/datum/train_station/S in SStrain_controller.known_stations)
		if(!S.visible || (S.station_flags & TRAINSTATION_ABSCTRACT) || !S.map_object)
			continue
		valid_stations += S

	if(!length(valid_stations))
		return

	var/list/local_centers = list()
	for(var/datum/train_station/S in valid_stations)
		if(S.station_flags & TRAINSTATION_LOCAL_CENTER)
			local_centers += S

	local_centers = sortTim(local_centers, GLOBAL_PROC_REF(cmp_threat_level_asc))

	var/center_angle_step = 360 / max(1, length(local_centers))
	var/base_center_angle = rand(0, 359)

	for(var/i in 1 to length(local_centers))
		var/datum/train_station/lc = local_centers[i]
		var/datum/trainmap_object/O = lc.map_object

		var/threat_num = SStrain_controller.threat_levels_by_number[lc.threat_level] || 0
		var/threat_factor = threat_num / 4.0

		var/hub_radius = min_radius + (max_radius - min_radius) * (0.35 + 0.55 * threat_factor)

		var/this_angle = base_center_angle + (i - 1) * center_angle_step + rand(-15, 15)

		var/rad = this_angle * 0.0174532925
		var/px = center_x + hub_radius * cos(rad)
		var/py = center_y + hub_radius * sin(rad)

		O.set_position(px, py)

		var/attempts = 25
		while(attempts-- && check_overlap(O))
			this_angle += rand(-12, 12)
			rad = this_angle * 0.0174532925
			px = center_x + hub_radius * cos(rad)
			py = center_y + hub_radius * sin(rad)
			O.set_position(px, py)

		objects += O

	var/list/region_to_hub = list()
	for(var/datum/train_station/lc in local_centers)
		region_to_hub[lc.region] = lc

	for(var/datum/train_station/S in valid_stations)
		if(S.station_flags & TRAINSTATION_LOCAL_CENTER)
			continue

		var/datum/trainmap_object/O = S.map_object
		var/datum/train_station/parent_hub = region_to_hub[S.region]

		var/placed = FALSE
		var/attempts = 60

		if(parent_hub)
			var/datum/trainmap_object/H = parent_hub.map_object
			while(attempts--)
				var/offset_angle = rand(0, 359) * 0.0174532925
				var/offset_dist = 45 + rand(25, 135)   // плотный кластер
				var/px = H.position_x + offset_dist * cos(offset_angle)
				var/py = H.position_y + offset_dist * sin(offset_angle)

				px += rand(-28, 28)
				py += rand(-28, 28)

				O.set_position(px, py)

				if(!check_overlap(O))
					placed = TRUE
					break
		else
			while(attempts--)
				var/px = rand(80, 920)
				var/py = rand(80, 920)
				O.set_position(px, py)

				var/dist = sqrt((px - center_x)**2 + (py - center_y)**2)
				if(dist >= min_radius * 0.5 && dist <= max_radius && !check_overlap(O))
					placed = TRUE
					break

		if(!placed)
			O.set_position(rand(120, 880), rand(120, 880))

		objects += O

	for(var/datum/train_station/S in valid_stations)
		S.possible_next.Cut()

	for(var/datum/train_station/S in valid_stations)
		if(S.station_flags & TRAINSTATION_NO_FORKS)
			continue

		var/is_hub = (S.station_flags & TRAINSTATION_LOCAL_CENTER)
		var/max_dist = is_hub ? 340 : 230
		var/max_count = is_hub ? rand(4, 6) : rand(2, 4)

		var/list/nearest = get_nearest_stations(S.map_object, max_dist, max_count)

		for(var/datum/trainmap_object/NO in nearest)
			var/datum/train_station/NS = NO.associated_station
			if(NS && NS != S)
				S.possible_next += NS

	ensure_fully_connected()

	for(var/datum/train_station/S in valid_stations)
		var/datum/trainmap_object/O = S.map_object
		for(var/datum/train_station/NS in S.possible_next)
			if(!NS.visible || (NS.station_flags & TRAINSTATION_ABSCTRACT))
				continue
			var/datum/trainmap_object/TO = NS.map_object
			if(TO && !has_path_between(O, TO))
				var/datum/trainmap_path/P = new()
				P.start = O
				P.end = TO
				P.calculate_angle()
				paths += P

	update_train_position()

	for(var/datum/train_station/station in SStrain_controller.known_stations)
		station.connect_stations()

/datum/train_global_map/proc/get_nearest_stations(datum/trainmap_object/center, max_dist = 250, max_count = 4)
	var/list/cands = list()
	for(var/datum/trainmap_object/O in objects)
		if(O == center)
			continue
		var/dx = O.position_x - center.position_x
		var/dy = O.position_y - center.position_y
		var/dist = sqrt(dx*dx + dy*dy)
		if(dist <= max_dist && dist > 10)
			cands[O] = dist

	if(!length(cands))
		return list()

	cands = sortTim(cands, GLOBAL_PROC_REF(cmp_numeric_asc), associative = TRUE)

	var/list/result = list()
	for(var/i in 1 to min(max_count, length(cands)))
		result += cands[i]
	return result

/datum/train_global_map/proc/ensure_fully_connected()
	var/list/graph = build_graph()
	var/list/components = get_connected_components(graph)

	if(length(components) <= 1)
		return

	for(var/i in 1 to length(components)-1)
		var/list/compA = components[i]
		var/list/compB = components[i+1]

		var/min_dist = 999999
		var/datum/trainmap_object/bestA
		var/datum/trainmap_object/bestB

		for(var/datum/trainmap_object/A in compA)
			for(var/datum/trainmap_object/B in compB)
				var/dx = A.position_x - B.position_x
				var/dy = A.position_y - B.position_y
				var/d = sqrt(dx*dx + dy*dy)
				if(d < min_dist)
					min_dist = d
					bestA = A
					bestB = B

		if(bestA && bestB)
			var/datum/train_station/sA = bestA.associated_station
			var/datum/train_station/sB = bestB.associated_station
			if(sA && sB)
				if(!(sA.station_flags & TRAINSTATION_NO_FORKS) && !sA.possible_next.Find(sB))
					sA.possible_next += sB
				if(!(sB.station_flags & TRAINSTATION_NO_FORKS) && !sB.possible_next.Find(sA))
					sB.possible_next += sA

/datum/train_global_map/proc/build_graph()
	var/list/graph = list()
	for(var/datum/trainmap_object/O in objects)
		graph[O] = list()

	for(var/datum/train_station/S in SStrain_controller.known_stations)
		if(!S.map_object)
			continue
		var/datum/trainmap_object/O = S.map_object
		for(var/datum/train_station/NS in S.possible_next)
			var/datum/trainmap_object/TO = NS.map_object
			if(TO)
				graph[O] += TO
				if(!(TO in graph)) graph[TO] = list()
				graph[TO] += O
	return graph

/datum/train_global_map/proc/get_connected_components(list/graph)
	var/list/visited = list()
	var/list/components = list()

	for(var/datum/trainmap_object/O in graph)
		if(!visited[O])
			var/list/component = list()
			dfs(O, graph, visited, component)
			components += list(component)
	return components

/datum/train_global_map/proc/dfs(datum/trainmap_object/node, list/graph, list/visited, list/component)
	visited[node] = TRUE
	component += node
	for(var/datum/trainmap_object/neigh in graph[node])
		if(!visited[neigh])
			dfs(neigh, graph, visited, component)

/datum/train_global_map/proc/check_overlap(datum/trainmap_object/new_obj)
	for(var/datum/trainmap_object/O in objects)
		var/dx = new_obj.position_x - O.position_x
		var/dy = new_obj.position_y - O.position_y
		if(sqrt(dx*dx + dy*dy) < 110)
			return TRUE
	return FALSE

/datum/train_global_map/proc/has_path_between(datum/trainmap_object/A, datum/trainmap_object/B)
	for(var/datum/trainmap_path/P in paths)
		if((P.start == A && P.end == B) || (P.start == B && P.end == A))
			return TRUE
	return FALSE

/datum/train_global_map/proc/calculate_angle(sx, sy, ex, ey)
	var/dx = ex - sx
	var/dy = ey - sy
	if(!dx && !dy)
		return 0
	if(abs(dx) >= abs(dy) * 1.5)
		return dx > 0 ? 0 : 180
	else if(abs(dy) >= abs(dx) * 1.5)
		return dy > 0 ? 90 : 270
	else if(dx > 0)
		return dy > 0 ? 45 : 315
	return dy > 0 ? 135 : 225

/datum/train_global_map/proc/update_train_position()
	if(!SStrain_controller.is_moving() || !SStrain_controller.loaded_station)
		var/datum/trainmap_object/obj = SStrain_controller.loaded_station?.map_object
		train_position.set_position(obj?.position_x || center_x, obj?.position_y || center_y)
		train_position.angle = 0
		return

	var/datum/trainmap_object/start_obj = SStrain_controller.loaded_station.map_object
	var/datum/trainmap_object/end_obj = SStrain_controller.planned_to_load?.map_object

	if(!start_obj || !end_obj)
		return

	var/progress = 1 - (SStrain_controller.time_to_next_station / max(SStrain_controller.total_travel_time, 1))

	train_position.set_position(
		start_obj.position_x + (end_obj.position_x - start_obj.position_x) * progress,
		start_obj.position_y + (end_obj.position_y - start_obj.position_y) * progress
	)

	train_position.angle = calculate_angle(start_obj.position_x, start_obj.position_y, end_obj.position_x, end_obj.position_y)

/datum/train_global_map/proc/get_ui_data()
	var/list/data = list()

	var/list/obj_list = list()
	for(var/datum/trainmap_object/O in objects)
		obj_list += list(list(
			"id" = "[O.associated_station.type]",
			"name" = O.name,
			"desc" = O.desc,
			"region" = O.associated_station?.region || "Unknown",
			"x" = O.position_x,
			"y" = O.position_y,
			"is_current" = (O == SStrain_controller.loaded_station?.map_object),
			"is_next" = (O == SStrain_controller.planned_to_load?.map_object),
			"visited" = O.associated_station?.visited || 0,
			"is_local_center" = (O.associated_station?.station_flags & TRAINSTATION_LOCAL_CENTER),
		))

	data["objects"] = obj_list

	var/list/path_list = list()
	for(var/datum/trainmap_path/P in paths)
		path_list += list(list(
			"start_x" = P.start.position_x,
			"start_y" = P.start.position_y,
			"end_x" = P.end.position_x,
			"end_y" = P.end.position_y,
			"angle" = P.angle
		))
	data["paths"] = path_list

	data["train"] = list(
		"x" = train_position.position_x,
		"y" = train_position.position_y,
		"angle" = train_position.angle
	)

	data["width"] = 1000
	data["height"] = 1000
	return data


/mob/living/simple_animal/hostile/megafauna
