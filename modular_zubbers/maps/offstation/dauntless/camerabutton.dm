/obj/item/assembly/control/camkillswitch
	name = "camera network kill switch"
	desc = "A small electronic device that cuts feed for an entire network."
	/// Camera network to kill
	var/camera_network = "dauntless"
	/// Whether the network is enabled or disabled
	var/killswitch = FALSE

/obj/item/assembly/control/camkillswitch/activate()
	if(cooldown)
		return

	cooldown = TRUE
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 5 SECONDS)
	killswitch = !killswitch

	var/list/cameras = get_camera_list(camera_network)
	for(var/i in cameras)
		var/obj/machinery/camera/C = cameras[i]
		if(killswitch == C.camera_enabled)
			C.toggle_cam(null, 0)

	say(killswitch ? "You kill the camera feed." : "You turn on the camera feed.")
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 5 SECONDS)

/obj/machinery/button/camkillswitch
	device_type = /obj/item/assembly/control/camkillswitch

/datum/design/camkillswitch
	name = "Camera Kill Switch"
	id = "camkillswitch"
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/assembly/control/camkillswitch
