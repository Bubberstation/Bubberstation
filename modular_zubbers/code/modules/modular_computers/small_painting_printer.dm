/obj/item/modular_computer/mini_painting_printer
	name = "instant portrait printer"
	desc = "Allows users to quickly print off desired artworks."
	icon = 'icons/obj/devices/artefacts.dmi'
	icon_state = "prototype9"
	density = FALSE
	starting_programs = list(
		/datum/computer_file/program/portrait_printer/mini
	)
	stored_paper = 10
	max_paper = 10

/obj/item/modular_computer/mini_painting_printer/Initialize(mapload)
	. = ..()
	var/datum/computer_file/program/portrait_printer/mini/printer_prog = find_file_by_name("miniportraitprinter")
	active_program = printer_prog

/datum/computer_file/program/portrait_printer/mini
	filename = "portraitprinter_mini"
	filedesc = "Marlowe Treeby's Art Sharer"
	program_open_overlay = "dummy"
	extended_desc = "Uses bluespace technology to print off a painting."
	can_run_on_flags = PROGRAM_PDA
	program_flags = PROGRAM_REQUIRES_NTNET

/datum/computer_file/program/portrait_printer/mini/print_painting(selected_painting)
	. = ..()
	var/datum/painting/chosen_portrait = locate(selected_painting) in SSpersistent_paintings.paintings
	var/obj/item/wallframe/painting/frame
	if(is_valid_frame(chosen_portrait) == TRUE)
		frame = new /obj/item/wallframe/painting
	else
		if(is_valid_frame_large(chosen_portrait) == TRUE)
			frame = new /obj/item/wallframe/painting/large
		else
			stack_trace("[usr] tried to print a database painting with invalid dimensions using [src]!")

	if(frame != null)
		frame.forceMove(computer.drop_location())

	if(computer.stored_paper < 10)
		QDEL_NULL(computer)

/datum/computer_file/program/portrait_printer/mini/proc/is_valid_frame(datum/painting/painting)
	var/obj/structure/sign/painting/temp_frame = new()

	if(test_canvas_against_list(painting, temp_frame.accepted_canvas_types))
		QDEL_NULL(temp_frame)
		return TRUE
	else
		QDEL_NULL(temp_frame)
		return FALSE

/datum/computer_file/program/portrait_printer/mini/proc/is_valid_frame_large(datum/painting/painting)
	var/obj/structure/sign/painting/large/temp_frame = new()

	if(test_canvas_against_list(painting, temp_frame.accepted_canvas_types))
		QDEL_NULL(temp_frame)
		return TRUE
	else
		QDEL_NULL(temp_frame)
		return FALSE
/datum/computer_file/program/portrait_printer/mini/proc/test_canvas_against_list(datum/painting/painting, list/accepted_canvas_types)
	var/obj/item/canvas/temp_canvas = null
	for(var/canvas_type in accepted_canvas_types)
		temp_canvas = new canvas_type
		if(temp_canvas.width == painting.width && temp_canvas.height == painting.height)
			QDEL_NULL(temp_canvas)
			return TRUE
		QDEL_NULL(temp_canvas)
	return FALSE
