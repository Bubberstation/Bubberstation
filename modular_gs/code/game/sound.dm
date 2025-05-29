/proc/playsound_prefed(atom/source, soundin, pref, vol as num, vary, extrarange as num, falloff_exponent = SOUND_FALLOFF_EXPONENT, frequency = null, channel = 0, pressure_affected = TRUE, ignore_walls = TRUE,
	falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, envwet = -10000, envdry = 0, distance_multiplier = SOUND_DEFAULT_DISTANCE_MULTIPLIER, distance_multiplier_min_range = SOUND_DEFAULT_MULTIPLIER_EFFECT_RANGE)
	if(isarea(source))
		CRASH("playsound(): source is an area")

	var/turf/turf_source = get_turf(source)

	if (!turf_source)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || SSsounds.random_available_channel()

	// Looping through the player list has the added bonus of working for mobs inside containers
	var/sound/S = sound(get_sfx(soundin))
	var/maxdistance = SOUND_RANGE + extrarange
	var/source_z = turf_source.z
	var/list/listeners = SSmobs.clients_by_zlevel[source_z].Copy()

	var/turf/above_turf = SSmapping.get_turf_above(turf_source)
	var/turf/below_turf = SSmapping.get_turf_below(turf_source)

	if(!ignore_walls) //these sounds don't carry through walls
		listeners = listeners & hearers(maxdistance,turf_source)

		if(above_turf && istransparentturf(above_turf))
			listeners += hearers(maxdistance,above_turf)

		if(below_turf && istransparentturf(turf_source))
			listeners += hearers(maxdistance,below_turf)

	else
		if(above_turf && istransparentturf(above_turf))
			listeners += SSmobs.clients_by_zlevel[above_turf.z]

		if(below_turf && istransparentturf(turf_source))
			listeners += SSmobs.clients_by_zlevel[below_turf.z]

	for(var/P in listeners)
		var/mob/M = P
		if(!(M.client?.prefs.cit_toggles & pref))
			continue
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff_exponent, channel, pressure_affected, S, maxdistance, falloff_distance, get_dist(M, turf_source) <= distance_multiplier_min_range? 1 : distance_multiplier, envwet, envdry)
	for(var/P in SSmobs.dead_players_by_zlevel[source_z])
		var/mob/M = P
		if(!(M.client?.prefs.cit_toggles & pref))
			continue
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff_exponent, channel, pressure_affected, S, maxdistance, falloff_distance, get_dist(M, turf_source) <= distance_multiplier_min_range? 1 : distance_multiplier, envwet, envdry)
