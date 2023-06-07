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

	for(var/tracked_mob in GLOB.suit_sensors_list)
		var/mob/living/carbon/human/mob = tracked_mob
		if(mob.z != src.z  && !HAS_TRAIT(mob, TRAIT_MULTIZ_SUIT_SENSORS))
			continue
		var/obj/item/clothing/under/uniform = mob.w_uniform
		if(uniform.sensor_mode >= SENSOR_VITALS && HAS_TRAIT(mob, TRAIT_CRITICAL_CONDITION) || mob.stat == DEAD && mob.mind)
			canalarm = TRUE
		else if(uniform.sensor_mode == SENSOR_LIVING && mob.stat == DEAD)
			canalarm = TRUE


	if(canalarm)
		playsound(src, 'sound/machines/twobeep.ogg', 50, TRUE)
		set_light((initial(light_range) + 3), 3, CIRCUIT_COLOR_SECURITY, TRUE)

	else
		set_light((initial(light_range)), initial(light_power), initial(light_color), TRUE)
	addtimer(CALLBACK(src, .proc/alarm), SENSORS_UPDATE_PERIOD) // Fix this for 515

	return canalarm

#undef SENSORS_UPDATE_PERIOD
