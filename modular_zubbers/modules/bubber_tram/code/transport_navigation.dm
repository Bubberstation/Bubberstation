//Moon Station

/obj/effect/landmark/transport/transport_id/moonstation/line_1
	specific_transport_id = MOONSTATION_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/moonstation/main
	name = MOONSTATION_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS
	dir = WEST

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/terminal
	name = "Terminal"
	specific_transport_id = MOONSTATION_LINE_1
	platform_code = MOONSTATION_TERMINAL
	tgui_icons = list("Terminal" = "plane-arrival")

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/station
	name = "Station"
	specific_transport_id = MOONSTATION_LINE_1
	platform_code = MOONSTATION_MAIN_STATION
	tgui_icons = list("Station" = "arrow-right-to-city")
