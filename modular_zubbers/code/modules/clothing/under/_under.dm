/obj/item/clothing/under/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	if(has_sensor == NO_SENSORS || has_sensor == BROKEN_SENSORS)
		return

	if(severity <= EMP_HEAVY)
		break_sensors()

	else
		sensor_mode = clamp(sensor_mode + pick(-1,1), SENSOR_OFF, SENSOR_COORDS)
		if(ismob(loc))
			var/mob/wearing_mob = loc
			to_chat(wearing_mob, span_warning("The sensors on the [src] change rapidly!"))

	update_wearer_status()
