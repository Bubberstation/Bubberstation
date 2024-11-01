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
		/area/ruin/syndicate_lava_base, // Interdyne (ice moon)
		/area/ruin/space/has_grav/bubbers/dauntless, // SSV Dauntless (lavalands)
		/area/ruin/space/has_grav/bubbers/dauntless_space, // SSV Dauntless (space)
		/area/ruin/space/has_grav/bubbers/persistance, // Both Persistence maps
	))

	var/is_syndie_machine = is_type_in_typecache(location_area.loc, syndie_typecache) // If the machine is located within a Syndie tagged area
	var/list/filtered_servers = list()
	for (var/obj/machinery/rnd/server/server as anything in valid_servers) // Filter Syndie machines for Syndie R&D, and non-Syndie machines to non-Syndie R&D
		var/area/server_area = get_area(server)
		var/is_syndie_server = is_type_in_typecache(server_area, syndie_typecache) // If the server is located within a Syndie tagged area
		if(is_syndie_machine == is_syndie_server) // If both machines are on Syndie turf, or both are not on Syndie turf
			filtered_servers += server
	return filtered_servers
