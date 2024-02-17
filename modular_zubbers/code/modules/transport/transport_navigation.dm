//Moon Station

/obj/effect/landmark/transport/transport_id/moonstation/line_1
	specific_transport_id = TRAMSTATION_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/moonstation/main
	name = TRAMSTATION_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS
	dir = WEST

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/terminal
	name = "Terminal"
	platform_code = TRAMSTATION_WEST
	tgui_icons = list("Terminal" = "plane-arrival")

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/station
	name = "Station"
	platform_code = TRAMSTATION_EAST
	tgui_icons = list("Station" = "plane-departure")
