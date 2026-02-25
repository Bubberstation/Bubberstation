/datum/trainmap_path
	var/datum/trainmap_object/start
	var/datum/trainmap_object/end
	var/angle = 0

/datum/trainmap_path/proc/calculate_angle()
	if(!start || !end) return
	angle = SStrain_controller.global_map.calculate_angle(start.position_x, start.position_y, end.position_x, end.position_y)


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

	var/list/stations = list()
	for(var/region in SStrain_controller.region_order)
		stations += SStrain_controller.stations_by_regions[region]

	var/list/valid_stations = list()
	for(var/datum/train_station/S in stations)
		if(!S.visible || (S.station_flags & TRAINSTATION_ABSCTRACT))
			continue
		if(!S.map_object)
			continue
		valid_stations += S

	var/num = length(valid_stations)
	if(!num)
		return

	var/angle_step = 360 / num
	var/base_angle = rand(0, 359)
	var/current_idx = 0

	for(var/datum/train_station/S in valid_stations)
		current_idx++
		var/datum/trainmap_object/O = S.map_object

		var/this_angle = base_angle + (current_idx - 1) * angle_step
		var/placed = FALSE
		var/attempts = 60

		while(attempts-- && !placed)
			var/radius = rand(min_radius, max_radius)
			var/rad = this_angle * 0.0174532925 // ≈ PI/180

			var/px = center_x + radius * cos(rad)
			var/py = center_y + radius * sin(rad)

			O.set_position(px, py)

			if(!check_overlap(O))
				placed = TRUE
			else
				this_angle += rand(-3, 3)

		if(!placed)
			attempts = 60
			while(attempts--)
				O.set_position(rand(80, 920), rand(80, 920))
				var/dist = sqrt((O.position_x - center_x)**2 + (O.position_y - center_y)**2)
				if(dist >= min_radius && dist <= max_radius && !check_overlap(O))
					break
		objects += O

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
	if(abs(dx) == 0 && abs(dy) == 0) return 0

	if(abs(dx) >= abs(dy) * 1.5)
		return dx > 0 ? 0 : 180
	else if(abs(dy) >= abs(dx) * 1.5)
		return dy > 0 ? 90 : 270
	else if(dx > 0)
		return dy > 0 ? 45 : 315
	else
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

