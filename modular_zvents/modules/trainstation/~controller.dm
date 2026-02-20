/datum/map_config
	// Является ли эта карта - поездом
	var/trainstation = FALSE

SUBSYSTEM_DEF(train_controller)
	name = "Train Controller"
	wait = 1 SECONDS

	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/daylight,
	)
	// В какую сторону якобы двигается наш поезд
	var/abstract_moving_direction = EAST
	/// Может ли наш поезд двигаться без рабочего двигателя?
	VAR_PRIVATE/no_engine_mode = FALSE
	VAR_PRIVATE/moving = FALSE
	VAR_PRIVATE/datum/looping_sound/global_sound/train_sound_loop/soundloop

	var/mode_active = TRUE

	var/list/running_events

	var/list/station_terminals
	/// Теущая выбранная тема для окружения поезда в движении
	var/datum/train_object_spawner_theme/selected_theme = null
	/// Ссылка на двигатель поезда!
	var/obj/machinery/power/train_turbine/core_rotor/train_engine = null
	// Загружается или выгружается в данный момент станция
	var/loading = FALSE
	// Станция запланированная для загрузки
	var/datum/train_station/planned_to_load = null
	// Текущая загруженная станция
	var/datum/train_station/loaded_station = null
	// Известные, загруженные станции
	var/static/list/known_stations = list()

	var/tain_starting = FALSE
	var/minimum_travel_time = 15 MINUTES
	var/maximum_travel_time = 30 MINUTES
	var/time_to_next_station
	var/total_travel_time
	var/stations_visited = 0



/**
 * Geters
 */

/datum/controller/subsystem/train_controller/proc/is_moving()
	return moving

/datum/controller/subsystem/train_controller/proc/allow_spawning()
	if(loaded_station.station_flags & TRAINSTATION_NO_SPAWNING)
		return FALSE
	return TRUE

/datum/controller/subsystem/train_controller/proc/check_trainstation()
	if(!SSmapping.current_map)
		return FALSE
	if(!SSmapping.current_map.trainstation)
		return FALSE
	return FALSE

/**
 * Loading and inititialization
 */

/datum/controller/subsystem/train_controller/Initialize()
	var/list/map_traits = SSmapping.current_map.traits[1]
	if(!map_traits || !islist(map_traits))
		return
	var/is_trainstation = map_traits[ZTRAIT_TRAINSTATION] || FALSE
	if(!is_trainstation)
		return SS_INIT_NO_NEED

	mode_active = TRUE
	update_tittle_screen()
	running_events = list()
	soundloop = new(start_immediately = FALSE)
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_enter_pregame))
	load_stations()
	add_startup_message("Trainstation: loading game map...")
	load_map()

/datum/controller/subsystem/train_controller/proc/load_stations()
	for(var/path in subtypesof(/datum/train_station))
		known_stations += new path
	for(var/datum/train_station/station in known_stations)
		station.connect_stations()

/datum/controller/subsystem/train_controller/proc/load_map()
	load_train()
	load_startpoint()
	for(var/obj/machinery/light/light in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		light.update()


/datum/controller/subsystem/train_controller/proc/load_train()
	var/datum/map_template/train/train_template = new()
	var/obj/effect/landmark/trainstation/train_spawnpoint/spawnpoint = locate() in GLOB.landmarks_list
	if(!spawnpoint || !istype(spawnpoint))
		stack_trace("Failed to load train, no available spawnpoints!")
		return
	var/turf/actual_spawnpoint = get_turf(spawnpoint)
	if(!actual_spawnpoint)
		stack_trace("Failed to load train, spawnpoint out of bounds!")
		return
	train_template.load(actual_spawnpoint, centered = FALSE)

/datum/controller/subsystem/train_controller/proc/load_startpoint()
	load_station(/datum/train_station/abandoned_depo, stop_moving = FALSE, hide_for_players = FALSE, announce = FALSE)

/datum/controller/subsystem/train_controller/proc/on_enter_pregame()
	SIGNAL_HANDLER
	// Сперва на перво сообщим об правилах игры
	announce_game()
	set_station_name("Trainstation 13")
	addtimer(CALLBACK(src, PROC_REF(set_lobby_screen)), 5 SECONDS)

/**
 * Station handling
 */

/datum/controller/subsystem/train_controller/proc/connect_terminals()
	if(!station_terminals || !length(station_terminals))
		return
	for(var/obj/machinery/computer/trainstation_control/control in station_terminals)
		control.set_station(loaded_station)


/datum/controller/subsystem/train_controller/proc/pick_possible_stations()
	var/station_count = rand(1, 2)
	var/list/possible = shuffle(known_stations.Copy())
	var/selected = null
	var/selected_count = 0
	for(var/datum/train_station/station in possible)
		if(selected_count >= station_count)
			break
		if(station == loaded_station)
			continue
		if(stations_visited < station.required_stations)
			continue
		if(station.station_flags & TRAINSTATION_ABSCTRACT)
			continue
		if(station.station_flags & TRAINSTATION_NO_SELECTION)
			continue
		if(station.visited >= station.maximum_visits)
			continue
		LAZYADD(selected, station)
		selected_count += 1
	loaded_station.possible_next = selected


/datum/controller/subsystem/train_controller/proc/on_station_unloaded()

/datum/controller/subsystem/train_controller/proc/unload_station(datum/train_station/to_unload, hide_for_players = TRUE)
	if(!to_unload)
		return
	to_unload.unload_station(CALLBACK(src, PROC_REF(on_station_unloaded)))


/datum/controller/subsystem/train_controller/proc/on_station_loaded()

/datum/controller/subsystem/train_controller/proc/load_station(path_or_instance, stop_moving = FALSE, hide_for_players = TRUE, announce = TRUE)
	var/datum/train_station/to_load = null
	if(ispath(path_or_instance, /datum/train_station))
		to_load = locate(path_or_instance) in known_stations
	else if(istype(path_or_instance, /datum/train_station))
		to_load = path_or_instance

	if(!to_load)
		CRASH("Failed to load station [path_or_instance], invalid path!")
	if(hide_for_players)
		for(var/mob/living/L in GLOB.alive_player_list)
			L.overlay_fullscreen("station_loading", /atom/movable/screen/fullscreen/flash/black)

	if(loaded_station)
		unload_station(loaded_station, hide_for_players)
	loading = TRUE
	loaded_station = to_load
	loaded_station.pre_load()
	var/result = to_load.load_station(CALLBACK(src, PROC_REF(on_station_loaded)))
	if(!result)
		return
	if(stop_moving)
		stop_moving()
	for(var/mob/living/L in GLOB.alive_player_list)
		L.clear_fullscreen("station_loading", animated = 5 SECONDS)
	if(announce && !(loaded_station.station_flags & TRAINSTATION_ABSCTRACT))
		show_station_logo(to_load)
	connect_terminals()
	SEND_SIGNAL(src, COMSIG_TRAINSTATION_LOADED, loaded_station)
	loading = FALSE
	if(loaded_station.station_flags & TRAINSTATION_NO_FORKS)
		return
	pick_possible_stations()


/datum/controller/subsystem/train_controller/proc/show_station_logo(datum/train_station/station, silent = FALSE)
	for(var/mob/player in GLOB.player_list)
		if(!silent)
			SEND_SOUND(player, 'modular_zvents/sounds/effects/station_logo.ogg')
		new /atom/movable/screen/station_logo(null, null, station.name, station.creator, player.client)


/datum/controller/subsystem/train_controller/proc/set_movement_theme(datum/train_object_spawner_theme/new_theme)
	var/datum/train_object_spawner_theme/selected = null
	if(ispath(new_theme))
		selected = GLOB.train_spwaner_themes[new_theme]
	else if(istype(new_theme, /datum/train_object_spawner_theme))
		selected = new_theme

	if(!selected)
		stack_trace("Trying set null movement theme!")
		return
	if(selected_theme)
		selected_theme.on_deselected()
	selected_theme = selected
	selected_theme.on_selected()
	for(var/obj/effect/landmark/trainstation/object_spawner/spawner in GLOB.train_object_spawners)
		spawner.set_theme(selected)

/**
 * Movement handling
 */

/datum/controller/subsystem/train_controller/proc/attempt_start(delay = 15 SECONDS)
	if(moving || tain_starting)
		return
	if(loaded_station && loaded_station.blocking_moving)
		return
	if(!check_start())
		return
	if(!planned_to_load)
		return
	var/station_abstract = (loaded_station.station_flags & TRAINSTATION_ABSCTRACT) ? TRUE : FALSE
	var/msg = "The train will begin moving in [DisplayTimeText(delay)]! \
			[station_abstract ? "" : "Please prepare to depart from [loaded_station.name]."]"
	priority_announce(msg, "Train Departure")
	tain_starting = TRUE
	addtimer(CALLBACK(src, PROC_REF(start_moving), FALSE, TRUE, 0), delay)


/datum/controller/subsystem/train_controller/proc/check_start()
	if(SEND_SIGNAL(src, COMSIG_TRAIN_TRY_MOVE) & COMPONENT_BLOCK_TRAIN_MOVEMENT)
		return FALSE
	if(!train_engine && !no_engine_mode)
		return FALSE
	if(!train_engine.is_active() && !no_engine_mode)
		return FALSE
	return TRUE

/datum/controller/subsystem/train_controller/proc/pick_theme()
	for(var/theme_type in shuffle(GLOB.train_spwaner_themes.Copy()))
		var/datum/train_object_spawner_theme/theme = GLOB.train_spwaner_themes[theme_type]
		if(!theme.allow_selection)
			continue
		return theme

/datum/controller/subsystem/train_controller/proc/start_moving(force = FALSE, unload_station = TRUE)
	if(moving)
		return
	if((loaded_station && loaded_station.blocking_moving) && !force)
		return
	if(!check_start() && !force)
		return
	if(!planned_to_load)
		if(!force)
			return
		planned_to_load = pick(loaded_station.possible_next)

	if(!(loaded_station.station_flags & TRAINSTATION_ABSCTRACT))
		var/time_to_next = rand(minimum_travel_time, maximum_travel_time)
		time_to_next_station = time_to_next
		stations_visited += 1
	set_movement_theme(pick_theme())
	moving = TRUE
	if(unload_station && !istype(loaded_station, /datum/train_station/train_backstage))
		load_station(/datum/train_station/train_backstage, FALSE, TRUE, FALSE)
	SSmoving_turfs.on_train_start()
	soundloop.start()
	sound_to_playing_players('modular_zvents/sounds/steam_short.ogg', volume = 60)
	tain_starting = FALSE
	SEND_SIGNAL(src, COMSIG_TRAIN_BEGIN_MOVING)

/datum/controller/subsystem/train_controller/proc/stop_moving()
	if(!moving)
		return
	moving = FALSE
	SSmoving_turfs.on_train_stop()
	soundloop.stop(FALSE)
	sound_to_playing_players('modular_zvents/sounds/steam_long.ogg', volume = 60)
	if(no_engine_mode)
		no_engine_mode = FALSE
	SEND_SIGNAL(src, COMSIG_TRAIN_STOP_MOVING)

/datum/controller/subsystem/train_controller/fire(resumed)
	if(length(running_events))
		for(var/datum/round_event/evt in running_events)
			evt.process()

	if(!moving)
		return
	if((!train_engine || !train_engine.is_active()) && !no_engine_mode)
		stop_moving()
		return

	if(moving && planned_to_load && time_to_next_station >= 0)
		time_to_next_station -= wait
		total_travel_time += wait
		if(time_to_next_station <= 0)
			time_to_next_station = 0
			stop_moving()
			load_station(planned_to_load, stop_moving = TRUE, hide_for_players = TRUE, announce = TRUE)
			planned_to_load = null


/datum/controller/subsystem/train_controller/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrainMovementController")
		ui.open()

/datum/controller/subsystem/train_controller/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/train_controller/ui_data(mob/user)
	var/list/data = list()
	data["moving"] = moving
	data["num_turfs"] = length(SSmoving_turfs.to_process)
	data["stations"] = list()
	data["planned_station"] = planned_to_load?.name || "None"
	data["time_to_next_station"] = time_to_next_station
	data["total_travel_time"] = total_travel_time
	data["possible_next"] = list()
	for(var/datum/train_station/station in known_stations)
		if(!station.visible)
			continue
		data["stations"] += list(
			list(
				"name" = station.name,
				"type" = station.type,
				)
			)
	data["current_station"] = loaded_station?.name || "None"
	data["blocking"] = loaded_station?.blocking_moving || FALSE
	return data

/datum/controller/subsystem/train_controller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("open_vv")
			if(!check_rights(R_ADMIN))
				return
			usr.client.debug_variables(src)
		if("choose_next")
			var/station_type = text2path(params["station_type"])
			var/datum/train_station/next = locate(station_type) in known_stations
			if(next && loaded_station && (next in loaded_station.possible_next))
				planned_to_load = next
			return TRUE
		if("start_moving")
			if(!train_engine && !train_engine.is_active())
				no_engine_mode = TRUE
			start_moving(force = TRUE)
			return TRUE
		if("stop_moving")
			stop_moving()
			return TRUE
		if("set_speed")
			var/new_speed = params["speed"]
			if(isnum(new_speed) && new_speed > 0)
				return TRUE
		if("set_cooldown")
			var/new_cd = params["cooldown"]
			if(isnum(new_cd) && new_cd > 0)
				return TRUE
		if("load_station")
			var/station_type = text2path(params["station_type"])
			INVOKE_ASYNC(src, PROC_REF(load_station), station_type)
			return TRUE
		if("unload_station")
			if(loaded_station)
				INVOKE_ASYNC(src, PROC_REF(unload_station), loaded_station)
				loaded_station = null
				return TRUE

ADMIN_VERB(open_train_controller, R_ADMIN, "Open train controller", "Open active train controller.", ADMIN_CATEGORY_EVENTS)
	SStrain_controller.ui_interact(usr)

/obj/effect/mapping_helpers/ztrait_injector/trainstation
	traits_to_add = list(ZTRAIT_NOPARALLAX = TRUE, ZTRAIT_NOXRAY = TRUE, ZTRAIT_NOPHASE = TRUE, ZTRAT_TRAINSTATION = TRUE, ZTRAIT_BASETURF = /turf/open/space)


/atom/movable/screen/station_logo
	icon_state = "blank"
	plane = HUD_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	screen_loc = "CENTER-7,CENTER-7"

	var/fade_delay = 7 SECONDS
	var/client/parent = null

/atom/movable/screen/station_logo/Initialize(mapload, datum/hud/hud_owner, station_name, creator, client/to_show)
	. = ..()
	parent = to_show
	parent.screen += src
	var/icon_size = world.icon_size
	maptext = {"<div style="font:'Small Fonts'">[station_name] \n mady by [creator]</div>"}
	maptext_height = icon_size * 6
	maptext_width = icon_size * 24
	var/list/client_view = splittext(parent.view, "x")
	var/view_y = 15
	var/view_x = 21
	if(LAZYLEN(client_view) == 2)
		view_x = client_view[1]
		view_y = client_view[2]
	maptext_x = ((icon_size * view_x) + round(icon_size * 0.5)) * 13
	maptext_y = ((icon_size * view_y) + round(icon_size * 0.5)) * 13
	transform.Translate(10, 10)
	ASYNC
		rollem()

/atom/movable/screen/station_logo/proc/rollem()
	sleep(3 SECONDS)
	animate(src, alpha = 0, time = fade_delay, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, PROC_REF(fadeout)), fade_delay + 0.1 SECONDS)

/atom/movable/screen/station_logo/proc/fadeout()
	parent.screen -= src
	qdel(src)


/datum/looping_sound/global_sound/train_sound_loop
	sounds_to_play = list(
		'modular_zvents/sounds/loop_trainride.ogg' = 63 SECONDS,
	)
