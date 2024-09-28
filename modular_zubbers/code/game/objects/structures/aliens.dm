/obj/structure/alien/weeds/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature >= 350 //Slightly less than moonstation external atmos.
