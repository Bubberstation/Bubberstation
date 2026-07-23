/// Name of the room the drunken shuttle is about to crash into, for the klaxon.
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

/obj/effect/station_crash/oh_no/shuttle_crash()
	var/list/candidates = prob(VITEZSTVI_FUNNY_LANDING_CHANCE) ? vitezstvi_funny_areas() : vitezstvi_crash_areas()
	var/turf/target = length(candidates) ? get_safe_random_station_turf(candidates) : null
	// a comedic pick can miss on maps lacking that room, so fall back before the vanilla helper
	if(!target)
		target = get_safe_random_station_turf(vitezstvi_crash_areas())
	if(!target)
		target = get_safe_random_station_turf()
	if(!target)
		return ..()

	var/area/crash_area = get_area(target)
	GLOB.vitezstvi_crash_area_name = crash_area?.name || "an unknown compartment"

	for(var/station_port in SSshuttle.stationary_docking_ports)
		var/obj/docking_port/stationary/home_port = station_port
		if(home_port.shuttle_id != "emergency_home")
			continue
		home_port.forceMove(target)
		// shuttle rotates to match its dock, so a random facing varies the angle of entry
		home_port.setDir(pick(GLOB.cardinals))
		break

#undef VITEZSTVI_FUNNY_LANDING_CHANCE
