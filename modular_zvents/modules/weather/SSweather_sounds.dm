/datum/weather
	var/list/playlist = null
	var/list/area_sound_types = null
	var/outdoor_sound_type
	var/indoor_sound_type

/datum/controller/subsystem/weather
	var/list/active_weather_playlists = list()

/datum/controller/subsystem/weather/proc/setup_weather_sounds(datum/weather/W)
	if(!W.outdoor_sound_type && !W.indoor_sound_type)
		return

	if(!W.area_sound_types)
		W.area_sound_types = list()
		for(var/area/impacted_area in W.impacted_areas)
			var/sound_type = impacted_area.outdoors ? W.outdoor_sound_type : W.indoor_sound_type
			W.area_sound_types[impacted_area] = sound_type


	var/list/playlist = list()
	for(var/area/A in W.area_sound_types)
		var/datum/looping_sound/S = W.area_sound_types[A]
		playlist[A] = S

	W.playlist = playlist

/datum/controller/subsystem/weather/proc/force_weather_sounds(mob/M)
	if(!M.client || !M.z)
		return

	for(var/datum/weather/W in processing)
		if(!(M.z in W.impacted_z_levels) || !W.playlist)
			continue

		M.AddElement(/datum/element/weather_listener, W.type, W.target_trait, W.playlist)

/datum/controller/subsystem/weather/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_MOB_CLIENT_LOGIN, PROC_REF(on_client_login))

/datum/controller/subsystem/weather/proc/on_client_login(mob/M, client/C)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(force_weather_sounds), M), 3 SECONDS)

/datum/controller/subsystem/weather/run_weather(datum/weather/weather_datum_type, z_levels, list/weather_data)
	. = ..()

	var/datum/weather/W = locate() in processing
	if(!W)
		return

	setup_weather_sounds(W)
	for(var/mob/client in GLOB.alive_player_list)
		force_weather_sounds(client)
	RegisterSignal(W, COMSIG_QDELETING, PROC_REF(on_weather_end))

/datum/controller/subsystem/weather/proc/on_weather_end(datum/weather/W)
	SIGNAL_HANDLER
	W.playlist = null
	W.area_sound_types = null
