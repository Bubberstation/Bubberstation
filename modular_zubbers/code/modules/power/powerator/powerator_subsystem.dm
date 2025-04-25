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

/datum/controller/subsystem/powerator_penality/proc/add_powerator(obj/machinery/powerator/powerator)
	if(!powerator)
		return
	LAZYADD(powerator_list[powerator.powerator_faction], powerator)
	calculate_penalty()

/datum/controller/subsystem/powerator_penality/proc/remove_powerator(obj/machinery/powerator/powerator)
	if(!powerator)
		return
	LAZYREMOVE(powerator_list[powerator.powerator_faction], powerator)
	calculate_penalty()

/datum/controller/subsystem/powerator_penality/proc/calculate_penalty()
	for(var/faction in powerator_list)
		if(length(powerator_list[faction] > 0))
			diminishing_gains_multiplier_list[faction] = min(1, 2 ** log(4, length(powerator_list[faction])) / length(powerator_list[faction]))
		else
			diminishing_gains_multiplier_list[faction] = 1
