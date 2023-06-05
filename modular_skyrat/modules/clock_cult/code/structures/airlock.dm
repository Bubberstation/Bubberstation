/obj/structure/door_assembly/door_assembly_bronze/clock
	airlock_type = /obj/machinery/door/airlock/bronze/clock


/obj/structure/door_assembly/door_assembly_bronze/seethru/clock
	airlock_type = /obj/machinery/door/airlock/bronze/clock/glass


/obj/machinery/door/airlock/bronze/clock
	assemblytype = /obj/structure/door_assembly/door_assembly_bronze/clock
	hackProof = TRUE
	aiControlDisabled = AI_WIRE_DISABLED
	req_access = list(ACCESS_CLOCKCULT)
	damage_deflection = 10


/obj/machinery/door/airlock/bronze/clock/canAIControl(mob/user)
	return (IS_CLOCK(user) && !isAllPowerCut())


/obj/machinery/door/airlock/bronze/clock/on_break()
	set_panel_open(TRUE)


/obj/machinery/door/airlock/bronze/clock/isElectrified()
	return FALSE


/obj/machinery/door/airlock/bronze/clock/hasPower()
	return TRUE


/obj/machinery/door/airlock/bronze/clock/allowed(mob/living/user)
	if(!density || IS_CLOCK(user))
		return TRUE

	else
		user.Paralyze(20)
		user.electrocute_act(25, src, 1, SHOCK_NOGLOVES|SHOCK_SUPPRESS_MESSAGE)
		to_chat(user, span_warning("You feel a sudden jolt as you touch [src]!"))
		return FALSE


/obj/machinery/door/airlock/bronze/clock/emp_act(severity)
	return


/obj/machinery/door/airlock/bronze/clock/glass
	assemblytype = /obj/structure/door_assembly/door_assembly_bronze/seethru/clock
	glass = TRUE
	opacity = FALSE
