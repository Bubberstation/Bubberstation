/obj/machinery/portable_atmospherics/canister/ui_interact(mob/user, datum/tgui/ui)
	. = ..()

	var/client/client = user.client
	if (CONFIG_GET(flag/use_exp_tracking) && client && client.get_exp_living(TRUE) < 8 HOURS) // Player with less than 8 hours playtime is interacting with this canister.
		if(client.next_canister_grief_warning < world.time)
			var/turf/T = get_turf(src)
			client.next_canister_grief_warning = world.time + 15 MINUTES // Wait 15 minutes before alerting admins again
			message_admins("[span_adminhelp("ANTI-GRIEF:")] New player [ADMIN_LOOKUPFLW(user)] has touched \a [src] at [ADMIN_VERBOSEJMP(T)].")
			client.touched_canister = TRUE

/obj/machinery/portable_atmospherics/canister/goblin
	name = "G-081-N canister"
	gas_type = /datum/gas/goblin
	greyscale_config = /datum/greyscale_config/canister/hazard
	greyscale_colors = "#267f00#ff7fb6"
