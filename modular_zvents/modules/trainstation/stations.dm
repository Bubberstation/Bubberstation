/obj/effect/landmark/trainstation
	icon_state = "tdome_admin"
	flags_1 = NO_TURF_MOVEMENT

/obj/effect/landmark/trainstation/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STATION_UNLOAD, INNATE_TRAIT)

// Используетя для создания окрестности станции над рельсами путей
/obj/effect/landmark/trainstation/nearstation_spawnpoint
	name = "Near station placer"

// Используется для создания станций, под рельсами путей
/obj/effect/landmark/trainstation/station_spawnpoint
	name = "Station Placer"

/obj/effect/landmark/trainstation/train_spawnpoint
	name = "Train Placer"

/obj/effect/landmark/trainstation/crew_spawnpoint
	name = "Crew Placer"


/obj/effect/landmark/trainstation/object_spawner
	name = "Object spawner"

	var/accuracy = 1
	var/list/possible_objects = list()
	var/min_delay = 1 SECONDS
	var/max_delay = 3 SECONDS

	VAR_PRIVATE/spawning = FALSE
	COOLDOWN_DECLARE(spawn_cd)


/obj/effect/landmark/trainstation/object_spawner/Initialize(mapload)
	. = ..()
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_BEGIN_MOVING, PROC_REF(on_train_begin_moving))
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_STOP_MOVING, PROC_REF(on_train_stop_moving))

/obj/effect/landmark/trainstation/object_spawner/Destroy()
	. = ..()

/obj/effect/landmark/trainstation/object_spawner/proc/on_train_begin_moving()
	SIGNAL_HANDLER
	START_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/proc/on_train_stop_moving()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/process(seconds_per_tick)
	if(spawning)
		return
	if(!COOLDOWN_FINISHED(src, spawn_cd))
		return
	COOLDOWN_START(src, spawn_cd, rand(min_delay, max_delay))
	INVOKE_ASYNC(src, PROC_REF(attempt_spawn))


/obj/effect/landmark/trainstation/object_spawner/proc/attempt_spawn()
	if(!length(possible_objects))
		return
	spawning = TRUE
	var/turf/target_turf = get_turf(src)
	if(accuracy > 0)
		for(var/turf/T as anything in shuffle(RANGE_TURFS(accuracy, src)))
			if(!can_see(src, T, accuracy))
				continue
			if(isopenturf(T))
				target_turf = T
				break
	var/selected = pick(possible_objects)
	var/atom/movable/new_obj = new selected(src)
	if(new_obj)
		ASYNC
			new_obj.Move(target_turf, update_dir = FALSE)
	spawning = FALSE

/obj/effect/landmark/trainstation/object_spawner/trees
	possible_objects = list(
		/obj/structure/flora/tree/pine/style_random
	)

/obj/effect/landmark/trainstation/object_spawner/bushes
	accuracy = 3
	possible_objects = list(
		/obj/structure/flora/bush/snow/style_random
	)

/obj/effect/landmark/trainstation/object_spawner/grass
	accuracy = 3
	possible_objects = list(
		/obj/structure/flora/grass/both/style_random
	)
	max_delay = 4 SECONDS


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
	var/name = "Train station"
	var/desc = "A generic train station"
	var/station_flags = NONE
	var/visible = TRUE

	var/required_stations = 0

	var/map_path
	var/datum/map_template/template = null

	var/list/docking_turfs = list()
	var/list/possible_next = list()
	// Блокирует ли эта станция движение поезда
	var/blocking_moving = FALSE

	var/ambience_sounds = null
	VAR_PRIVATE/datum/looping_sound/global_sound/station_loop_soound = null

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

/datum/train_station/proc/load_station(datum/callback/load_callback)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!template)
		return FALSE
	var/start_time = world.realtime
	var/obj/effect/landmark/trainstation/station_spawnpoint/spawnpoint = locate() in GLOB.landmarks_list
	if(!spawnpoint || !istype(spawnpoint))
		stack_trace("Failed to load train station [name], no available spawnpoints!")
		return FALSE
	var/offset_x = spawnpoint.x
	var/offset_y = spawnpoint.y - template.height + 1
	var/offset_z = spawnpoint.z

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

	var/load_in = world.realtime - start_time
	message_admins("TRAINSTATION: Loaded station [name] in [time2text(load_in, "ss")] seconds!")
	if(load_callback)
		load_callback.Invoke()
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
	after_unload()

/datum/train_station/proc/after_unload()
	if(station_loop_soound)
		station_loop_soound.stop()



/datum/train_station/train_backstage
	name = "Iced forest"
	map_path = "_maps/modular_events/trainstation/backstage.dmm"
	station_flags = TRAINSTATION_ABSCTRACT | TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION
	visible = FALSE



/datum/train_station/start_point
	name = "Start-point"
	map_path = "_maps/modular_events/trainstation/startpoint.dmm"
	possible_next = list(/datum/train_station/military_house)
	station_flags = TRAINSTATION_NO_FORKS | TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING

/datum/train_station/military_house
	name = "Military Side"
	map_path = "_maps/modular_events/trainstation/military_side.dmm"
	station_flags = TRAINSTATION_NO_SELECTION | TRAINSTATION_BLOCKING


/datum/train_station/warehouses
	name = "Abandoned warehouses"
	map_path = "_maps/modular_events/trainstation/warehouse.dmm"
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/frozen_lake
	name = "Frozen lake"
	map_path = "_maps/modular_events/trainstation/iced_lake.dmm"

/datum/train_station/mines
	name = "Abandoned mines"
	map_path = "_maps/modular_events/trainstation/abandoned_mines.dmm"
	station_flags = TRAINSTATION_BLOCKING

/datum/train_station/deep_forest
	name = "Deep forest"
	map_path = "_maps/modular_events/trainstation/deep_forest.dmm"

/datum/train_station/collapsed_lab
	name = "Collapsed laboratory"
	map_path = "_maps/modular_events/trainstation/collapsed_lab.dmm"
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 3


/datum/train_station/radiosphere
	name = "The Radiosphere"
	map_path = "_maps/modular_events/trainstation/radiosphere.dmm"
	station_flags = TRAINSTATION_BLOCKING
	required_stations = 3

	ambience_sounds = list('modular_zvents/sounds/radiosphere_loop1.ogg' = 40 SECONDS)
