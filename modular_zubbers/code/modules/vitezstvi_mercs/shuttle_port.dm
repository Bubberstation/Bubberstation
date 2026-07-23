/obj/docking_port/mobile/emergency/vitezstvi
	/// Time before impact to fire each collision warning.
	var/early_warning_time = 30 SECONDS
	var/imminent_warning_time = 8 SECONDS
	var/early_warned = FALSE
	var/imminent_warned = FALSE
	/// Fraction of the inbound approach at which we poll ghosts to crew the shuttle.
	var/deploy_fraction = 0.5
	/// Total inbound flight time this approach, in deciseconds.
	var/inbound_total_time = 0
	var/contractors_deployed = FALSE

/obj/docking_port/mobile/emergency/vitezstvi/check()
	if(mode == SHUTTLE_CALL)
		var/time_left = timeLeft(1)
		if(!early_warned && time_left <= early_warning_time)
			early_warned = TRUE
			var/site_line = GLOB.vitezstvi_crash_area_name || "somewhere important"
			priority_announce(
				text = "Station, this is VARS-7 Provodnik. Quartermaster, you old bastard, we received your tender. We are coming to get your people out. There is only small problem with approach vector. Pavel, why is station getting bigger? [site_line]? Comrades in this area, please be comrades somewhere else. Thank you for choosing Vítězství Arms.",
				title = "COLLISION WARNING",
				sound = 'sound/machines/warning-buzzer.ogg',
				sender_override = "VARS-7 Proximity Alarm",
				color_override = "red",
			)
		if(!imminent_warned && time_left <= imminent_warning_time)
			imminent_warned = TRUE
			priority_announce(
				text = "OH, BLYAT, PAVEL, IT IS STILL GETTING BIGGER! EVERYONE MOVE! GET THE FUCK OUT OF THE WAY!",
				title = "COLLISION WARNING",
				sender_override = "VARS-7 Proximity Alarm",
				color_override = "red",
			)
			sound_collision_klaxon()
		// point of no return, so crew it from deadchat like the carp escape event does
		if(!contractors_deployed && inbound_total_time && time_left <= inbound_total_time * deploy_fraction)
			contractors_deployed = TRUE
			INVOKE_ASYNC(src, PROC_REF(deploy_contractors))
	var/was_inbound = (mode == SHUTTLE_CALL)
	. = ..()
	if(was_inbound && mode == SHUTTLE_DOCKED)
		play_landing_impact()
	return .

/// Proximity alarm, scoped to the station so nobody in deep space gets it.
/obj/docking_port/mobile/emergency/vitezstvi/proc/sound_collision_klaxon()
	var/sound/klaxon = sound('sound/machines/warning-buzzer.ogg', volume = 100)
	for(var/mob/listener as anything in GLOB.player_list)
		var/turf/listener_turf = get_turf(listener)
		if(!listener_turf || !SSmapping.level_trait(listener_turf.z, ZTRAIT_STATION))
			continue
		SEND_SOUND(listener, klaxon)

/// Sensory reach only. No explosion() call: the hull already does the structural damage.
/obj/docking_port/mobile/emergency/vitezstvi/proc/play_landing_impact()
	var/turf/epicentre
	var/list/passengers = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			if(!epicentre)
				epicentre = shuttle_turf
			for(var/mob/passenger in shuttle_turf)
				passengers += passenger
	if(!epicentre)
		return

	// shake_the_room only reaches one z, so run it per connected deck
	for(var/z_level in SSmapping.get_connected_levels(epicentre))
		var/turf/deck_epicentre = locate(epicentre.x, epicentre.y, z_level)
		if(!deck_epicentre)
			continue
		SSexplosions.shake_the_room(deck_epicentre, 14, 255, 3, 6)

	playsound(epicentre, 'sound/vehicles/car_crash.ogg', 100, vary = FALSE, falloff_distance = 25)

	var/sound/impact = sound('sound/vehicles/car_crash.ogg', volume = 100)
	for(var/mob/passenger as anything in passengers)
		SEND_SOUND(passenger, impact)

	do_sparks(8, TRUE, epicentre)
	do_smoke(3, epicentre, epicentre)

/// Poll ghosts into the contractor bunks. Unclaimed bunks stay as set dressing.
/obj/docking_port/mobile/emergency/vitezstvi/proc/deploy_contractors()
	var/list/bunks = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/bunk in shuttle_area)
			bunks += bunk
	if(!length(bunks))
		return
	var/list/takers = SSpolling.poll_ghost_candidates(
		question = "Would you like to be considered for a position at Vítězství Arms?",
		check_jobban = ROLE_SENTIENCE,
		poll_time = 20 SECONDS,
		alert_pic = /obj/item/radio/headset/vitezstvi,
		role_name_text = "Vitezstvi Arms contractor",
		amount_to_pick = length(bunks),
	)
	if(!islist(takers))
		takers = takers ? list(takers) : list()
	for(var/mob/dead/observer/taker in takers)
		if(!length(bunks))
			break
		var/obj/effect/mob_spawn/ghost_role/human/vitezstvi_merc/bunk = pick(bunks)
		bunks -= bunk
		if(taker?.ckey)
			bunk.create_from_ghost(taker, apply_prefs = TRUE)

/obj/docking_port/mobile/emergency/vitezstvi/request(obj/docking_port/stationary/S, area/signal_origin, reason, red_alert, set_coefficient = null)
	early_warned = FALSE
	imminent_warned = FALSE
	contractors_deployed = FALSE
	. = ..()
	// timeLeft(1) is deciseconds, and the parent call just set the timer
	inbound_total_time = timeLeft(1)
