/obj/docking_port/mobile/emergency/vitezstvi
	/// Time before impact to fire the first (early) collision warning.
	var/early_warning_time = 30 SECONDS
	/// Time before impact to fire the final imminent-impact klaxon.
	var/imminent_warning_time = 8 SECONDS
	/// Have we fired the early warning this approach?
	var/early_warned = FALSE
	/// Have we fired the imminent-impact klaxon this approach?
	var/imminent_warned = FALSE
	/// Fraction of the inbound approach at which we poll ghosts to crew the shuttle.
	var/deploy_fraction = 0.5
	/// Total inbound flight time this approach (deciseconds), captured when called.
	var/inbound_total_time = 0
	/// Have we already run the contractor deployment poll this approach?
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
		// Point of no return: the shuttle is committed to the station. Poll deadchat to
		// crew it, exactly like the carp/alien-queen escape events.
		if(!contractors_deployed && inbound_total_time && time_left <= inbound_total_time * deploy_fraction)
			contractors_deployed = TRUE
			INVOKE_ASYNC(src, PROC_REF(deploy_contractors))
	var/was_inbound = (mode == SHUTTLE_CALL)
	. = ..()
	// The drunks just put a shuttle through the station. Make some noise about it.
	if(was_inbound && mode == SHUTTLE_DOCKED)
		play_landing_impact()
	return .

/// The klaxon the newscaster uses for a wanted issue. Scoped to people actually on
/// the station, since nobody in deep space needs the proximity alarm.
/obj/docking_port/mobile/emergency/vitezstvi/proc/sound_collision_klaxon()
	var/sound/klaxon = sound('sound/machines/warning-buzzer.ogg', volume = 100)
	for(var/mob/listener as anything in GLOB.player_list)
		var/turf/listener_turf = get_turf(listener)
		if(!listener_turf || !SSmapping.level_trait(listener_turf.z, ZTRAIT_STATION))
			continue
		SEND_SOUND(listener, klaxon)

/// A shuttle arriving through a wall should be heard, felt and seen. The far-field
/// work is handed to SSexplosions.shake_the_room(), the same proc explosion() uses,
/// so distance falloff, hull creaking and screenshake behave exactly like an
/// ordnance test does. No real explosion() call: the hull does the damage already.
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

	// The shuttle is the size of a department and can punch down onto a lower deck, so
	// everyone aboard the station should feel it, not just the level it stopped on.
	// shake_the_room is single-z, so we run it once per connected level (a single-deck
	// station just gets the one). far_distance is set past any station's diagonal so
	// the echo and hull creak reach the whole deck.
	for(var/z_level in SSmapping.get_connected_levels(epicentre))
		var/turf/deck_epicentre = locate(epicentre.x, epicentre.y, z_level)
		if(!deck_epicentre)
			continue
		SSexplosions.shake_the_room(deck_epicentre, 14, 255, 3, 6)

	// The collision itself, on top of the blast, for anyone standing at the wreck.
	playsound(epicentre, 'sound/vehicles/car_crash.ogg', 100, vary = FALSE, falloff_distance = 25)

	// Everyone riding it in hears the crash wherever they happen to be standing.
	var/sound/impact = sound('sound/vehicles/car_crash.ogg', volume = 100)
	for(var/mob/passenger as anything in passengers)
		SEND_SOUND(passenger, impact)

	do_sparks(8, TRUE, epicentre)
	do_smoke(3, epicentre, epicentre)

/// Poll ghosts and drop them into the shuttle's contractor bunks. Bunks left
/// unclaimed simply stay as set dressing.
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
	// Capture the full inbound flight time so the deploy poll can fire at the halfway
	// point. timeLeft(1) is in deciseconds; the timer was just set by the parent call.
	inbound_total_time = timeLeft(1)
