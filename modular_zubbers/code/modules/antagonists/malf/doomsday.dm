/obj/machinery/doomsday_device/trigger_doomsday()
	for(var/obj/machinery/power/apc/power as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/apc))
		if(is_station_level(power.z))
			explosion(power, light_impact_range = 15, explosion_cause = src, adminlog = TRUE)
			sleep(1)
	to_chat(world, span_bold("You hear a series of explosions!"))
	SSticker.force_ending = FORCE_END_ROUND

/proc/test_doomsday()
	var/obj/machinery/doomsday_device/device = new()
	device.trigger_doomsday()
