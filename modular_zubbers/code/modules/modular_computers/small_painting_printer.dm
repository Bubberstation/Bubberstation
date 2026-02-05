/obj/item/modular_computer/mini_painting_printer
	name = "instant portrait printer"
	desc = "Allows users to quickly print off desired artworks."
	icon = 'icons/obj/devices/artefacts.dmi'
	icon_state = "prototype9"
	density = FALSE
	starting_programs = list(
		/datum/computer_file/program/portrait_printer/mini
	)
	internal_cell = /obj/item/stock_parts/power_store/cell/crap
	stored_paper = 10
	max_paper = 10
	max_capacity = 1
	max_idle_programs = 1
	base_active_power_usage = 0.1 WATTS
	base_idle_power_usage = 0.1 WATTS

/obj/item/modular_computer/mini_painting_printer/Initialize(mapload)
	. = ..()
	var/datum/computer_file/program/portrait_printer/mini/printer_prog = find_file_by_name("portraitprinter_mini")
	active_program = printer_prog

/datum/computer_file/program/portrait_printer/mini
	filename = "portraitprinter_mini"
	filedesc = "Marlowe Treeby's Art Sharer"
	size = 1
	program_open_overlay = "dummy"
	extended_desc = "Uses bluespace technology to print off a painting."
	can_run_on_flags = PROGRAM_PDA
	program_flags = PROGRAM_REQUIRES_NTNET
	power_cell_use = 0 WATTS

/datum/computer_file/program/portrait_printer/mini/print_painting(selected_painting)
	. = ..()
	var/datum/painting/chosen_portrait = locate(selected_painting) in SSpersistent_paintings.paintings
	var/obj/item/wallframe/painting/frame
	if(is_valid_frame(chosen_portrait))
		frame = new /obj/item/wallframe/painting
	else
		if(is_valid_frame_large(chosen_portrait))
			frame = new /obj/item/wallframe/painting/large
		else
			stack_trace("[usr] tried to print a database painting with invalid dimensions using [src]!")

	if(!isnull(frame))
		frame.forceMove(computer.drop_location())

	if(computer.stored_paper < 10)
		do_harmless_sparks(number = 4, source = computer)
		QDEL_NULL(computer)

/datum/computer_file/program/portrait_printer/mini/proc/is_valid_frame(datum/painting/painting)
	var/obj/structure/sign/painting/temp_frame = new()
	var/returner = test_canvas_against_list(painting, temp_frame.accepted_canvas_types)
	QDEL_NULL(temp_frame)
	return returner

/datum/computer_file/program/portrait_printer/mini/proc/is_valid_frame_large(datum/painting/painting)
	var/obj/structure/sign/painting/large/temp_frame = new()
	var/returner = test_canvas_against_list(painting, temp_frame.accepted_canvas_types)
	QDEL_NULL(temp_frame)
	return returner

/datum/computer_file/program/portrait_printer/mini/proc/test_canvas_against_list(datum/painting/painting, list/accepted_canvas_types)
	var/obj/item/canvas/temp_canvas = null
	for(var/canvas_type in accepted_canvas_types)
		temp_canvas = new canvas_type
		if(temp_canvas.width == painting.width && temp_canvas.height == painting.height)
			QDEL_NULL(temp_canvas)
			return TRUE
		QDEL_NULL(temp_canvas)
	return FALSE
