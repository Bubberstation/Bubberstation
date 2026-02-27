// Центр и размер холста карты
#define MAP_CENTER_X 500
#define MAP_CENTER_Y 500
#define MAP_MIN_RADIUS 370
#define MAP_MAX_RADIUS 550

// Шаг по вертикали между регионами и смещение веток (умеренная длина пути)
#define REGION_Y_STEP 200
#define CENTER_Y_OFFSET_MIN 90
#define CENTER_Y_OFFSET_MAX 150

// Начальное смещение ветки от центра влево/вправо
#define INITIAL_BRANCH_OFFSET_MIN 20
#define INITIAL_BRANCH_OFFSET_MAX 40

// Шаг по Y между станциями на ветке
#define BRANCH_STEP_Y_MIN 60
#define BRANCH_STEP_Y_MAX 100

// Минимальная дистанция между точками; пороги для «близких» станций
#define OVERLAP_MIN_DISTANCE 50
#define NEAR_STATION_CHECK_DIST 270
#define NEAR_STATION_SIDE_THRESHOLD 60
#define NEAR_STATION_SIDE_COUNT_THRESHOLD 25

// Остановка ветки у конечной станции; лимит итераций подбора
#define BRANCH_TOO_CLOSE_DIST 160
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
		if(S.station_flags & TRAINSTATION_FINAL_STATION)
			continue
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

		var/list/non_centers = list() // Обычные станции не являющиеся центральными (в порядке возрастания опасности)
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
			var/list/branch = place_transition_branch(last_local, transition_stations)
			if(length(branch))
				last_region_station = branch[length(branch)]

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

	// После всех регионов — отдельная финальная станция, если она объявлена
	var/datum/train_station/the_final_station = SStrain_controller.pick_final_station()
	if(the_final_station && the_final_station.map_object && !(the_final_station.station_flags & TRAINSTATION_ABSCTRACT))
		if(!is_placed_on_map(the_final_station))
			var/base_x = last_region_station?.map_object?.position_x || center_x
			var/base_y = (last_region_station?.map_object?.position_y || current_y) + round(REGION_Y_STEP / 2)

			var/x = base_x
			var/y = base_y
			var/tries = 40
			while(tries-- && !place_station_on_map(the_final_station, x, y))
				x = base_x + rand(-80, 80)
				y = base_y + rand(BRANCH_STEP_Y_MIN, BRANCH_STEP_Y_MAX)

		if(is_placed_on_map(the_final_station))
			connect_stations(valid_stations + the_final_station)


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

	var/list/candidates = available_stations.Copy()
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

		var/dist_to_end = get_distance_to_station(picked.map_object, end.map_object)
		if(dist_to_end < BRANCH_TOO_CLOSE_DIST)
			break

		// если мы уже ниже (или на уровне) целевого локального центра и по X достаточно близко к нему —
		// считаем, что ветка «естественно» пришла к концу между центрами и дальше не тянем станции.
		if(picked.map_object.position_y >= end.map_object.position_y)
			var/dx_to_end = abs(picked.map_object.position_x - end.map_object.position_x)
			if(dx_to_end <= NEAR_STATION_SIDE_COUNT_THRESHOLD * 2)
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
	var/list/branch = list()

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
		branch += picked

		last_x = desired_x
		last_y = desired_y
	return branch

/// Размещение одной cargo_station рядом со станцией + соединение
/datum/train_global_map/proc/place_cargo_near(datum/train_station/near_station, datum/train_station/cargo_station)
	if(!near_station?.map_object || !cargo_station?.map_object)
		return FALSE

	var/base_x = near_station.map_object.position_x
	var/base_y = near_station.map_object.position_y

	// Для визуализации разрешаем одной и той же cargo-станции иметь несколько
	// отдельных объектов на карте. Каждый вызов place_cargo_near создаёт новый
	// /datum/trainmap_object, связанный с той же станцией.
	var/datum/trainmap_object/cargo_obj = new
	cargo_obj.name = cargo_station.name
	cargo_obj.desc = cargo_station.desc
	cargo_obj.associated_station = cargo_station

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
		cargo_obj.set_position(tx, ty)

		if(!check_overlap(cargo_obj) && !is_cargo_too_close(cargo_obj))
			// Регистрируем дополнительный маркер карго-станции на карте
			objects += cargo_obj

			// Гарантируем, что основная карта-станция тоже числится размещённой (для connect_stations)
			if(!is_placed_on_map(cargo_station))
				place_station_on_map(cargo_station, tx, ty, ignore_overlap = TRUE)

			// Логические связи между станциями (одна на саму станцию, а не на маркер)
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

			// Визуальная линия от маркера карго до станции, рядом с которой он расположен
			if(near_station.map_object)
				var/datum/trainmap_path/P = new
				P.start = cargo_obj
				P.end = near_station.map_object
				paths += P

			connect_cargo_to_nearby(cargo_station)

			return TRUE

	// Если не получилось — случайный поиск
	for(var/i in 1 to 35)
		var/tx = base_x + rand(-85, 85)
		var/ty = base_y + rand(-65, 65)
		cargo_obj.set_position(tx, ty)

		if(!check_overlap(cargo_obj) && !is_cargo_too_close(cargo_obj))
			objects += cargo_obj

			if(!is_placed_on_map(cargo_station))
				place_station_on_map(cargo_station, tx, ty, ignore_overlap = TRUE)

			add_connection(cargo_station, near_station, SStrain_controller.known_stations)
			if(length(near_station.possible_next))
				var/datum/train_station/next_one = pick(near_station.possible_next)
				if(next_one && next_one != cargo_station)
					add_connection(cargo_station, next_one, SStrain_controller.known_stations)

			if(near_station.map_object)
				var/datum/trainmap_path/P = new
				P.start = cargo_obj
				P.end = near_station.map_object
				paths += P

			connect_cargo_to_nearby(cargo_station)

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


/datum/train_global_map/proc/connect_cargo_to_nearby(datum/train_station/cargo_station)
	if(!cargo_station?.map_object)
		return
	if(!is_placed_on_map(cargo_station))
		return

	var/datum/trainmap_object/center = cargo_station.map_object
	var/list/near = get_nearest_stations(center, NEAR_STATION_CHECK_DIST, 8)
	if(!length(near))
		return

	for(var/datum/trainmap_object/O in near)
		var/datum/train_station/S = O.associated_station
		if(!S || S == cargo_station)
			continue
		if(istype(S, /datum/train_station/cargo_station))
			continue
		if(S.station_flags & TRAINSTATION_ABSCTRACT)
			continue
		if(add_connection(cargo_station, S, SStrain_controller.known_stations, max_degree = 6))
			if(!has_path_between(cargo_station.map_object, S.map_object))
				var/datum/trainmap_path/P = new
				P.start = cargo_station.map_object
				P.end = S.map_object
				paths += P


/datum/train_global_map/proc/dsu_find(list/parent, datum/train_station/S)
	if(!S)
		return null
	var/datum/train_station/p = parent[S]
	if(!p || p == S)
		parent[S] = S
		return S
	parent[S] = dsu_find(parent, p)
	return parent[S]


/datum/train_global_map/proc/dsu_union(list/parent, datum/train_station/A, datum/train_station/B)
	if(!A || !B)
		return FALSE
	var/datum/train_station/ra = dsu_find(parent, A)
	var/datum/train_station/rb = dsu_find(parent, B)
	if(!ra || !rb || ra == rb)
		return FALSE
	parent[ra] = rb
	return TRUE


/// Соединяет станции линиями с несколькими ближайшими соседями по карте (по степени связности)
/datum/train_global_map/proc/connect_stations(list/stations_to_connect = null)
	if(!stations_to_connect)
		stations_to_connect = list()
		for(var/datum/train_station/S in station_to_object)
			if(is_placed_on_map(S))
				stations_to_connect += S

	if(!length(stations_to_connect))
		return

	// Оставляем только реально размещённые станции (иначе расстояния бессмысленны)
	var/list/valid = list()
	for(var/datum/train_station/S in stations_to_connect)
		if(is_placed_on_map(S))
			valid += S

	if(length(valid) < 2)
		return

	// 1) Для каждой станции соединяем её не только с несколькими ближайшими, чтобы формировать разветвлённые ветки
	var/max_local_neighbors = 3
	var/dist_factor = 1.3

	for(var/datum/train_station/S in valid)
		var/list/dist_map = list()

		for(var/datum/train_station/T in valid)
			if(T == S)
				continue
			var/d = get_distance_to_station(S.map_object, T.map_object)
			if(d <= 0)
				continue
			dist_map[T] = d

		if(!length(dist_map))
			continue

		dist_map = sortTim(dist_map, GLOBAL_PROC_REF(cmp_numeric_asc), associative = TRUE)

		var/datum/train_station/first = dist_map[1]
		if(!first)
			continue

		var/base_dist = dist_map[first]
		if(base_dist <= 0)
			continue

		var/connected = 0

		for(var/i in 1 to length(dist_map))
			if(connected >= max_local_neighbors)
				break

			var/datum/train_station/T = dist_map[i]
			if(!T)
				continue

			var/d_current = dist_map[T]
			if(d_current <= 0)
				continue

			// Ограничиваемся станциями, которые находятся не сильно дальше самой близкой
			if(d_current > base_dist * dist_factor)
				break

			if(add_connection(S, T, valid, max_degree = 6))
				if(!has_path_between(S.map_object, T.map_object))
					var/datum/trainmap_path/P = new
					P.start = S.map_object
					P.end = T.map_object
					paths += P
				connected++

	// 2) Гарантируем связность региона: соединяем ближайшие компоненты, пока не останется одна
	var/list/parent = list()
	for(var/datum/train_station/S in valid)
		parent[S] = S

	for(var/datum/train_station/A in valid)
		for(var/datum/train_station/B in A.possible_next)
			if(B && (B in valid))
				dsu_union(parent, A, B)

	var/list/blocked_pairs = list()

	while(TRUE)
		var/list/roots = list()
		for(var/datum/train_station/S in valid)
			var/datum/train_station/r = dsu_find(parent, S)
			if(r)
				roots[r] = TRUE
		if(length(roots) <= 1)
			break

		var/datum/train_station/bestA = null
		var/datum/train_station/bestB = null
		var/best = INFINITY

		for(var/i in 1 to length(valid) - 1)
			var/datum/train_station/S1 = valid[i]
			var/datum/train_station/r1 = dsu_find(parent, S1)
			for(var/j in (i + 1) to length(valid))
				var/datum/train_station/S2 = valid[j]
				var/datum/train_station/r2 = dsu_find(parent, S2)
				if(!r1 || !r2 || r1 == r2)
					continue

				var/key = "\ref[S1]|\ref[S2]"
				if(blocked_pairs[key])
					continue

				var/d = get_distance_to_station(S1.map_object, S2.map_object)
				if(d > 0 && d < best)
					best = d
					bestA = S1
					bestB = S2

		if(!bestA || !bestB)
			break

		if(add_connection(bestA, bestB, valid, max_degree = 6))
			if(!has_path_between(bestA.map_object, bestB.map_object))
				var/datum/trainmap_path/P = new
				P.start = bestA.map_object
				P.end = bestB.map_object
				paths += P
			dsu_union(parent, bestA, bestB)
		else
			blocked_pairs["\ref[bestA]|\ref[bestB]"] = TRUE
			blocked_pairs["\ref[bestB]|\ref[bestA]"] = TRUE

	// 3) Финальный проход: гарантируем, что у каждой размещённой станции есть хотя бы одна связь.
	for(var/datum/train_station/S in valid)
		if(get_station_degree(S, valid) > 0)
			continue

		var/datum/train_station/nearest2 = null
		var/best2 = INFINITY
		for(var/datum/train_station/T in valid)
			if(T == S)
				continue
			var/d2 = get_distance_to_station(S.map_object, T.map_object)
			if(d2 > 0 && d2 < best2)
				best2 = d2
				nearest2 = T

		if(!nearest2)
			continue

		if(add_connection(S, nearest2, valid, max_degree = 999))
			if(!has_path_between(S.map_object, nearest2.map_object))
				var/datum/trainmap_path/P = new
				P.start = S.map_object
				P.end = nearest2.map_object
				paths += P


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
	var/id_counter = 0
	for(var/datum/trainmap_object/O in objects)
		id_counter++
		obj_list += list(list(
			"id" = "[O.associated_station?.type || "unknown"]#[id_counter]",
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
