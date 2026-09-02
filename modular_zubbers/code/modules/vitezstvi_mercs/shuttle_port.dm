/// Furthest the hull will shove debris. Past the long axis.
#define VITEZSTVI_SHOVE_LIMIT 48
/// Opt-out row in the admin list.
#define VITEZSTVI_LEAVE_IT "Leave it to the drunks"

/obj/docking_port/mobile/emergency/vitezstvi
	/// Time before impact to fire each collision warning.
	var/early_warning_time = 30 SECONDS
	var/imminent_warning_time = 8 SECONDS
	var/early_warned = FALSE
	var/imminent_warned = FALSE
	/// Fraction of the approach at which we poll ghosts.
	var/deploy_fraction = 0.5
	/// Total inbound flight time this approach, in deciseconds.
	var/inbound_total_time = 0
	var/contractors_deployed = FALSE
	/// What was aboard just before impact.
	var/list/manifest

/obj/docking_port/mobile/emergency/vitezstvi/check()
	if(mode == SHUTTLE_CALL)
		var/time_left = timeLeft(1)
		if(!early_warned && time_left <= early_warning_time)
			early_warned = TRUE
			var/site_line = GLOB.vitezstvi_crash_area_name || "Somewhere important"
			priority_announce(
				text = "Station, this is VARS-7 Provodnik. Quartermaster, you old bastard, we received your tender. We are coming to get your people out. There is only small problem with approach vector. Pavel, why is station getting bigger? [site_line]? Comrades in this area, please be comrades somewhere else. Thank you for choosing Vítězství Arms.",
				title = "COLLISION WARNING",
				sound = 'sound/machines/warning-buzzer.ogg',
				sender_override = "VARS-7 Proximity Alarm",
				color_override = "red",
			)
		if(!imminent_warned && time_left <= imminent_warning_time)
			imminent_warned = TRUE
			take_manifest()
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
		clear_wreckage()
		play_landing_impact()
	return .

/// Proximity alarm
/obj/docking_port/mobile/emergency/vitezstvi/proc/sound_collision_klaxon()
	for(var/mob/listener as anything in GLOB.player_list)
		var/turf/listener_turf = get_turf(listener)
		if(!listener_turf || !SSmapping.level_trait(listener_turf.z, ZTRAIT_STATION))
			continue
		SEND_SOUND(listener, 'sound/machines/warning-buzzer.ogg')

/// Spoomy boomy
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

	// Shuttle needs to shake both levels of a multi z station
	for(var/z_level in SSmapping.get_connected_levels(epicentre))
		var/turf/deck_epicentre = locate(epicentre.x, epicentre.y, z_level)
		if(!deck_epicentre)
			continue
		SSexplosions.shake_the_room(deck_epicentre, 14, 255, 3, 6)

	playsound(epicentre, 'sound/vehicles/car_crash.ogg', 100, vary = FALSE, falloff_distance = 25)

	for(var/mob/passenger as anything in passengers)
		SEND_SOUND(passenger, 'sound/vehicles/car_crash.ogg')

	do_sparks(8, TRUE, epicentre)
	do_smoke(3, epicentre, epicentre)

/// Poll ghosts into the contractor bunks.
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
	manifest = null
	. = ..()
	// timeLeft(1) is deciseconds; the parent just set the timer
	inbound_total_time = timeLeft(1)
	vitezstvi_announce_target()

/// REF() strings, not atoms, so nothing gets held alive.
/obj/docking_port/mobile/emergency/vitezstvi/proc/take_manifest()
	manifest = list()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			for(var/atom/movable/thing in shuttle_turf)
				manifest[REF(thing)] = TRUE

/// Docking shoves junk one tile, which lands it inside. Push it the rest of the way out.
/obj/docking_port/mobile/emergency/vitezstvi/proc/clear_wreckage()
	if(!manifest)
		return
	var/list/debris = list()
	var/turf/sample
	var/min_x = INFINITY
	var/max_x = 0
	var/min_y = INFINITY
	var/max_y = 0
	for(var/area/shuttle_area as anything in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			sample = shuttle_turf
			min_x = min(min_x, shuttle_turf.x)
			max_x = max(max_x, shuttle_turf.x)
			min_y = min(min_y, shuttle_turf.y)
			max_y = max(max_y, shuttle_turf.y)
			for(var/atom/movable/thing in shuttle_turf)
				if(ismob(thing) || manifest[REF(thing)])
					continue
				debris += thing
	manifest = null
	if(!length(debris) || !sample)
		return
	var/turf/centre = locate(round((min_x + max_x) * 0.5), round((min_y + max_y) * 0.5), sample.z)
	for(var/atom/movable/thing as anything in debris)
		shove_clear(thing, centre)

/// Walks debris outward until it clears the hull.
/obj/docking_port/mobile/emergency/vitezstvi/proc/shove_clear(atom/movable/thing, turf/centre)
	var/turf/current = get_turf(thing)
	if(!current)
		return
	var/push_dir = get_dir(centre, current) || pick(GLOB.cardinals)
	for(var/steps_taken in 1 to VITEZSTVI_SHOVE_LIMIT)
		var/turf/next_turf = get_step(current, push_dir)
		if(!next_turf)
			break
		current = next_turf
		if(!isopenturf(current) || (get_area(current) in shuttle_areas))
			continue
		thing.forceMove(current)
		return
	// boxed in by the map edge
	qdel(thing)

/obj/docking_port/mobile/emergency/vitezstvi/Topic(href, list/href_list)
	. = ..()
	if(!href_list["vitezstvi_retarget"])
		return
	if(!check_rights(R_ADMIN))
		return
	admin_retarget(usr)

/// Deliberately unrestricted: every station area is offered.
/obj/docking_port/mobile/emergency/vitezstvi/proc/admin_retarget(mob/user)
	if(early_warned)
		to_chat(user, span_warning("The shuttle is too close to alter its trajectory!"))
		return
	var/list/options = list()
	for(var/area_path in GLOB.the_station_areas)
		var/area/candidate = GLOB.areas_by_type[area_path]
		if(candidate)
			options[candidate.name] = candidate
	if(!length(options))
		to_chat(user, span_warning("There are no station areas to aim at."))
		return
	var/list/menu = sort_list(options)
	menu.Insert(1, VITEZSTVI_LEAVE_IT)
	var/choice = tgui_input_list(user, "Where we droppin'?", "Vitezstvi Arms Flight Control", menu)
	if(isnull(choice) || choice == VITEZSTVI_LEAVE_IT)
		return
	var/area/destination = options[choice]
	var/turf/target = vitezstvi_crash_turf(list(destination.type))
	if(!target || !vitezstvi_place_crash_target(target))
		to_chat(user, span_warning("Nowhere to put a shuttle in [choice]."))
		return
	vitezstvi_announce_target(rerouted = TRUE)
	message_admins("[key_name_admin(user)] rerouted the VARS-7 Provodnik to [choice].")
	log_admin("[key_name(user)] rerouted the VARS-7 Provodnik to [choice].")

#undef VITEZSTVI_SHOVE_LIMIT
#undef VITEZSTVI_LEAVE_IT
