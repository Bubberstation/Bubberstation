/mob/living/circuit_drone
	///Camera installed into the drone
	var/obj/machinery/camera/drone/shell_camera

/mob/living/circuit_drone/Destroy()
	if(shell_camera)
		QDEL_NULL(shell_camera)
	. = ..()
