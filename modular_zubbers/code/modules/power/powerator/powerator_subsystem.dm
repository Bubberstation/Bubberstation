SUBSYSTEM_DEF(powerator_penality)
	name = "Powerator Penalities"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_POWERATOR_PENALITY

	/// Assoc list of powerator faction -> list of powerators belonging to that faction
	var/list/powerator_list = list()
	/// Assoc list of powerator faction -> diminishing gains multiplier for that faction's powerators
	var/list/diminishing_gains_multiplier_list = list()

/datum/controller/subsystem/powerator_penality/Initialize()
	return SS_INIT_SUCCESS


/datum/controller/subsystem/powerator_penality/proc/sum_powerators()
	for(var/obj/machinery/powerator/poweratorc as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/powerator))
		powerator_list |= poweratorc

/datum/controller/subsystem/powerator_penality/proc/remove_deled_powerators(src)
	powerator_list -= src
	return

/datum/controller/subsystem/powerator_penality/proc/calculate_penality()
	if(length(powerator_list) > 0)
		diminishing_gains_multiplier = min(1, 2 ** log(4, length(powerator_list)) / length(powerator_list))
		return diminishing_gains_multiplier
	else
		diminishing_gains_multiplier = initial(diminishing_gains_multiplier)
