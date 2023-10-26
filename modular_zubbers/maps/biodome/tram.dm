#define TRAM_BOAT "tram_boat"
#define TRAM_BOAT_FORE "tram_boat_fore"
#define TRAM_BOAT_CENTRAL "tram_boat_central"
#define TRAM_BOAT_AFT "tram_boat_aft"

/obj/effect/landmark/transport/transport_id/boat
	specific_transport_id = TRAM_BOAT


/obj/effect/landmark/transport/nav_beacon/tram/nav/boat/main
	name = TRAM_BOAT
	specific_transport_id = TRAM_NAV_BEACONS
	dir = NORTH

/obj/machinery/computer/tram_controls/boat
	name = "Pleasure Boat Controls"
	icon = 'modular_zubbers/icons/obj/computer.dmi'
	icon_screen = "tram_Aft Boat Dock_idle"
	specific_transport_id = TRAM_BOAT

/obj/effect/landmark/transport/nav_beacon/tram/platform/boat/fore
	name = "Fore Boat Dock"
	specific_transport_id = TRAM_BOAT
	platform_code = TRAM_BOAT_FORE
	tgui_icons = list("Departures" = "plane-departure", "Science" = "flask")

/obj/effect/landmark/transport/nav_beacon/tram/platform/boat/middle
	name = "Central Boat Dock"
	specific_transport_id = TRAM_BOAT
	platform_code = TRAM_BOAT_CENTRAL
	tgui_icons = list("Cargo" = "box")

/obj/effect/landmark/transport/nav_beacon/tram/platform/boat/aft
	name = "Aft Boat Dock"
	specific_transport_id = TRAM_BOAT
	platform_code = TRAM_BOAT_AFT
	tgui_icons = list("Command" = "bullhorn")

/obj/machinery/button/transport/tram/boat/fore
	id = TRAM_BOAT_FORE
	specific_transport_id = TRAM_BOAT

/obj/machinery/button/transport/tram/boat/middle
	id = TRAM_BOAT_CENTRAL
	specific_transport_id = TRAM_BOAT

/obj/machinery/button/transport/tram/boat/aft
	id = TRAM_BOAT_AFT
	specific_transport_id = TRAM_BOAT

#undef TRAM_BOAT
#undef TRAM_BOAT_AFT
#undef TRAM_BOAT_CENTRAL
#undef TRAM_BOAT_FORE
