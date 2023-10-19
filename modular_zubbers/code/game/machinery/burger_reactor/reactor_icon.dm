/obj/machinery/power/rbmk2/update_icon_state()

	if(stored_rod)
		if(active)
			if(jammed)
				icon_state = "[base_icon_state]_jammed"
			else if(meltdown)
				var/meltdown_icon_number = 1 + (x + y*2) % 5
				icon_state = "[base_icon_state]_meltdown_loop[meltdown_icon_number]"
			else
				icon_state = "[base_icon_state]_closed"
		else
			icon_state = "[base_icon_state]_open"
	else
		icon_state = base_icon_state

	return ..()

/obj/machinery/power/rbmk2/update_overlays()
	. = ..()
	if(panel_open) . += "platform_panel"
	. += heat_overlay
	. += meter_overlay