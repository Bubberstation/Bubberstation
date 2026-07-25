/obj/item/assembly/control/camkillswitch
	name = "camera network kill switch"
	desc = "A small electronic device that cuts feed for an entire network."
	verb_say = "beeps"
	COOLDOWN_DECLARE(use_cooldown)
	/// Camera network to kill
	var/camera_network = "dauntless"
	/// Current state the cameras are in, toggled after activating the button
	var/cameras_active = TRUE

/obj/item/assembly/control/camkillswitch/activate()
	if(!COOLDOWN_FINISHED(src, use_cooldown))
		say("Camera network is reloading! Please wait a moment.")
		return

	var/list/cameras = SScameras.get_available_camera_by_tag_list(camera_network)
	var/obj/machinery/camera/camera
	for(var/camera_name in cameras)
		camera = cameras[camera_name]
		if(camera.camera_enabled == cameras_active)
			camera.toggle_cam(null, FALSE)

	cameras_active = !cameras_active
	say(cameras_active ? "Camera network is now online." : "Camera network shutting down.")
	COOLDOWN_START(src, use_cooldown, 5 SECONDS)

/obj/machinery/button/camkillswitch
	name = "camera kill switch"
	device_type = /obj/item/assembly/control/camkillswitch
