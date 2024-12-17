//evil copy of get_adjacent_open_turfs
/proc/get_adjacent_occupied_turfs(atom/center)
	var/list/hand_back = list()
	// Inlined get_open_turf_in_dir, just to be fast
	var/turf/open/occupied_turf = get_step(center, NORTH)
	if(!istype(occupied_turf))
		hand_back += occupied_turf
	occupied_turf = get_step(center, SOUTH)
	if(!istype(occupied_turf))
		hand_back += occupied_turf
	occupied_turf = get_step(center, EAST)
	if(!istype(occupied_turf))
		hand_back += occupied_turf
	occupied_turf = get_step(center, WEST)
	if(!istype(occupied_turf))
		hand_back += occupied_turf
	return hand_back
