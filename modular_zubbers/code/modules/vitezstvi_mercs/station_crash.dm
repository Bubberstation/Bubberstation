/// Room the drunks are arriving through, for the klaxon.
GLOBAL_VAR_INIT(vitezstvi_crash_area_name, null)

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

/// Any actual room. Hallways and maintenance are excluded for being unfunny.
/proc/vitezstvi_crash_areas()
	var/static/list/excluded = list(
		/area/station/hallway,
		/area/station/maintenance,
	)
	var/list/candidates = list()
	for(var/area/station_area_path as anything in GLOB.the_station_areas)
		var/skip = FALSE
		for(var/area_path in excluded)
			if(ispath(station_area_path, area_path))
				skip = TRUE
				break
		if(!skip)
			candidates += station_area_path
	return candidates

/obj/effect/station_crash/oh_no
	name = "drunken station crash"
	desc = "Go home Ivan, you're drunk. (The shuttle will pick a room completely at random to crash land on. Oh, the humanity.)"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "vodkabottle"

/// Aims the drunks at a turf. Used by the opening roll and by admins.
/proc/vitezstvi_place_crash_target(turf/target)
	if(!target)
		return FALSE
	var/area/crash_area = get_area(target)
	for(var/station_port in SSshuttle.stationary_docking_ports)
		var/obj/docking_port/stationary/home_port = station_port
		if(home_port.shuttle_id != "emergency_home")
			continue
		home_port.forceMove(target)
		// shuttle rotates to match its dock, so a random facing varies the angle of entry
		home_port.setDir(pick(GLOB.cardinals))
		GLOB.vitezstvi_crash_area_name = crash_area?.name || "an unknown compartment"
		return TRUE
	return FALSE

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

/obj/effect/station_crash/oh_no/shuttle_crash()
	var/list/candidates = prob(VITEZSTVI_FUNNY_LANDING_CHANCE) ? vitezstvi_funny_areas() : vitezstvi_crash_areas()
	var/turf/target = length(candidates) ? get_safe_random_station_turf(candidates) : null
	// comedic picks can miss on some maps, so fall back
	if(!target)
		target = get_safe_random_station_turf(vitezstvi_crash_areas())
	if(!target)
		target = get_safe_random_station_turf()
	if(!vitezstvi_place_crash_target(target))
		return ..()

#undef VITEZSTVI_FUNNY_LANDING_CHANCE
