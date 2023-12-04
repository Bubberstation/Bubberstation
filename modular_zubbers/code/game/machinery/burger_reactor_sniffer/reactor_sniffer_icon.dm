/obj/machinery/rbmk2_sniffer/update_icon()

	. = ..()

	if(machine_stat & (NOPOWER|BROKEN))
		icon_state = "reactor_sniffer"
	else
		if(last_meltdown)
			icon_state = "reactor_sniffer_bad"
		else
			icon_state = "reactor_sniffer_good"

/obj/machinery/rbmk2_sniffer/update_overlays()
	. = ..()
	if(panel_open)
		. += "reactor_sniffer_panel"

