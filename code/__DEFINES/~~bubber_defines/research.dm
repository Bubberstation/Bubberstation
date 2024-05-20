///Connects the 'server_var' to a valid research server on your Z level.
///Used for machines in LateInitialize, to ensure that RND servers are loaded first.
#define CONNECT_TO_LOCAL_SERVER_ROUNDSTART(server_var, holder) do { \
	var/list/found_servers = SSresearch.get_available_servers(get_turf(holder)); \
	var/obj/machinery/rnd/server/selected_server = length(found_servers) ? found_servers[1] : null; \
	if (selected_server) { \
		server_var = selected_server.stored_research; \
	}; \
	else { \
		var/datum/techweb/station_fallback_web = locate(/datum/techweb/science) in SSresearch.techwebs; \
		server_var = station_fallback_web; \
	}; \
} while (FALSE)
