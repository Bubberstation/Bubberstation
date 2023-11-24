/obj/machinery/atmospherics/components/binary/circulator/wrench_act_secondary(mob/living/user, obj/item/tool)
	return default_change_direction_wrench(user, tool)

/obj/machinery/atmospherics/components/binary/circulator/default_change_direction_wrench(mob/user, obj/item/I)
	if(!..())
		return FALSE
	set_init_directions()
	update_appearance()
	return TRUE
