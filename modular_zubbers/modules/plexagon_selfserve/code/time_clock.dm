/obj/machinery/modular_computer/preset/time_clock
	name = "time clock"
	desc = "Allows employees to clock in and out of their jobs"
	icon = 'modular_zubbers/icons/obj/machines/time_clock.dmi'
	density = FALSE
	starting_programs = list(
		/datum/computer_file/program/crew_self_serve,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/modular_computer/preset/time_clock, 28)

/obj/machinery/modular_computer/preset/time_clock/Initialize(mapload)
	. = ..()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(setup_starting_software)))

/obj/machinery/modular_computer/preset/time_clock/proc/setup_starting_software()
	var/datum/computer_file/program/crew_self_serve/punch_clock = cpu.find_file_by_name("plexagonselfserve")
	cpu.active_program = punch_clock
	punch_clock.register_signals()
