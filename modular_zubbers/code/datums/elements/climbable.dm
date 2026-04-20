///Handles sitting on a table for Oversized players
/datum/element/climbable/proc/sit_on_table(atom/table, mob/living/user)
	if(!istype(table, /obj/structure/table))
		return
	var/obj/structure/table/target_table = table

	// Check if table is flipped - can't sit on flipped tables
	if(target_table.is_flipped)
		to_chat(user, span_warning("You can't sit on [target_table] while it's flipped!"))
		return

	// Check if we can reach the table
	if(!can_climb(target_table, user))
		return

	target_table.add_fingerprint(user)

	// Calculate approach direction before moving (for directional seating)
	var/turf/user_turf = get_turf(user)
	var/turf/table_turf = get_turf(target_table)
	var/approach_dir = NORTH // Default fallback

	if(user_turf != table_turf)
		// User is on a different turf, use direction from table to user
		approach_dir = get_dir(table_turf, user_turf)
		// Only allow mounting from cardinal directions, not diagonals
		if(ISDIAGONALDIR(approach_dir))
			to_chat(user, span_warning("You can only sit on [target_table] from the north, south, east, or west side!"))
			return
		// Convert to closest cardinal direction if not already cardinal (safety check)
		if(approach_dir & (approach_dir - 1)) // If diagonal (shouldn't happen after above check, but just in case)
			// Pick the dominant direction based on distance
			if(approach_dir & NORTH && approach_dir & EAST)
				approach_dir = (abs(user_turf.x - table_turf.x) > abs(user_turf.y - table_turf.y)) ? EAST : NORTH
			else if(approach_dir & NORTH && approach_dir & WEST)
				approach_dir = (abs(user_turf.x - table_turf.x) > abs(user_turf.y - table_turf.y)) ? WEST : NORTH
			else if(approach_dir & SOUTH && approach_dir & EAST)
				approach_dir = (abs(user_turf.x - table_turf.x) > abs(user_turf.y - table_turf.y)) ? EAST : SOUTH
			else if(approach_dir & SOUTH && approach_dir & WEST)
				approach_dir = (abs(user_turf.x - table_turf.x) > abs(user_turf.y - table_turf.y)) ? WEST : SOUTH
		else if(!(approach_dir in GLOB.cardinals))
			// Fallback to user's facing direction (must be cardinal)
			approach_dir = user.dir
			if(ISDIAGONALDIR(approach_dir) || !(approach_dir in GLOB.cardinals))
				// If user is facing diagonally or invalid direction, default to NORTH
				approach_dir = NORTH
	else
		// User is already on the table turf, use their facing direction (must be cardinal)
		approach_dir = user.dir
		if(ISDIAGONALDIR(approach_dir) || !(approach_dir in GLOB.cardinals))
			// If user is facing diagonally or invalid direction, default to NORTH
			approach_dir = NORTH

	// Store the approach direction for post_buckle_mob
	LAZYINITLIST(target_table.oversized_sit_directions)
	target_table.oversized_sit_directions[user] = approach_dir

	user.visible_message(span_notice("[user] starts sitting on [target_table]."), \
						span_notice("You start sitting on [target_table]..."))

	// Move to table location if not already there
	if(user.loc != target_table.loc)
		if(!do_after(user, 1 SECONDS, target_table))
			LAZYREMOVE(target_table.oversized_sit_directions, user)
			return
		// Move to the table's turf
		user.forceMove(get_turf(target_table))

	// Enable buckling on the table temporarily (is_buckle_possible will restrict to Oversized)
	var/was_buckle_enabled = target_table.can_buckle
	if(!target_table.can_buckle)
		target_table.can_buckle = TRUE

	// Attempt to buckle (is_buckle_possible override ensures only Oversized can buckle)
	if(target_table.is_buckle_possible(user, FALSE, TRUE))
		if(target_table.buckle_mob(user, FALSE, TRUE))
			user.visible_message(span_notice("[user] sits on [target_table]."), \
							span_notice("You sit on [target_table]."))
		else
			to_chat(user, span_warning("You fail to sit on [target_table]."))
			// Restore original buckle state if we changed it
			if(!was_buckle_enabled)
				target_table.can_buckle = FALSE
	else
		to_chat(user, span_warning("You can't sit on [target_table] right now."))
		// Restore original buckle state if we changed it
		if(!was_buckle_enabled)
			target_table.can_buckle = FALSE
