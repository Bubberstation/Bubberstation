/obj/machinery/button/showtime/broadcast_team
	name = "broadcast button"
	desc = "Use this button to allow entertainment monitors to broadcast the show, live on air."
	device_type = /obj/item/assembly/control/showtime/broadcast_team
	id = "showtime_bt"

/obj/machinery/button/showtime/broadcast_team/multitool_act(mob/living/user, obj/item/multitool/I)
	if(panel_open)
		. = ..()
	else
		if(src.device == /obj/item/assembly/control/showtime/broadcast_team)
			var/obj/item/assembly/control/showtime/broadcast_team/our_assembly = src.device
			our_assembly.show_rename(user, I)
		return TRUE

/obj/item/assembly/control/showtime/broadcast_team
	tv_network_id = "broadcast"
	tv_show_name = "Broadcast Team's Homebrew Extravaganza"
	tv_starters = list( \
		"Returning live from your station!", \
		)
	tv_enders = list( \
		"We'll be back after the break!", \
		)

/obj/item/assembly/control/showtime/broadcast_team/proc/show_rename(mob/living/user, obj/item/multitool/I)
	tv_show_name = tgui_input_text(usr, "Enter the new show name...", "Show Name", tv_show_name, MAX_PLAQUE_LEN)
	tv_starters = list( \
	"Live Now: [tv_show_name]!", \
	)
	return TRUE

/obj/machinery/computer/security/telescreen/broadcast_team
	name = "\improper Broadcast Teams' telescreen"
	desc = "A telescreen used to preview a show's cameras prior to air."
	network = list("broadcast")
	frame_type = /obj/item/wallframe/telescreen/broadcast_team

/obj/item/wallframe/telescreen/broadcast_team
	name = "\improper Broadcast Teams' telescreen frame"
	result_path = /obj/machinery/computer/security/telescreen/broadcast_team
