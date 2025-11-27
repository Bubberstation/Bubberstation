/obj/machinery/power/rbmk2/proc/check_adjacent_rbmk(do_loop=TRUE)

	adjacent_rbmk_machines = 0

	for(var/obj/machinery/power/rbmk2/other_machine in orange(1,src))
		if(QDELING(other_machine))
			continue
		if(do_loop)
			other_machine.check_adjacent_rbmk(FALSE)
		adjacent_rbmk_machines++

	return TRUE
