/obj/machinery/airalarm/
	var/heating_power = 5000
	var/efficiency = 10000
	desc = "A machine that monitors atmosphere levels. Goes off if the area is dangerous, and activates firelocks. Contains a mini-heater for heating small rooms in cases of extreme cold."

/obj/machinery/airalarm/proc/activate_firedoors(activation_type = FIRELOCK_ALARM_TYPE_GENERIC)
	for(var/obj/machinery/door/firedoor/firelock as anything in my_area.firedoors)
		firelock.activate(activation_type)

/obj/machinery/airalarm/proc/heat_environment(datum/gas_mixture/environment)

	if(heating_power <= 0)
		return FALSE

	var/target_temperature = BODYTEMP_COLD_WARNING_1+10 //Based off the warning in the main file.

	var/heat_capacity = environment.heat_capacity()
	var/required_energy = abs(environment.temperature - target_temperature) * heat_capacity
	required_energy = min(required_energy, heating_power)

	var/delta_temperature = required_energy / heat_capacity

	if(delta_temperature > 0)
		environment.temperature += delta_temperature
		air_update_turf(FALSE, FALSE)
		use_power(required_energy / efficiency)
