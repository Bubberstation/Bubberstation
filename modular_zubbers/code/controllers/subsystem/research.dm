/**
 * Only expose Syndicate R&D servers to machines placed inside of Syndicate areas (fixes oversight of NT station machines linking to Syndie R&D servers for moon based stations)
 * Returns filtered servers as a list
 */
/datum/controller/subsystem/research/find_valid_servers(turf/location, datum/techweb/checking_web)
	var/list/valid_servers = ..()
	if(!valid_servers || length(valid_servers) < 1)
		return valid_servers

	var/area/location_area = get_turf(location)
	var/static/list/syndie_typecache = typecacheof(list(
		/area/ruin/space/has_grav/skyrat/interdynefob, // DS-2
		/area/ruin/syndicate_ice_base, // Interdyne (ice moon)
		/area/ruin/space/has_grav/bubbers/dauntless, // SSV Dauntless (lavalands)
		/area/ruin/space/has_grav/bubbers/dauntless_space, // SSV Dauntless (space)
	))

	var/is_syndie_machine = is_type_in_typecache(location_area.loc, syndie_typecache) // If the machine is located within a Syndie tagged area
	var/list/filtered_servers = list()
	for (var/obj/machinery/rnd/server/server as anything in valid_servers) // Filter Syndie machines for Syndie R&D, and non-Syndie machines to non-Syndie R&D
		var/area/server_area = get_area(server)
		var/is_syndie_server = is_type_in_typecache(server_area, syndie_typecache) // If the server is located within a Syndie tagged area
		if(is_syndie_machine == is_syndie_server) // If both machines are on Syndie turf, or both are not on Syndie turf
			filtered_servers += server
	return filtered_servers
 
/datum/controller/subsystem/research/get_available_local_servers(turf/location)
	var/list/local_servers = ..()
	if(local_servers && (length(local_servers) > 1)) /// If there was more than 1 valid server located off-station, find closest server
		var/server_distance_closest = INFINITY
		var/server_distance_current = INFINITY
		var/obj/machinery/rnd/server/closest_server = local_servers[1]

		for (var/obj/machinery/rnd/server/individual_server as anything in local_servers)
			if(location.z != individual_server.z) /// Not on the same z level, skip
				continue
			server_distance_current = get_dist(location, get_turf(individual_server))
			if(server_distance_closest > server_distance_current) /// This is closer than the last server we tested
				server_distance_closest = server_distance_current
				closest_server = individual_server
		return list(closest_server)
	return local_servers
//This is literally the same as get_available_servers() but without the check for if the server is on the station Z or not. Used as a bypass for the Interdyne research server.
