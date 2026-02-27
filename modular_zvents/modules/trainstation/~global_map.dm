// Центр и размер холста карты
#define MAP_CENTER_X 500
#define MAP_CENTER_Y 500
#define MAP_MIN_RADIUS 280
#define MAP_MAX_RADIUS 420

// Шаг по вертикали между регионами и смещение веток (умеренная длина пути)
#define REGION_Y_STEP 210
#define CENTER_Y_OFFSET_MIN 75
#define CENTER_Y_OFFSET_MAX 115

// Начальное смещение ветки от центра влево/вправо
#define INITIAL_BRANCH_OFFSET_MIN 15
#define INITIAL_BRANCH_OFFSET_MAX 30

// Шаг по Y между станциями на ветке
#define BRANCH_STEP_Y_MIN 90
#define BRANCH_STEP_Y_MAX 130

// Минимальная дистанция между точками; пороги для «близких» станций
#define OVERLAP_MIN_DISTANCE 38
#define NEAR_STATION_CHECK_DIST 210
#define NEAR_STATION_SIDE_THRESHOLD 35
#define NEAR_STATION_SIDE_COUNT_THRESHOLD 18

// Остановка ветки у конечной станции; лимит итераций подбора
#define BRANCH_TOO_CLOSE_DIST 170
#define BRANCH_MAX_CANDIDATES_TRIES 100


/datum/trainmap_path
	var/datum/trainmap_object/start
	var/datum/trainmap_object/end

/proc/cmp_threat_level_asc(datum/train_station/A, datum/train_station/B)
	var/numA = SStrain_controller.threat_levels_by_number[A.threat_level] || 0
	var/numB = SStrain_controller.threat_levels_by_number[B.threat_level] || 0
	return numA - numB


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
	var/list/objects = list()           // все /datum/trainmap_object
	var/list/paths   = list()           // визуальные линии-связи

	var/list/station_to_object = list() // station → map object

	var/datum/trainmap_object/train_position

	var/center_x = MAP_CENTER_X
	var/center_y = MAP_CENTER_Y


/datum/train_global_map/New()
	. = ..()
	train_position = new /datum/trainmap_object()
	train_position.name = "Поезд"
	train_position.desc = "Текущая позиция состава"


/datum/train_global_map/proc/is_placed_on_map(datum/train_station/S)
	if(!S || !S.map_object)
		return FALSE
	if(!(S.map_object in objects))
		return FALSE
	if(station_to_object[S] != S.map_object)
		return FALSE
	return TRUE

/// Ставит станцию на карту в (x, y); при ignore_overlap не проверяет пересечение с другими точками
/datum/train_global_map/proc/place_station_on_map(datum/train_station/S, x, y, ignore_overlap = FALSE)
	if(!S || !S.map_object)
		return FALSE

	var/datum/trainmap_object/obj = S.map_object

	if(!ignore_overlap && check_overlap(obj))
		return FALSE

	obj.set_position(x, y)

	if(!(obj in objects))
		objects += obj

	if(station_to_object[S] != obj)
		station_to_object[S] = obj

	return TRUE


/datum/train_global_map/proc/remove_station_from_map(datum/train_station/S)
	if(!S || !S.map_object)
		return FALSE

	var/datum/trainmap_object/obj = S.map_object

	objects -= obj
	station_to_object -= S

	return TRUE


/datum/train_global_map/proc/remove_all_stations_from_map()
	objects.Cut()
	station_to_object.Cut()
	paths.Cut()
	train_position.set_position(center_x, center_y)
	train_position.angle = 0


/datum/train_global_map/proc/generate()
	if(!length(SStrain_controller.region_order))
		SStrain_controller.connect_stations()

	// Собираем видимые, конкретные станции с объектами карты
	var/list/valid_stations = list()
	for(var/datum/train_station/S in SStrain_controller.known_stations)
		if(!S.visible || (S.station_flags & TRAINSTATION_ABSCTRACT) || !S.map_object)
			continue
		valid_stations += S

	if(!length(valid_stations))
		return

	// Группировка по регионам
	var/list/regions_to_stations = list()
	for(var/datum/train_station/S in valid_stations)
		if(!(S.region in regions_to_stations))
			regions_to_stations[S.region] = list()
		regions_to_stations[S.region] += S

	var/list/all_centers_in_order = list()
	var/current_y = center_y
	var/datum/train_station/last_region_station = null

	for(var/region in SStrain_controller.region_order)
		var/list/region_stations = regions_to_stations[region]
		if(!length(region_stations))
			current_y += REGION_Y_STEP
			continue

		region_stations = sortTim(region_stations, GLOBAL_PROC_REF(cmp_threat_level_asc))

		var/list/local_centers = list()
		for(var/datum/train_station/ST in region_stations)
			if(ST.station_flags & TRAINSTATION_LOCAL_CENTER)
				local_centers += ST
		var/base_x = center_x
		if(last_region_station?.map_object)
			base_x = last_region_station.map_object.position_x
			current_y = last_region_station.map_object.position_y

		var/list/region_centers_placed = list()
		for(var/i in 1 to length(local_centers))
			var/datum/train_station/LC = local_centers[i]
			if(!LC.map_object)
				continue
			var/datum/trainmap_object/O = LC.map_object
			var/x = base_x + rand(-80, 80)
			var/y = current_y + REGION_Y_STEP * 2 * i
			O.set_position(x, y)
			var/tries = 30
			while(tries-- && check_overlap(O, region_centers_placed))
				x = base_x + rand(-80, 80)
				O.set_position(x, y)
			if(!place_station_on_map(LC, x, y, ignore_overlap = TRUE))
				continue
			region_centers_placed += O
			all_centers_in_order += LC

		var/list/non_centers = list() // Обычные станции не являющиеся центральными
		var/list/manul_stations = list() // Станции у которых заранее обьявлена следующая станция
		var/list/cargo_stations = list() // Специальные карго-станции

		for(var/datum/train_station/ST in region_stations)
			if(ST.station_flags & TRAINSTATION_LOCAL_CENTER)
				continue
			if(istype(ST, /datum/train_station/cargo_station))
				cargo_stations += ST
				continue
			if(!length(ST.possible_next))
				non_centers += ST
			else if(!(ST in local_centers))
				manul_stations += ST

		non_centers = shuffle(non_centers)

		// 2-3 станции из региона как переход из последнего локального центра в следующий регион
		var/list/transition_stations = list()
		var/num_trans = rand(2, 3)
		if(length(non_centers))
			num_trans = min(num_trans, length(non_centers))
			transition_stations = non_centers.Copy(1, num_trans + 1)
			non_centers.Cut(1, num_trans + 1)

		// Создаем ветки от центра к центру (используем оставшиеся обычные станции)
		for(var/i in 1 to length(all_centers_in_order)-1)
			var/datum/train_station/A = all_centers_in_order[i]
			var/datum/train_station/B = all_centers_in_order[i+1]

			if(!A.map_object || !B.map_object)
				continue

			var/list/branch = place_branch(A, B, non_centers)
			non_centers -= branch

			if(prob(35) && length(branch) >= 3 && length(non_centers) >= 2)
				var/mid_idx = round(length(branch) * 0.5) + 1
				var/datum/train_station/side_start = branch[mid_idx]
				var/list/side_branch = place_branch(side_start, B, non_centers)
				non_centers -= side_branch

		// Станции с заранее заданной следующей — ставим рядом с ней
		if(length(manul_stations))
			while(length(manul_stations))
				var/datum/train_station/station = manul_stations[1]
				var/datum/train_station/next = station.possible_next[1]
				if(!(next in region_stations) || !next.map_object)
					manul_stations -= station
					continue
				var/x = next.map_object.position_x + rand(-35, 35)
				var/y = next.map_object.position_y - rand(BRANCH_STEP_Y_MIN, BRANCH_STEP_Y_MAX)
				if(!place_station_on_map(station, x, y))
					manul_stations -= station
					continue
				manul_stations -= station

		// Переходная ветка из последнего локального центра
		if(length(transition_stations) && length(all_centers_in_order))
			var/datum/train_station/last_local = all_centers_in_order[length(all_centers_in_order)]
			place_transition_branch(last_local, transition_stations)


		var/list/possible_near_stations = list()
		for(var/datum/train_station/S in region_stations)
			if(!istype(S, /datum/train_station/cargo_station) && is_placed_on_map(S))
				possible_near_stations += S

		var/list/remaining_cargos = cargo_stations.Copy()

		// Находим конец региона
		var/datum/train_station/region_end_station = null
		var/max_yy = -INFINITY
		for(var/datum/train_station/S in region_stations)
			if(is_placed_on_map(S) && S.map_object.position_y > max_yy)
				max_yy = S.map_object.position_y
				region_end_station = S

		// Гарантируем хотя бы одну cargo в конце региона
		if(length(remaining_cargos) && region_end_station)
			var/datum/train_station/c_end = remaining_cargos[1]
			remaining_cargos -= c_end
			if(place_cargo_near(region_end_station, c_end))
				possible_near_stations += c_end
			else
				remaining_cargos += c_end

		// Остальные cargo размещаем рядом с разными станциями на разных расстояниях
		var/cargo_placement_tries = 100
		while(length(remaining_cargos) && cargo_placement_tries-- > 0 && length(possible_near_stations))
			var/datum/train_station/near_s = pick(possible_near_stations)
			var/datum/train_station/cargo = pick(remaining_cargos)
			if(place_cargo_near(near_s, cargo))
				remaining_cargos -= cargo
				possible_near_stations += cargo

		// Обновляем last_region_station на самую южную станцию региона (включая переход и cargo)
		var/datum/train_station/updated_last = null
		var/max_y = -INFINITY
		for(var/datum/train_station/S in region_stations)
			if(is_placed_on_map(S) && S.map_object.position_y > max_y)
				max_y = S.map_object.position_y
				updated_last = S
		if(updated_last)
			last_region_station = updated_last

		connect_stations(region_stations)


/datum/train_global_map/proc/place_branch(datum/train_station/start, datum/train_station/end, list/available_stations)
	var/datum/trainmap_object/center_obj = start.map_object
	var/list/near = get_nearest_stations(center_obj, NEAR_STATION_CHECK_DIST, 6)

	var/left_occupied  = FALSE
	var/right_occupied = FALSE

	for(var/datum/trainmap_object/O in near)
		var/dx = O.position_x - center_obj.position_x
		if(dx < -NEAR_STATION_SIDE_THRESHOLD)
			left_occupied = TRUE
		if(dx > NEAR_STATION_SIDE_THRESHOLD)
			right_occupied = TRUE

	var/side = 0  // -1 = влево, +1 = вправо, 0 = центр
	if(!left_occupied && !right_occupied)
		side = pick(-1, 1)
	else if(!left_occupied)
		side = -1
	else if(!right_occupied)
		side = 1
	else
		var/count_left = 0
		var/count_right = 0
		for(var/datum/trainmap_object/O in near)
			var/dx = O.position_x - center_obj.position_x
			if(dx < -NEAR_STATION_SIDE_COUNT_THRESHOLD) count_left++
			if(dx >  NEAR_STATION_SIDE_COUNT_THRESHOLD) count_right++

		side = (count_left <= count_right) ? -1 : 1

	var/initial_offset_x = rand(INITIAL_BRANCH_OFFSET_MIN, INITIAL_BRANCH_OFFSET_MAX) * side

	var/last_x = center_obj.position_x + initial_offset_x
	var/last_y = center_obj.position_y + rand(CENTER_Y_OFFSET_MIN, CENTER_Y_OFFSET_MAX)

	var/list/candidates = shuffle(available_stations.Copy())
	var/list/branch = list()
	var/safety = BRANCH_MAX_CANDIDATES_TRIES

	while(length(candidates) && safety--)
		var/datum/train_station/picked = candidates[1]
		if(!picked?.map_object)
			candidates -= picked
			continue

		var/desired_y = last_y + rand(BRANCH_STEP_Y_MIN, BRANCH_STEP_Y_MAX)
		var/desired_x = last_x + rand(-35, 35)

		// Стараемся придерживаться выбранной стороны
		if(side < 0)
			desired_x = min(desired_x, last_x)
		else if(side > 0)
			desired_x = max(desired_x, last_x)

		picked.map_object.set_position(desired_x, desired_y)
		if(check_overlap(picked.map_object)) // исправлено: проверяем пересечение со всеми размещёнными
			desired_x += rand(-20, 20)
			desired_y += rand(-15, 25)
			picked.map_object.set_position(desired_x, desired_y)
			if(check_overlap(picked.map_object))
				candidates -= picked
				continue
		if(!place_station_on_map(picked, desired_x, desired_y, ignore_overlap = TRUE))
			candidates -= picked
			continue
		branch += picked
		candidates -= picked
		last_x = desired_x
		last_y = desired_y

		if(get_distance_to_station(picked.map_object, end.map_object) < BRANCH_TOO_CLOSE_DIST)
			break

	return branch


/// Переходная ветка 2-3 станций из последнего локального центра
/datum/train_global_map/proc/place_transition_branch(datum/train_station/start, list/stations_to_place)
	if(!start?.map_object || !length(stations_to_place))
		return

	var/datum/trainmap_object/center_obj = start.map_object

	// Определяем сторону
	var/list/near = get_nearest_stations(center_obj, NEAR_STATION_CHECK_DIST, 6)
	var/left_occupied = FALSE
	var/right_occupied = FALSE
	for(var/datum/trainmap_object/O in near)
		var/dx = O.position_x - center_obj.position_x
		if(dx < -NEAR_STATION_SIDE_THRESHOLD)
			left_occupied = TRUE
		if(dx > NEAR_STATION_SIDE_THRESHOLD)
			right_occupied = TRUE

	var/side = 0
	if(!left_occupied && !right_occupied)
		side = pick(-1, 1)
	else if(!left_occupied)
		side = -1
	else if(!right_occupied)
		side = 1
	else
		var/count_left = 0
		var/count_right = 0
		for(var/datum/trainmap_object/O in near)
			var/dx = O.position_x - center_obj.position_x
			if(dx < -NEAR_STATION_SIDE_COUNT_THRESHOLD) count_left++
			if(dx > NEAR_STATION_SIDE_COUNT_THRESHOLD) count_right++
		side = (count_left <= count_right) ? -1 : 1

	var/initial_offset_x = rand(INITIAL_BRANCH_OFFSET_MIN, INITIAL_BRANCH_OFFSET_MAX) * side
	var/last_x = center_obj.position_x + initial_offset_x
	var/last_y = center_obj.position_y + rand(CENTER_Y_OFFSET_MIN, CENTER_Y_OFFSET_MAX)

	for(var/datum/train_station/picked in shuffle(stations_to_place))
		if(!picked?.map_object)
			continue

		var/desired_y = last_y + rand(BRANCH_STEP_Y_MIN, BRANCH_STEP_Y_MAX) // всегда вниз — переход к следующему региону
		var/desired_x = last_x + rand(-35, 35)

		if(side < 0)
			desired_x = min(desired_x, last_x)
		else if(side > 0)
			desired_x = max(desired_x, last_x)

		picked.map_object.set_position(desired_x, desired_y)

		var/tries = 8
		while(tries-- && check_overlap(picked.map_object))
			desired_x += rand(-25, 25)
			desired_y += rand(-10, 30)
			picked.map_object.set_position(desired_x, desired_y)

		if(check_overlap(picked.map_object))
			continue

		if(!place_station_on_map(picked, desired_x, desired_y, ignore_overlap = TRUE))
			continue

		last_x = desired_x
		last_y = desired_y


/// Размещение одной cargo_station рядом со станцией + соединение
/datum/train_global_map/proc/place_cargo_near(datum/train_station/near_station, datum/train_station/cargo_station)
	if(!near_station?.map_object || !cargo_station?.map_object)
		return FALSE

	var/base_x = near_station.map_object.position_x
	var/base_y = near_station.map_object.position_y

	// Сначала пробуем разумные смещения
	var/list/offsets = list(
		list(55, 0), list(-55, 0), list(0, 55), list(0, -55),
		list(65, 35), list(65, -35), list(-65, 35), list(-65, -35),
		list(45, 65), list(-45, 65), list(45, -65), list(-45, -65)
	)
	offsets = shuffle(offsets)

	for(var/list/off in offsets)
		var/tx = base_x + off[1]
		var/ty = base_y + off[2]
		cargo_station.map_object.set_position(tx, ty)

		if(!check_overlap(cargo_station.map_object) && !is_cargo_too_close(cargo_station.map_object))
			if(place_station_on_map(cargo_station, tx, ty, ignore_overlap = TRUE))
				// Соединяем с текущей станцией и следующей
				add_connection(cargo_station, near_station, SStrain_controller.known_stations)
				if(length(near_station.possible_next))
					var/datum/train_station/next_one = pick(near_station.possible_next)
					if(next_one && next_one != cargo_station)
						add_connection(cargo_station, next_one, SStrain_controller.known_stations)
				else
					// Ищем уже связанную станцию
					for(var/datum/train_station/poss in SStrain_controller.known_stations)
						if(near_station in poss.possible_next && poss != cargo_station)
							add_connection(cargo_station, poss, SStrain_controller.known_stations)
							break
				return TRUE

	// Если не получилось — случайный поиск
	for(var/i in 1 to 35)
		var/tx = base_x + rand(-85, 85)
		var/ty = base_y + rand(-65, 65)
		cargo_station.map_object.set_position(tx, ty)

		if(!check_overlap(cargo_station.map_object) && !is_cargo_too_close(cargo_station.map_object))
			if(place_station_on_map(cargo_station, tx, ty, ignore_overlap = TRUE))
				add_connection(cargo_station, near_station, SStrain_controller.known_stations)
				if(length(near_station.possible_next))
					var/datum/train_station/next_one = pick(near_station.possible_next)
					if(next_one && next_one != cargo_station)
						add_connection(cargo_station, next_one, SStrain_controller.known_stations)
				return TRUE

	return FALSE

/datum/train_global_map/proc/is_cargo_too_close(datum/trainmap_object/new_obj, min_dist = 110)
	for(var/datum/trainmap_object/O in objects)
		if(O == new_obj)
			continue
		if(istype(O.associated_station, /datum/train_station/cargo_station))
			if(get_distance_to_station(new_obj, O) < min_dist)
				return TRUE
	return FALSE


/// Соединяет станции линиями с ближайшими соседями по карте (по степени связности)
/datum/train_global_map/proc/connect_stations(list/stations_to_connect = null)
	if(!stations_to_connect)
		stations_to_connect = list()
		for(var/datum/train_station/S in station_to_object)
			if(is_placed_on_map(S))
				stations_to_connect += S

	if(!length(stations_to_connect))
		return


	var/list/by_degree = list()
	for(var/datum/train_station/S in stations_to_connect)
		by_degree[S] = get_station_degree(S, stations_to_connect)

	by_degree = sortTim(by_degree, GLOBAL_PROC_REF(cmp_numeric_asc), associative = TRUE)

	for(var/datum/train_station/S in by_degree)
		if(!is_placed_on_map(S))
			continue

		var/datum/trainmap_object/my_obj = S.map_object
		var/list/closest = get_nearest_stations(my_obj, max_dist = 140, max_count = 5)

		for(var/datum/trainmap_object/neigh_obj in closest)
			var/datum/train_station/neigh = neigh_obj.associated_station
			if(!neigh || neigh == S)
				continue

			if(add_connection(S, neigh, stations_to_connect, max_degree = 3))
				if(!has_path_between(my_obj, neigh_obj))
					var/datum/trainmap_path/P = new
					P.start = my_obj
					P.end = neigh_obj
					paths += P

			// Ограничим количество связей на станцию
			if(get_station_degree(S, stations_to_connect) >= 4)
				break


/datum/train_global_map/proc/has_path_between(datum/trainmap_object/A, datum/trainmap_object/B)
	for(var/datum/trainmap_path/P in paths)
		if((P.start == A && P.end == B) || (P.start == B && P.end == A))
			return TRUE
	return FALSE

/datum/train_global_map/proc/get_distance_to_station(datum/trainmap_object/A, datum/trainmap_object/B)
	if(!A || !B)
		return 0
	var/dx = A.position_x - B.position_x
	var/dy = A.position_y - B.position_y
	return sqrt(dx*dx + dy*dy)

/datum/train_global_map/proc/get_station_degree(datum/train_station/S, list/valid_stations = null)
	if(!S)
		return 0

	if(!valid_stations)
		valid_stations = SStrain_controller.known_stations

	var/count = 0

	for(var/datum/train_station/next in S.possible_next)
		if(next && (next in valid_stations) && !(next.station_flags & TRAINSTATION_ABSCTRACT))
			count++

	for(var/datum/train_station/other in valid_stations)
		if(other == S)
			continue
		if(S in other.possible_next)
			if(!(other.station_flags & TRAINSTATION_ABSCTRACT))
				count++

	return count

/// Проверяет, не пересекается ли new_obj по расстоянию OVERLAP_MIN_DISTANCE с уже размещёнными (кроме ignore)
/datum/train_global_map/proc/check_overlap(datum/trainmap_object/new_obj, list/ignore = list())
	for(var/datum/trainmap_object/O in objects)
		if(O in ignore || O == new_obj)
			continue
		var/dx = new_obj.position_x - O.position_x
		var/dy = new_obj.position_y - O.position_y
		if(sqrt(dx*dx + dy*dy) < OVERLAP_MIN_DISTANCE)
			return TRUE
	return FALSE


/// Ближайшие к center объекты на карте в радиусе max_dist, не более max_count
/datum/train_global_map/proc/get_nearest_stations(datum/trainmap_object/center, max_dist = NEAR_STATION_CHECK_DIST, max_count = 4)
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


/// Угол направления в градусах (0 = вправо, 90 = вниз) для отрисовки иконки поезда.
/datum/train_global_map/proc/angle_from_delta(dx, dy)
	if(!dx && !dy)
		return 0
	var/len = sqrt(dx * dx + dy * dy)
	if(len <= 0)
		return 0
	var/rad = arccos(dx / len)
	if(dy < 0)
		rad = -rad
	return rad * (180 / 3.14159)


/datum/train_global_map/proc/add_connection(datum/train_station/A, datum/train_station/B, list/valid_stations, max_degree = 3)
	if(!A || !B || A == B)
		return FALSE

	if(!(A in valid_stations) || !(B in valid_stations))
		return FALSE

	if(A.station_flags & TRAINSTATION_ABSCTRACT || B.station_flags & TRAINSTATION_ABSCTRACT)
		return FALSE

	var/degA = get_station_degree(A, valid_stations)
	var/degB = get_station_degree(B, valid_stations)

	var/maxA = max_degree
	var/maxB = max_degree
	if(A.station_flags & TRAINSTATION_LOCAL_CENTER)
		maxA = max(maxA, 4)
	if(B.station_flags & TRAINSTATION_LOCAL_CENTER)
		maxB = max(maxB, 4)

	if(degA >= maxA || degB >= maxB)
		return FALSE

	if((A.station_flags & TRAINSTATION_NO_FORKS) && degA >= 1)
		return FALSE
	if((B.station_flags & TRAINSTATION_NO_FORKS) && degB >= 1)
		return FALSE

	if(!(B in A.possible_next))
		A.possible_next += B
	if(!(A in B.possible_next))
		B.possible_next += A

	return TRUE

/datum/train_global_map/proc/update_train_position()
	if(!SStrain_controller.is_moving() || !SStrain_controller.loaded_station)
		var/datum/trainmap_object/obj = SStrain_controller.loaded_station?.map_object
		train_position.set_position(obj?.position_x || center_x, obj?.position_y || center_y)
		train_position.angle = 0
		return

	var/datum/train_station/start_station = SStrain_controller.last_departed_station || SStrain_controller.loaded_station
	var/datum/trainmap_object/start_obj = start_station?.map_object
	var/datum/trainmap_object/end_obj = SStrain_controller.planned_to_load?.map_object

	if(!start_obj || !end_obj)
		return

	var/progress = 1 - (SStrain_controller.time_to_next_station / max(SStrain_controller.total_travel_time, 1))
	progress = clamp(progress, 0, 1)

	train_position.set_position(
		start_obj.position_x + (end_obj.position_x - start_obj.position_x) * progress,
		start_obj.position_y + (end_obj.position_y - start_obj.position_y) * progress
	)
	train_position.angle = angle_from_delta(
		end_obj.position_x - start_obj.position_x,
		end_obj.position_y - start_obj.position_y
	)


/datum/train_global_map/proc/get_ui_data()
	var/list/data = list()

	var/list/obj_list = list()
	for(var/datum/trainmap_object/O in objects)
		obj_list += list(list(
			"id" = "[O.associated_station?.type || "unknown"]",
			"name" = O.name,
			"desc" = O.desc,
			"station_type" = O.associated_station?.station_type || "unknown",
			"region" = O.associated_station?.region || "Unknown",
			"x" = O.position_x,
			"y" = O.position_y,
			"is_current" = (O == SStrain_controller.loaded_station?.map_object),
			"is_next" = (O == SStrain_controller.planned_to_load?.map_object),
			"visited" = O.associated_station?.visited || 0,
			"is_local_center" = !!(O.associated_station?.station_flags & TRAINSTATION_LOCAL_CENTER),
		))

	data["objects"] = obj_list

	var/list/path_list = list()
	for(var/datum/trainmap_path/P in paths)
		path_list += list(list(
			"start_x" = P.start.position_x,
			"start_y" = P.start.position_y,
			"end_x" = P.end.position_x,
			"end_y" = P.end.position_y
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
