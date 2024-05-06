/mob/living/carbon/human/update_sensor_list()
	var/obj/item/clothing/under/U = w_uniform
	if(istype(U) && U.has_sensor != NO_SENSORS && U.sensor_mode)
		GLOB.suit_sensors_list |= src
	else
		GLOB.suit_sensors_list -= src

/obj/item/clothing/under/emp_act(severity)

	. = ..()

	if(. & EMP_PROTECT_SELF)
		return

	if(has_sensor == NO_SENSORS || has_sensor == BROKEN_SENSORS)
		return

	if(severity <= EMP_HEAVY) //Believe it or not, EMP_HEAVY < EMP_LIGHT
		has_sensor = BROKEN_SENSORS
		sensor_mode = SENSOR_LIVING
		if(ismob(loc))
			var/mob/M = loc
			to_chat(M,span_danger("The sensors on [src] short out!"))
	else
		sensor_mode = clamp(sensor_mode + pick(-1,1), SENSOR_OFF, SENSOR_COORDS)
		if(ismob(loc))
			var/mob/M = loc
			to_chat(M,span_warning("The sensors on [src] change rapidly!"))

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.w_uniform == src)
			H.update_suit_sensors()