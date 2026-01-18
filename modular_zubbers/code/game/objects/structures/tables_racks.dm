
/*
 * Wooden Cabinet Table
 * This is a stand-alone table that doesn't smooth
 * Conveniently, a cabinet exists that can go right on top!
 * Check out gimmick.dm in the closets section!
 */

/obj/structure/table/wood/cabinet
	icon = 'modular_zubbers/icons/obj/storage/closet.dmi'
	icon_state = "wood_table"
	base_icon_state = "wood_table"

	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
/// Only allow Oversized players to buckle to regular tables (operating tables work normally)
/obj/structure/table/is_buckle_possible(mob/living/target, force = FALSE, check_loc = TRUE)
	// Operating tables should work normally for everyone
	if(istype(src, /obj/structure/table/optable))
		return ..()
	// Regular tables only allow Oversized players to buckle
	if(!force && !HAS_TRAIT(target, TRAIT_OVERSIZED))
		return FALSE
	return ..()

/// Stores the approach direction for Oversized players sitting on tables
/obj/structure/table/var/list/oversized_sit_directions = null

/// Position Oversized players at the edge of the table they approached from
/obj/structure/table/post_buckle_mob(mob/living/buckled)
	. = ..()
	// Only apply directional seating for Oversized players on regular tables
	if(istype(src, /obj/structure/table/optable))
		return
	if(!HAS_TRAIT(buckled, TRAIT_OVERSIZED))
		return

	// Get the approach direction
	var/approach_dir = LAZYACCESS(oversized_sit_directions, buckled)
	if(!approach_dir)
		// Fallback: calculate from adjacent turfs
		var/turf/table_turf = get_turf(src)
		var/closest_dir = NORTH
		var/closest_dist = INFINITY
		for(var/dir in GLOB.cardinals)
			var/turf/check_turf = get_step(table_turf, dir)
			if(check_turf && buckled.loc == table_turf)
				// Check if there's a path or if this is the closest
				var/dist = get_dist(check_turf, buckled)
				if(dist < closest_dist)
					closest_dist = dist
					closest_dir = dir
		approach_dir = closest_dir

	// Apply pixel offsets based on approach direction
	// Position them at the edge they approached from (16 pixels = half tile width)
	var/x_offset = 0
	var/y_offset = 0
	switch(approach_dir)
		if(NORTH)
			y_offset = 16 // Position at north edge
		if(SOUTH)
			y_offset = -16 // Position at south edge
		if(EAST)
			x_offset = 16 // Position at east edge
		if(WEST)
			x_offset = -16 // Position at west edge

	if(x_offset || y_offset)
		buckled.add_offsets(type, x_add = x_offset, y_add = y_offset)
		// Face away from the table edge (toward the direction they came from)
		buckled.setDir(approach_dir)

/// Clean up stored directions and place Oversized players adjacent to the table when unbuckling
/obj/structure/table/post_unbuckle_mob(mob/living/unbuckled)
	. = ..()
	// Only handle Oversized players on regular tables
	if(istype(src, /obj/structure/table/optable))
		return
	if(!HAS_TRAIT(unbuckled, TRAIT_OVERSIZED))
		return

	// Remove offsets
	unbuckled.remove_offsets(type)

	// Find the nearest unblocked, maneuverable location adjacent to the table
	var/turf/table_turf = get_turf(src)
	var/turf/destination_turf = null

	// Try to use the approach direction first, otherwise try all cardinal directions
	var/approach_dir = LAZYACCESS(oversized_sit_directions, unbuckled)
	var/list/dirs_to_try = list()
	if(approach_dir && (approach_dir in GLOB.cardinals))
		dirs_to_try += approach_dir
	// Add remaining cardinal directions
	for(var/dir in GLOB.cardinals)
		if(dir != approach_dir)
			dirs_to_try += dir

	// Find the first unblocked, maneuverable turf
	for(var/dir in dirs_to_try)
		var/turf/test_turf = get_step(table_turf, dir)
		if(test_turf && !test_turf.is_blocked_turf(exclude_mobs = FALSE, source_atom = unbuckled))
			destination_turf = test_turf
			break

	// If no adjacent turf is available, try the table's own turf as last resort
	if(!destination_turf)
		if(!table_turf.is_blocked_turf(exclude_mobs = TRUE, source_atom = unbuckled))
			destination_turf = table_turf

	if(destination_turf)
		unbuckled.forceMove(destination_turf)

	// Clean up stored data
	if(oversized_sit_directions)
		LAZYREMOVE(oversized_sit_directions, unbuckled)
		if(!length(oversized_sit_directions))
			oversized_sit_directions = null
