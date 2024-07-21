#define SENSORS_UPDATE_PERIOD 15 SECONDS //Why is this not a global define, why do I have to define it again


/obj/machinery/computer/crew
	luminosity = 1
	light_power = 3
	var/canalarm = FALSE


/obj/machinery/computer/crew/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	alarm()

/obj/machinery/computer/crew/proc/alarm()
	canalarm = FALSE

	for(var/mob/living/carbon/human/mob in GLOB.suit_sensors_list)

		if(!istype(mob))
			continue
		if(mob.z != src.z  && !HAS_TRAIT(mob, TRAIT_MULTIZ_SUIT_SENSORS))
			continue
		var/obj/item/clothing/under/uniform = mob.w_uniform
		if(uniform.sensor_mode == SENSOR_COORDS && (uniform.has_sensor != BROKEN_SENSORS) && (HAS_TRAIT(mob, TRAIT_CRITICAL_CONDITION) || mob.stat == DEAD))
			if(mob.get_dnr()) // DNR won't beep anymore
				continue
			canalarm = TRUE
			break // Why wasn't this here?

	if(canalarm)
		playsound(src, 'sound/machines/twobeep.ogg', 50, TRUE)
		set_light((initial(light_range) + 3), 3, CIRCUIT_COLOR_SECURITY, TRUE)
		spasm_animation(10)
	else
		set_light((initial(light_range)), initial(light_power), initial(light_color), TRUE)
	addtimer(CALLBACK(src, .proc/alarm), SENSORS_UPDATE_PERIOD) // Fix this for 515

	return canalarm

#undef SENSORS_UPDATE_PERIOD
