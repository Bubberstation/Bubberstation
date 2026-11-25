/// Room the drunks are arriving through, for the klaxon.
GLOBAL_VAR_INIT(vitezstvi_crash_area_name, null)
/// The real dock's position before we ever touched it, so it can be put back.
GLOBAL_VAR_INIT(vitezstvi_home_dock_original, null)

/// Chance of picking a comedic target instead of any real room.
#define VITEZSTVI_FUNNY_LANDING_CHANCE 10

/// Rooms it is funniest to arrive through, unannounced, at speed.
/proc/vitezstvi_funny_areas()
	return list(
		/area/station/security/armory,
		/area/station/security/prison,
		/area/station/service/bar,
		/area/station/service/kitchen,
		/area/station/service/chapel,
		/area/station/service/theater,
		/area/station/medical/surgery,
		/area/station/command/bridge,
		/area/station/command/heads_quarters/captain,
	)

/// Any actual room. Hallways and maintenance are blacklisted by type for being unfunny and also because there are a shitload of them.
/proc/vitezstvi_crash_areas()
	var/static/list/excluded = list(
		/area/station/maintenance,
		/area/station/hallway,
	)
	var/list/candidates = list()
	for(var/area/station_area_path as anything in GLOB.the_station_areas)
		if(!is_path_in_list(station_area_path, excluded))
			candidates += station_area_path
	return candidates

/// Hull's long axis. The dock point is kept at least this far from the map edge.
#define VITEZSTVI_EDGE_MARGIN 44

/// Any floor will do. We are crashing a shuttle, not parking it.
/proc/vitezstvi_crash_turf(list/areas_to_pick_from)
	if(!length(areas_to_pick_from))
		return null
	for(var/attempt in 1 to 5)
		var/list/turf_list = get_area_turfs(pick(areas_to_pick_from))
		while(length(turf_list))
			var/index = rand(1, length(turf_list))
			var/turf/candidate = turf_list[index]
			if(!candidate.density && !isgroundlessturf(candidate))
				return vitezstvi_pull_inbounds(candidate)
			turf_list.Cut(index, index + 1)
	return null

/// An overhanging hull fails to dock and retries forever, so drag the target back inside instead.
/proc/vitezstvi_pull_inbounds(turf/candidate)
	var/inbound_x = clamp(candidate.x, VITEZSTVI_EDGE_MARGIN, world.maxx - VITEZSTVI_EDGE_MARGIN)
	var/inbound_y = clamp(candidate.y, VITEZSTVI_EDGE_MARGIN, world.maxy - VITEZSTVI_EDGE_MARGIN)
	if(inbound_x == candidate.x && inbound_y == candidate.y)
		return candidate
	return locate(inbound_x, inbound_y, candidate.z)

/// Aims the drunks at a turf. Used by the opening roll and by admins.
/proc/vitezstvi_place_crash_target(turf/target)
	if(!target)
		return FALSE
	var/area/crash_area = get_area(target)
	for(var/station_port in SSshuttle.stationary_docking_ports)
		var/obj/docking_port/stationary/home_port = station_port
		if(home_port.shuttle_id != "emergency_home")
			continue
		if(isnull(GLOB.vitezstvi_home_dock_original))
			GLOB.vitezstvi_home_dock_original = list(home_port.x, home_port.y, home_port.z, home_port.dir)
		home_port.forceMove(target)
		// shuttle rotates to match its dock, so a random facing varies the angle of entry
		home_port.setDir(pick(GLOB.cardinals))
		GLOB.vitezstvi_crash_area_name = crash_area?.name || "an unknown compartment"
		return TRUE
	return FALSE

/// Rolls this call's crash site. Only called from a genuine request(), never a preview.
/proc/vitezstvi_roll_crash_target()
	var/turf/target
	if(prob(VITEZSTVI_FUNNY_LANDING_CHANCE))
		target = vitezstvi_crash_turf(vitezstvi_funny_areas())
	target ||= vitezstvi_crash_turf(vitezstvi_crash_areas())
	target ||= get_safe_random_station_turf()
	vitezstvi_place_crash_target(target)

/// Hands the real dock back once our own ship has already landed on it.
/proc/vitezstvi_restore_home_dock()
	if(isnull(GLOB.vitezstvi_home_dock_original))
		return
	var/list/original = GLOB.vitezstvi_home_dock_original
	for(var/station_port in SSshuttle.stationary_docking_ports)
		var/obj/docking_port/stationary/home_port = station_port
		if(home_port.shuttle_id != "emergency_home")
			continue
		home_port.forceMove(locate(original[1], original[2], original[3]))
		home_port.setDir(original[4])
		break
	GLOB.vitezstvi_home_dock_original = null

/// Ghosts get a seat, admins get a veto.
/proc/vitezstvi_announce_target(rerouted = FALSE)
	var/site = GLOB.vitezstvi_crash_area_name || "somewhere important"
	var/obj/docking_port/mobile/emergency/vitezstvi/port = locate() in SSshuttle.mobile_docking_ports
	notify_ghosts(
		"The VARS-7 Provodnik is [rerouted ? "now" : ""] inbound to [site].",
		source = port,
		header = "Incoming Shuttle",
	)
	if(!port)
		message_admins("VARS-7 Provodnik is inbound to [site].")
		return
	message_admins("VARS-7 Provodnik is inbound to [site]. (<a href='byond://?src=[REF(port)];vitezstvi_retarget=1'>CHANGE LANDING ZONE</a>)")

#undef VITEZSTVI_FUNNY_LANDING_CHANCE
#undef VITEZSTVI_EDGE_MARGIN
