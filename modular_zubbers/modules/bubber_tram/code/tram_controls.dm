/obj/machinery/computer/tram_controls/moonstation
	name = "tram controls"
	desc = "An interface for the tram that lets you tell the tram where to go and hopefully it makes it there. I'm here to describe the controls to you, not to inspire confidence."
	icon = 'modular_zubbers/modules/bubber_tram/icons/tram_controls.dmi'
	icon_state = "tram_controls"
	base_icon_state = "tram"
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
