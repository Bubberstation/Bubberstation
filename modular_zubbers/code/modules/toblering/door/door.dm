/obj/machinery/door
	/// What door types do we want to align with if any
	var/door_align_type
	var/align_to_windows
	var/auto_dir_align = TRUE

/obj/machinery/door/Initialize(mapload)
	. = ..()
	// Get rid of the color used to help mappers
	color = null
	// Automatically align the direction of the airlock
	auto_dir_align()

/obj/machinery/door/proc/auto_dir_align()
	if(!auto_dir_align)
		return
	// Set directional facing
	var/turf/my_turf = get_turf(src)
	var/turf/north_turf = get_step(my_turf, NORTH)
	var/turf/south_turf = get_step(my_turf, SOUTH)
	//If south or north is blocked, face towards west
	var/block_dir = SOUTH
	var/align_dir
	for(var/i in 1 to 2)
		var/turf/check_turf = i == 1 ? north_turf : south_turf
		if(!check_turf)
			continue
		if(!check_turf.density)
			//Adjacent turf is not dense, check if we can maybe align with a window or a low wall
			if(align_to_windows)
				var/obj/structure/window/window = locate() in check_turf
				if(!window || !window.fulltile)
					continue
			else
				continue
		block_dir = WEST
		break

	if(door_align_type)
		var/turf/west_turf = get_step(my_turf, WEST)
		var/turf/east_turf = get_step(my_turf, EAST)
		for(var/i in 1 to 4)
			var/dir_to_align
			var/turf/check_turf
			switch(i)
				if(1)
					check_turf = north_turf
					dir_to_align = WEST
				if(2)
					check_turf = south_turf
					dir_to_align = WEST
				if(3)
					check_turf = east_turf
					dir_to_align = SOUTH
				if(4)
					check_turf = west_turf
					dir_to_align = SOUTH
			if(!check_turf)
				continue
			var/obj/machinery/door/found_door = locate(door_align_type) in check_turf
			if(found_door)
				align_dir = dir_to_align
				break

	if(align_dir)
		setDir(align_dir)
	else
		setDir(block_dir)
	// To prevent invalid dirs slipping through
	if(dir != SOUTH && dir != WEST)
		dir = SOUTH
