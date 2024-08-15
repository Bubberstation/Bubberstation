/obj/machinery/chem_dispenser/ui_interact(mob/user, datum/tgui/ui)
	. = ..()

	var/client/client = user.client
	if (CONFIG_GET(flag/use_exp_tracking) && client && client.get_exp_living(TRUE) < 8 HOURS) // Player with less than 8 hours playtime is using this machine.
		if(client.next_chem_grief_warning < world.time)
			if(!istype(src, /obj/machinery/chem_dispenser/drinks) && !istype(src, /obj/machinery/chem_dispenser/mutagen) && !istype(src, /obj/machinery/chem_dispenser/mutagensaltpeter) && !istype(src, /obj/machinery/chem_dispenser/abductor)) // These types aren't used for grief
				var/turf/T = get_turf(src)
				client.next_chem_grief_warning = world.time + 15 MINUTES // Wait 15 minutes before alerting admins again
				message_admins("[span_adminhelp("ANTI-GRIEF:")] New player [ADMIN_LOOKUPFLW(user)] used \a [src] at [ADMIN_VERBOSEJMP(T)].")
				client.used_chem_dispenser = TRUE
