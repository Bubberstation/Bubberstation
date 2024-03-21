///The internal camera object for BCIs, applied by the camera component
/obj/machinery/camera/bci
	c_tag = "BCI: unspecified"
	desc = "This camera belongs in a BCI. If you see this, tell a coder!"
	network = list("ss13", "rd")
	///Currently used name of the camera
	var/current_name = null

///The internal camera object for drones, applied by the camera component
/obj/machinery/camera/drone
	c_tag = "Drone: unspecified"
	desc = "This camera belongs in a drone. If you see this, tell a coder!"
	network = list("ss13", "rd")
	///Currently used name of the camera
	var/current_name = null
