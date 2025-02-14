/mob/living/silicon/robot/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	//Is our actuator working?
	if(mobility_flags & MOBILITY_MOVE)
		if(!is_component_functioning("actuator"))
			mobility_flags &= ~MOBILITY_MOVE

	if(robot_resting)
		robot_resting = FALSE
		on_standing_up()
		update_icons()

