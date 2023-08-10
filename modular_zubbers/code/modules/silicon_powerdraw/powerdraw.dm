/mob/living/silicon/proc/get_power(demand, uses, distance, atom)
	var/mob/living/silicon/robot/robot
	var/obj/item/stock_parts/cell/cell
	var/area/siliconarea
	if(iscyborg(src)) // if we're a cyborg, we have a cell.
		robot = src
		cell = robot.cell
	if(isAI(src))
		return TRUE
	var/true_cost = demand * (distance > 2 ? distance : 0)
	if(cell && cell.use(true_cost)) // More distance means more draw - point blank is free.
		balloon_alert(robot, true_cost ? "used [true_cost] charge" : "no charge used")
		Beam(BeamTarget = atom, time = 1 SECONDS)
		. = TRUE
	else // Use the area power, if we need to.
		siliconarea = get_area(src)
		var/obj/machinery/power/apc/theAPC
		for(var/obj/machinery/power/apc/APC in siliconarea)
			if(!(APC.machine_stat & BROKEN))
				theAPC = APC
		//Don't go lower than 4000 units on an APC. Also, no distance multi because the room is doing it now.
		if((theAPC.cell.charge) <= 4000 && theAPC.directly_use_power(demand))
			Beam(BeamTarget = theAPC, time = 1 SECONDS)
			Beam(BeamTarget = atom, time = 1 SECONDS) // beam me up, scotty!
			. = TRUE
		else
			to_chat(src, "Not enough APC power for this action!")

	return .
