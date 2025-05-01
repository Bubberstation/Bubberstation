/obj/item/assembly/control/camkillswitch
	name = "camera network kill switch"
	desc = "A small electronic device that cuts feed for an entire network."
	/// Camera network to kill
	var/camera_network = "dauntless"
	verb_say = "beeps"

/obj/item/assembly/control/camkillswitch/activate()
	if(cooldown)
		say("Camera network is reloading! Please wait a moment.")
		return
	cooldown = TRUE

	var/killswitch = FALSE
	var/list/cameras = GLOB.cameranet.get_available_camera_by_tag_list(camera_network)
	var/obj/machinery/camera/C
	for(var/i in cameras)
		C = cameras[i]
		killswitch = C.camera_enabled
		break
	for(var/i in cameras)
		C = cameras[i]
		if(killswitch == C.camera_enabled)
			C.toggle_cam(null, 0)

	say(killswitch ? "Camera network shutting down." : "Camera network is now online.")
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 5 SECONDS)

/obj/machinery/button/camkillswitch
	name = "camera kill switch"
	device_type = /obj/item/assembly/control/camkillswitch

/datum/design/camkillswitch
	name = "Camera Kill Switch"
	id = "camkillswitch"
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/assembly/control/camkillswitch
