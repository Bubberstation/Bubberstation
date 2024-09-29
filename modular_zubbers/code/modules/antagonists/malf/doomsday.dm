/obj/machinery/doomsday_device/trigger_doomsday()
	var/list/bombable = SSmapping.levels_by_trait(ZTRAIT_STATION)
	for(var/obj/machinery/power/apc/power in world)
		if(power.z == locate(power.z) in bombable)
			explosion(power, light_impact_range = 15, explosion_cause = src, adminlog = TRUE)
			sleep(1)
	to_chat(world, span_bold("You hear a series of explosions!"))
	SSticker.force_ending = FORCE_END_ROUND

/proc/test_doomsday()
	var/obj/machinery/doomsday_device/device = new()
	device.trigger_doomsday()
