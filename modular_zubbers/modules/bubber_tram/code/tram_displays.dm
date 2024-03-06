/obj/machinery/transport/destination_sign/moonstation
	icon = 'modular_zubbers/modules/bubber_tram/icons/tram_display.dmi'
	configured_transport_id = MOONSTATION_LINE_1

/obj/machinery/transport/destination_sign/indicator/moonstation
	icon = 'modular_zubbers/modules/bubber_tram/icons/tram_indicator.dmi'
	configured_transport_id = MOONSTATION_LINE_1

/obj/machinery/transport/destination_sign/Initialize(mapload)
	. = ..()
	LAZYADD(available_faces, MOONSTATION_LINE_1)
