/obj/effect/landmark/transport/transport_id/moonstation/line_1
	specific_transport_id = MOONSTATION_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/moonstation/main
	name = MOONSTATION_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS
	dir = WEST

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/terminal
	name = "Arrivals Terminal"
	specific_transport_id = MOONSTATION_LINE_1
	platform_code = MOONSTATION_TERMINAL
	tgui_icons = list("Arrivals Terminal" = "plane-arrival", "Cryogenic Sleepers" = "bed-pulse")

/obj/effect/landmark/transport/nav_beacon/tram/platform/moonstation/station
	name = "Main Station"
	specific_transport_id = MOONSTATION_LINE_1
	platform_code = MOONSTATION_MAIN_STATION
	tgui_icons = list("Main Station" = "arrow-right-to-city", "Departures/Evac" = "plane-departure")

/obj/machinery/transport/tram_controller/moonstation
	name = "moon rover controller"
	desc = "Unlike the iconic moon rover of yesteryears, our tram is here to remind you that even in space, mediocrity finds a way."
	configured_transport_id = MOONSTATION_LINE_1
	obj_flags = parent_type::obj_flags | NO_DEBRIS_AFTER_DECONSTRUCTION

/obj/machinery/transport/destination_sign/moonstation
	icon = 'modular_zubbers/icons/obj/machines/tram_display.dmi'
	configured_transport_id = MOONSTATION_LINE_1

/obj/machinery/transport/destination_sign/indicator/moonstation
	icon = 'modular_zubbers/icons/obj/machines/tram_indicator.dmi'
	configured_transport_id = MOONSTATION_LINE_1

/obj/machinery/transport/destination_sign/Initialize(mapload)
	. = ..()
	LAZYADD(available_faces, MOONSTATION_LINE_1)

/obj/machinery/computer/tram_controls/moonstation
	name = "moon rover controls"
	desc = "Unlike the iconic moon rover of yesteryears, our tram is here to remind you that even in space, mediocrity finds a way."
	icon = 'modular_zubbers/icons/obj/machines/tram_controls.dmi'
	icon_screen = MOONSTATION_LINE_1
	specific_transport_id = MOONSTATION_LINE_1

/obj/machinery/computer/tram_controls/moonstation/directional/north
	dir = SOUTH
	pixel_x = -16
	pixel_y = 32

/obj/machinery/computer/tram_controls/moonstation/directional/south
	dir = NORTH
	pixel_x = 16
	pixel_y = -32

/obj/machinery/door/airlock/tram/moonstation
	name = "moon rover door"
	transport_linked_id = MOONSTATION_LINE_1
