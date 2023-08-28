/obj/machinery/airalarm/proc/activate_firedoors(activation_type = FIRELOCK_ALARM_TYPE_GENERIC)
	for(var/obj/machinery/door/firedoor/firelock as anything in my_area.firedoors)
		firelock.activate(activation_type)