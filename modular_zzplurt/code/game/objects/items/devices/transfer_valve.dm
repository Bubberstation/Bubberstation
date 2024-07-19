/obj/item/transfer_valve/attack_hand(mob/user, list/modifiers)
	. = ..()

	var/client/client = user.client
	if (CONFIG_GET(flag/use_exp_tracking) && client && client.get_exp_living(TRUE) < 8 HOURS) // Player with less than 8 hours playtime has touched a bomb valve.
		if(client.next_valve_grief_warning < world.time)
			var/turf/T = get_turf(src)
			client.next_valve_grief_warning = world.time + 15 MINUTES // Wait 15 minutes before alerting admins again
			message_admins("[span_adminhelp("ANTI-GRIEF:")] New player [ADMIN_LOOKUPFLW(user)] touched \a [src] at [ADMIN_VERBOSEJMP(T)].")
			client.touched_transfer_valve = TRUE

