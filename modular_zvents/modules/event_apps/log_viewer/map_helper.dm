/obj/effect/mapping_helpers/add_modular_log
	name = "Add log report"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "log_helper"
	late = TRUE

	var/log_timestamp = ""
	var/log_author = ""
	var/log_message = ""
	var/corrupted = FALSE

/obj/effect/mapping_helpers/add_modular_log/Initialize(mapload)
	. = ..()
	if(!mapload)
		return
	addtimer(CALLBACK(src, PROC_REF(apply_log)), 0)

/obj/effect/mapping_helpers/add_modular_log/proc/apply_log()
	var/obj/machinery/modular_computer/mod_device = locate() in loc
	if(!mod_device || !mod_device.cpu)
		stack_trace("add_modular_log failed to find modular computer in tile ([x],[y],[z])")
		return

	var/datum/computer_file/data/log_entry/new_entry = new()
	new_entry.log_timestamp = log_timestamp || station_time_timestamp()
	new_entry.log_author = log_author || "Unknown"
	new_entry.log_message = log_message || "No message"
	new_entry.corrupted = corrupted
	new_entry.filename = "[log_author]_[log_timestamp]_[rand(1-33)]"

	if(!mod_device.cpu.store_file(new_entry))
		stack_trace("Failed to store log entry: [log_message]")

	qdel(src)


/obj/machinery/modular_computer/preset/log_computer
	name = "console"
	desc = "A stationary computer."
	starting_programs = list(
		/datum/computer_file/program/log_viewer,
		/datum/computer_file/program/trigger_control,
	)

/obj/machinery/modular_computer/preset/log_computer/post_machine_initialize()
	. = ..()
	cpu.device_theme = PDA_THEME_RETRO
	cpu.remove_file(/datum/computer_file/program/themeify)
	cpu.remove_file(/datum/computer_file/program/messenger)
	cpu.remove_file(/datum/computer_file/program/ntnetdownload)



