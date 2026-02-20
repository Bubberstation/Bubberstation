/obj/effect/landmark/trainstation
	icon_state = "tdome_admin"
	flags_1 = NO_TURF_MOVEMENT_1

/obj/effect/landmark/trainstation/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STATION_UNLOAD, INNATE_TRAIT)

// Используетя для создания окрестности станции над рельсами путей
/obj/effect/landmark/trainstation/nearstation_spawnpoint
	name = "Near station placer"

// Используется для создания станций, под рельсами путей
/obj/effect/landmark/trainstation/station_spawnpoint
	name = "Station Placer"

/obj/effect/landmark/trainstation/nearstation_spawnpoint
	name = "Nearstation Placer"


/obj/effect/landmark/trainstation/train_spawnpoint
	name = "Train Placer"

/obj/effect/landmark/trainstation/crew_spawnpoint
	name = "Crew Placer"

/obj/effect/landmark/trainstation/raider_spawnpoint
	name = "Raider spawner"


/datum/map_template/train_station
	name = "Train Station Template"
	returns_created_atoms = TRUE

/turf/closed/indestructible/train_border
	name = "Iced rock"
	icon_state = "icerock"

/datum/map_template/train
	name = "Train Template"
	width = 200
	height = 13
	mappath = "_maps/modular_events/trainstation/train_general.dmm"


/datum/train_station
	/// Название станции
	var/name = "Train station"
	/// Полное описание станции
	var/desc = "A generic train station"
	/// Флаги станции, подробнее в файле modular_zvents/__DEFINES/trainstation.dm
	var/station_flags = NONE
	/// Видна ли эта станция в меню train_controll'ера, если FALSE - так же не даст  стнциаи быть выбранной в качестве следующей
	var/visible = TRUE
	/// Сколько станций поезду нужно посетить перед этой станцией
	var/required_stations = 0
	/// Максимально количество посещений для этой станции
	var/maximum_visits = 1
	/// Сколько раз - эта станция была посещена
	var/visited = 0
	/// Необходим ли пароль для разблокирования этой станции
	var/required_password = TRUE
	/// Создатель этой станции, будет отобржен при её посещении
	var/creator = "Fenysha"


	/// Путь к карте станции, автоматически создает темплейт для неё
	var/map_path
	/// list() - эмбиет звуков, что играют на этой станции
	var/ambience_sounds = null
	/// Список возможных окрестностей станции(генерируются над поездом)
	var/list/possible_nearstations = list(
		/datum/train_station/near_station/static_default,
		/datum/train_station/near_station/static_mountaints,
	)
	/// Возможные следующие станции. По умолчанию - пуст и будет наполнен при загрузке, но может устаовлен заранее
	var/list/possible_next = list()
	// Блокирует ли эта станция движение поезда, будет установлен автоматически, если у станции есть флаг TRAINSTATION_BLOCKING
	var/blocking_moving = FALSE

	VAR_PRIVATE/datum/looping_sound/global_sound/station_loop_soound = null
	VAR_PRIVATE/datum/map_template/template = null
	VAR_PRIVATE/list/docking_turfs = list()
	VAR_PRIVATE/datum/train_station/near_station/loaded_nearstation = null
	VAR_PRIVATE/unlock_password


/datum/train_station/New()
	. = ..()
	template = new /datum/map_template(map_path, "Train station - [name]", TRUE)
	template.returns_created_atoms = TRUE
	SSmapping.map_templates[template.name] = template

	if(ambience_sounds)
		create_ambience()

/datum/train_station/proc/create_ambience()
	station_loop_soound = new(start_immediately = FALSE)
	station_loop_soound.create_from_list(ambience_sounds)

/datum/train_station/proc/connect_stations()
	for(var/i in 1 to length(possible_next))
		var/path = possible_next[i]
		var/datum/train_station/st = locate(path) in SStrain_controller.known_stations
		if(st)
			possible_next[i] = st
		else
			stack_trace("Invalid possible_next path [path] for station [type]")

	if(station_flags & TRAINSTATION_NO_NEARSTATION)
		return

	for(var/i in 1 to length(possible_nearstations))
		var/path = possible_nearstations[i]
		var/datum/train_station/st = locate(path) in SStrain_controller.known_stations
		if(st)
			possible_nearstations[i] = st
		else
			stack_trace("Invalid possible_nearstations path [path] for station [type]")

/datum/train_station/proc/get_spawnpoint()
	return locate(/obj/effect/landmark/trainstation/station_spawnpoint) in GLOB.landmarks_list

/datum/train_station/proc/get_spawn_offset(turf/spawn_turf)
	var/offset_x = spawn_turf.x
	var/offset_y = spawn_turf.y - template.height + 1
	var/offset_z = spawn_turf.z
	return list("x" = offset_x, "y" = offset_y, "z" = offset_z)


/datum/train_station/proc/load_station(datum/callback/load_callback, silent = FALSE)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!template)
		return FALSE
	var/start_time = world.realtime
	var/obj/effect/landmark/trainstation/spawnpoint = get_spawnpoint()
	if(!spawnpoint)
		stack_trace("Failed to load train station [name], no available spawnpoints!")
		return FALSE

	var/list/spawn_offset = get_spawn_offset(get_turf(spawnpoint))
	if(!islist(spawn_offset) || length(spawn_offset) != 3)
		stack_trace("Failed to load train station [name], invalid spawn offset!")
		return FALSE
	var/offset_x = spawn_offset["x"]
	var/offset_y = spawn_offset["y"]
	var/offset_z = spawn_offset["z"]

	var/turf/actual_spawnpoint = locate(offset_x, offset_y, offset_z)
	if(!actual_spawnpoint)
		stack_trace("Failed to load train station [name], template out of bounds")
		return FALSE
	var/bounds = template.load(actual_spawnpoint, centered = FALSE)

	docking_turfs = block(
		bounds[MAP_MINX], bounds[MAP_MINY], bounds[MAP_MINZ],
		bounds[MAP_MAXX], bounds[MAP_MAXY], bounds[MAP_MAXZ]
	)
	if(template.width < world.maxx)
		create_indestructible_borders(actual_spawnpoint)

	if((islist(possible_nearstations) && length(possible_nearstations)) && !(station_flags & TRAINSTATION_NO_NEARSTATION))
		var/datum/train_station/our_neatstation = pick(possible_nearstations)
		if(our_neatstation && our_neatstation.load_station(silent = TRUE))
			loaded_nearstation = our_neatstation

	var/load_in = world.realtime - start_time
	if(!silent)
		message_admins("TRAINSTATION: Loaded station [name] in [time2text(load_in, "ss")] seconds!")
	if(load_callback)
		load_callback.Invoke()
	after_load()
	return TRUE


/datum/train_station/proc/create_indestructible_borders(turf/bottom_left)
	SHOULD_NOT_OVERRIDE(TRUE)

	var/left_x = bottom_left.x - 1
	var/right_x = bottom_left.x + template.width
	var/start_y = bottom_left.y
	var/end_y = bottom_left.y + template.height - 1
	var/z = bottom_left.z

	for(var/y = start_y to end_y)
		var/turf/left_turf = locate(left_x, y, z)
		if(left_turf)
			left_turf.ChangeTurf(/turf/closed/indestructible/train_border)
			docking_turfs += left_turf


	for(var/y = start_y to end_y)
		var/turf/right_turf = locate(right_x, y, z)
		if(right_turf)
			right_turf.ChangeTurf(/turf/closed/indestructible/train_border)
			docking_turfs += right_turf
	if(right_x <= world.maxx)
		var/turf/corner = locate(right_x, end_y, z)
		if(!corner)
			return
		for(var/x = right_x to world.maxx)
			var/turf/top_turf = locate(x, end_y, z)
			if(top_turf)
				top_turf.ChangeTurf(/turf/closed/indestructible/train_border)
				docking_turfs += top_turf

/datum/train_station/proc/generate_password()
	var/static/list/possible_letters = \
		list("1", "2", "3",
			"4", "5", "6",
			"7", "8", "9", "0")
	var/new_pass = ""
	for(var/i = 1 to 5)
		new_pass += pick(possible_letters)
	return new_pass

/datum/train_station/proc/get_password()
	return unlock_password

/datum/train_station/proc/is_right_code(code)
	if(trim(code) != trim(unlock_password))
		return FALSE
	return TRUE

/datum/train_station/proc/pre_load()
	if(required_password)
		unlock_password = generate_password()

/datum/train_station/proc/after_load()
	if(station_flags & TRAINSTATION_BLOCKING)
		blocking_moving = TRUE
	if(station_loop_soound)
		station_loop_soound.start()



/datum/train_station/proc/unload_station(datum/callback/unload_callback)
	SHOULD_NOT_OVERRIDE(TRUE)

	var/obj/effect/landmark/trainstation/crew_spawnpoint/crew_mover = locate() in GLOB.landmarks_list

	Master.StartLoadingMap()
	for(var/turf/T in docking_turfs)
		for(var/atom/movable/AM in T.contents)
			if(HAS_TRAIT(AM, TRAIT_NO_STATION_UNLOAD))
				continue
			if(isliving(AM))
				var/mob/living/living = AM
				if(crew_mover && living.client)
					living.forceMove(get_turf(crew_mover))
					to_chat(living, span_warning("You barely made it to the train before it departed!"))
					continue
			if(isobserver(AM))
				continue
			qdel(AM)
		T.ChangeTurf(/turf/baseturf_bottom)
		T.baseturfs = /turf/baseturf_bottom
	docking_turfs.Cut()
	template.created_atoms = null
	if(unload_callback)
		unload_callback.Invoke()
	Master.StopLoadingMap()
	if(loaded_nearstation)
		loaded_nearstation.unload_station()
		loaded_nearstation = null
	after_unload()

/datum/train_station/proc/after_unload()
	if(station_loop_soound)
		station_loop_soound.stop()


/datum/train_station/near_station
	name = "Near station"
	station_flags = TRAINSTATION_ABSCTRACT | TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_NO_NEARSTATION
	possible_nearstations = null
	visible = FALSE

/datum/train_station/near_station/get_spawnpoint()
	return locate(/obj/effect/landmark/trainstation/nearstation_spawnpoint) in GLOB.landmarks_list

/datum/train_station/near_station/get_spawn_offset(turf/spawn_turf)
	return list("x" = spawn_turf.x, "y" = spawn_turf.y, "z" = spawn_turf.z)

/datum/train_station/near_station/static_default
	name = "Nearstation static - Default"
	map_path = "_maps/modular_events/trainstation/nearstations/static_default.dmm"

/datum/train_station/near_station/static_mountaints
	name = "Nearstation static - Default"
	map_path = "_maps/modular_events/trainstation/nearstations/static_mountains.dmm"


/datum/train_station/near_station/moving_default
	name = "Nearstation - Forest outskirts"
	map_path = "_maps/modular_events/trainstation/nearstations/moving_default.dmm"

/datum/train_station/near_station/moving_deepforerst
	name = "Nearstation - Deep forest"
	map_path = "_maps/modular_events/trainstation/nearstations/moving_deep_forest.dmm"


/datum/train_station/train_backstage
	name = "Iced forest"
	map_path = "_maps/modular_events/trainstation/backstage.dmm"
	station_flags = TRAINSTATION_ABSCTRACT | TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION
	visible = FALSE
	possible_nearstations = list(/datum/train_station/near_station/moving_default)


/datum/train_station/near_station/abandoned_depo
	name = "Nearstation - Abandoned depo"
	map_path = "_maps/modular_events/trainstation/nearstations/static_abandoned_train_depo.dmm"

/datum/train_station/abandoned_depo
	name = "Abandoned depo"
	map_path = "_maps/modular_events/trainstation/abandoned_train_depo.dm.dmm"
	creator = "Fenysha"
	possible_nearstations = list(/datum/train_station/near_station/abandoned_depo)
	possible_next = list(/datum/train_station/infected_laboratory)
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/emergency_station_a13
	name = "Emergency station A13"
	map_path = "_maps/modular_events/trainstation/emergency_a13.dmm"
	creator = "Fenysha"
	visible = FALSE
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/infected_laboratory
	name = "Infected laboratory"
	map_path = "_maps/modular_events/trainstation/infected_lab.dmm"
	creator = "Fenysha & v1s1ti"
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/start_point
	name = "Union Plasa"
	map_path = "_maps/modular_events/trainstation/startpoint.dmm"
	creator = "Fenysha"
	possible_next = list()
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING
	required_stations = 8

/datum/train_station/military_house
	name = "Evacuated Military Side"
	creator = "Fenysha & TYWONKA"
	map_path = "_maps/modular_events/trainstation/military_side.dmm"
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/missle_military_side
	name = "Corrupted military Side"
	creator = "v1s1ti"
	map_path = "_maps/modular_events/trainstation/missle_military_side.dmm"
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 6

/datum/train_station/warehouses
	name = "Abandoned warehousess"
	creator = "Fenysha & TYWONKA"
	map_path = "_maps/modular_events/trainstation/warehouse.dmm"
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/frozen_lake
	name = "Frozen lake"
	creator = "Fenysha"
	map_path = "_maps/modular_events/trainstation/iced_lake.dmm"

/datum/train_station/mines
	name = "Abandoned mines"
	creator = "Kierri"
	map_path = "_maps/modular_events/trainstation/abandoned_mines.dmm"
	possible_nearstations = list(/datum/train_station/near_station/static_mountaints)
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/deep_forest
	name = "Deep forest"
	creator = "Fenysha"
	map_path = "_maps/modular_events/trainstation/deep_forest.dmm"
	possible_nearstations = list(/datum/train_station/near_station/static_mountaints)

/datum/train_station/collapsed_lab
	name = "Collapsed laboratory"
	creator = "Mold & Fenysha"
	map_path = "_maps/modular_events/trainstation/collapsed_lab.dmm"
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 5

/datum/train_station/radiosphere
	name = "The Radiosphere"
	creator = "Fenysha & Mold"
	map_path = "_maps/modular_events/trainstation/radiosphere.dmm"
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 5

	ambience_sounds = list('modular_zvents/sounds/radiosphere_loop1.ogg' = 40 SECONDS)
