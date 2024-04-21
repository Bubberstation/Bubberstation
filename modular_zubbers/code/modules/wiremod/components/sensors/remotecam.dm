#define REMOTECAM_RANGE_FAR 7
#define REMOTECAM_RANGE_NEAR 2

/**
 * # Remote Camera Component
 *
 * Attaches a camera for surveillance-on-the-go.
 */
/obj/item/circuit_component/compare/remotecam
	display_name = "Camera Abstract Type"
	desc = "This is the abstract parent type - do not use this directly!"
	circuit_flags = CIRCUIT_NO_DUPLICATES

	energy_usage_per_input = 0.003 * STANDARD_CELL_CHARGE //Normal components have 0.001 * STANDARD_CELL_CHARGE, this is expensive to livestream footage
	var/energy_usage_per_input_far_range = 0.008 * STANDARD_CELL_CHARGE //Far range vision should be expensive, crank this up 8 times

	/// Starts the cameraa
	var/datum/port/input/start
	/// Stops the program.
	var/datum/port/input/stop
	/// Camera range flag (near/far)
	var/datum/port/input/camera_range
	/// The network to use
	var/datum/port/input/network

	/// Allow camera range to be set or not
	var/camera_range_settable = 1

	/// Camera object
	var/obj/machinery/camera/shell_camera = null
	/// Camera random ID
	var/c_tag_random = 0

	/// Used to store the current process state
	var/current_camera_state = FALSE
	/// Used to store the last string used for the camera name
	var/current_camera_name = ""
	/// Used to store the current camera range setting (near/far)
	var/current_camera_range = 0
	/// Used to store the last string used for the camera network
	var/current_camera_network = ""

	/// Used to store location, in order to force camera sector update
	var/updating_camera_loc = FALSE
	var/current_camera_loc
	var/old_camera_loc

/obj/item/circuit_component/compare/remotecam/get_ui_notices()
	. = ..()
	if(camera_range_settable)
		. += create_ui_notice("Energy Usage For Near (0) Range: [display_energy(energy_usage_per_input)] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")
		. += create_ui_notice("Energy Usage For Far (1) Range: [display_energy(energy_usage_per_input_far_range)] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")
	else
		. += create_ui_notice("Energy Usage While Active: [display_energy(current_camera_range > 0 ? energy_usage_per_input_far_range : energy_usage_per_input)] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")

/obj/item/circuit_component/compare/remotecam/populate_ports()
	. = ..()
	compare.name = "Is Active" //Rename compare port

/obj/item/circuit_component/compare/remotecam/populate_custom_ports()
	start = add_input_port("Start", PORT_TYPE_SIGNAL)
	stop = add_input_port("Stop", PORT_TYPE_SIGNAL)
	if(camera_range_settable)
		camera_range = add_input_port("Camera Range", PORT_TYPE_NUMBER, default = 0)
	network = add_input_port("Network", PORT_TYPE_STRING, default = "ss13")

	if(camera_range_settable)
		current_camera_range = camera_range.value
	c_tag_random = rand(1, 999)

/obj/item/circuit_component/compare/remotecam/register_shell(atom/movable/shell)
	stop_process()
	. = ..()

/obj/item/circuit_component/compare/remotecam/unregister_shell(atom/movable/shell)
	stop_process()
	remove_camera()
	. = ..()

/obj/item/circuit_component/compare/remotecam/Destroy()
	stop_process()
	remove_camera()
	current_camera_state = FALSE
	return ..()

/obj/item/circuit_component/compare/remotecam/do_comparisons()
	return shell_camera ? current_camera_state : FALSE

/**
 * Initializes the camera
 */
/obj/item/circuit_component/compare/remotecam/proc/init_camera(shell_name)
	shell_camera.desc = "This camera belongs in a circuit. If you see this, tell a coder!"
	shell_camera.AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)
	current_camera_name = ""
	if(camera_range_settable)
		current_camera_range = camera_range.value
	current_camera_network = ""
	close_camera()
	update_camera_range()
	update_camera_name_network(shell_name)
	updating_camera_loc = FALSE
	current_camera_loc = get_turf(src)
	old_camera_loc = current_camera_loc
	if(current_camera_state)
		start_process()
		update_camera_location()

/**
 * Remove the camera
 */
/obj/item/circuit_component/compare/remotecam/proc/remove_camera()
	if(shell_camera)
		QDEL_NULL(shell_camera)

/**
 * Handle the camera updating logic
 */
/obj/item/circuit_component/compare/remotecam/proc/update_camera(datum/port/input/port, shell_name)
	update_camera_name_network(shell_name)
	if(COMPONENT_TRIGGERED_BY(start, port))
		start_process()
		current_camera_state = TRUE
	else if(COMPONENT_TRIGGERED_BY(stop, port))
		stop_process()
		close_camera() //Instantly turn off the camera
		current_camera_state = FALSE

/**
 * Close the camera state (only if it's already active)
 */
/obj/item/circuit_component/compare/remotecam/proc/close_camera()
	if(shell_camera?.camera_enabled)
		shell_camera.toggle_cam(null, 0)

/**
 * Set the camera range
 */
/obj/item/circuit_component/compare/remotecam/proc/update_camera_range()
	shell_camera.setViewRange(current_camera_range > 0 ? REMOTECAM_RANGE_FAR : REMOTECAM_RANGE_NEAR)

/**
 * Updates the camera name and network
 */
/obj/item/circuit_component/compare/remotecam/proc/update_camera_name_network(shell_name)
	if(!parent || !parent.display_name || parent.display_name == "")
		shell_camera.c_tag = "[shell_name]: unspecified #[c_tag_random]"
		current_camera_name = ""
	else if(current_camera_name != parent.display_name)
		current_camera_name = parent.display_name
		var/new_cam_name = reject_bad_name(current_camera_name, allow_numbers = TRUE, ascii_only = FALSE, strict = TRUE, cap_after_symbols = FALSE)
		//Set camera name using parent circuit name
		if(new_cam_name)
			shell_camera.c_tag = "[shell_name]: [new_cam_name] #[c_tag_random]"
		else
			shell_camera.c_tag = "[shell_name]: unspecified #[c_tag_random]"

	if(!network.value || network.value == "")
		shell_camera.network = list("ss13")
		current_camera_network = ""
	else if(current_camera_network != network.value)
		current_camera_network = network.value
		var/new_net_name = lowertext(sanitize(current_camera_network))
		//Set camera network string
		if(new_net_name)
			shell_camera.network = list("[new_net_name]")
		else
			shell_camera.network = list("ss13")

/obj/item/circuit_component/compare/remotecam/proc/update_camera_location()
	if(updating_camera_loc)
		return
	updating_camera_loc = TRUE
	current_camera_loc = get_turf(src)
	if(old_camera_loc != current_camera_loc)
		GLOB.cameranet.updatePortableCamera(shell_camera, 0.5 SECONDS)
	old_camera_loc = current_camera_loc
	updating_camera_loc = FALSE

/**
 * Adds the component to the SSclock_component process list
 *
 * Starts draining cell per second while camera is active
 */
/obj/item/circuit_component/compare/remotecam/proc/start_process()
	START_PROCESSING(SSclock_component, src)

/**
 * Removes the component to the SSclock_component process list
 *
 * Stops draining cell per second
 */
/obj/item/circuit_component/compare/remotecam/proc/stop_process()
	STOP_PROCESSING(SSclock_component, src)

/obj/item/circuit_component/compare/remotecam/drone
	display_name = "Drone Camera"
	desc = "Capture's surrounding sight for surveillance-on-the-go. Camera range input is either 0 (near) or 1 (far). Network field is used for camera network."
	category = "Sensor"

	required_shells = list(/mob/living/circuit_drone)

	var/mob/living/circuit_drone/drone = null

/obj/item/circuit_component/compare/remotecam/polaroid
	display_name = "Polaroid Camera Add-On"
	desc = "Relays a polaroid camera's feed as a digital stream for surveillance-on-the-go. Network field is used for camera network."
	category = "Sensor"

	required_shells = list(/obj/item/camera)

	camera_range_settable = 0

	current_camera_range = 0

	var/obj/item/circuit_component/camera/polaroid = null

/obj/item/circuit_component/compare/remotecam/bci
	display_name = "Eye Camera"
	desc = "Digitizes user's sight for surveillance-on-the-go. User must have fully functional eyes for digitizer to work. Camera range input is either 0 (near) or 1 (far). Network field is used for camera network."
	category = "BCI"

	required_shells = list(/obj/item/organ/internal/cyberimp/bci)

	var/obj/item/organ/internal/cyberimp/bci/bci = null

/obj/item/circuit_component/compare/remotecam/drone/input_received(datum/port/input/port)
	if(drone && shell_camera)
		update_camera(port, "Drone")
	//Do not update output ports if changed network or camera range
	if(port != network && port != camera_range)
		. = ..()

/obj/item/circuit_component/compare/remotecam/polaroid/input_received(datum/port/input/port)
	if(polaroid && shell_camera)
		update_camera(port, "Polaroid")
	//Do not update output ports if changed network
	if(port != network)
		. = ..()

/obj/item/circuit_component/compare/remotecam/bci/input_received(datum/port/input/port)
	if(bci && shell_camera)
		update_camera(port, "BCI")
	//Do not update output ports if changed network or camera range
	if(port != network && port != camera_range)
		. = ..()

/obj/item/circuit_component/compare/remotecam/drone/Destroy()
	drone = null
	return ..()

/obj/item/circuit_component/compare/remotecam/polaroid/Destroy()
	polaroid = null
	return ..()

/obj/item/circuit_component/compare/remotecam/bci/Destroy()
	bci = null
	return ..()

/obj/item/circuit_component/compare/remotecam/drone/register_shell(atom/movable/shell)
	. = ..()
	drone = null
	shell_camera = null
	if(istype(shell, /mob/living/circuit_drone))
		drone = shell
		shell_camera = new /obj/machinery/camera (drone)
		init_camera("Drone")

/obj/item/circuit_component/compare/remotecam/polaroid/register_shell(atom/movable/shell)
	. = ..()
	polaroid = null
	shell_camera = null
	if(istype(shell, /obj/item/camera))
		polaroid = shell
		shell_camera = new /obj/machinery/camera (polaroid)
		init_camera("Polaroid")

/obj/item/circuit_component/compare/remotecam/bci/register_shell(atom/movable/shell)
	. = ..()
	bci = null
	shell_camera = null
	if(istype(shell, /obj/item/organ/internal/cyberimp/bci))
		bci = shell
		shell_camera = new /obj/machinery/camera (bci)
		init_camera("BCI")

/obj/item/circuit_component/compare/remotecam/drone/unregister_shell(atom/movable/shell)
	drone = null
	. = ..()

/obj/item/circuit_component/compare/remotecam/polaroid/unregister_shell(atom/movable/shell)
	polaroid = null
	. = ..()

/obj/item/circuit_component/compare/remotecam/bci/unregister_shell(atom/movable/shell)
	bci = null
	. = ..()

/obj/item/circuit_component/compare/remotecam/drone/process(seconds_per_tick)
	if(drone && shell_camera)
		//If shell is destroyed
		if(drone.health < 0)
			close_camera()
			return
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		//If cell doesn't exist, or we ran out of power
		if(!cell?.use(current_camera_range > 0 ? energy_usage_per_input_far_range : energy_usage_per_input))
			close_camera()
			return
		//If the camera range has changed, update camera range
		if(!camera_range.value != !current_camera_range)
			current_camera_range = camera_range.value
			update_camera_range()
		//Set the camera state (if state has been changed)
		if(current_camera_state ^ shell_camera.camera_enabled)
			shell_camera.toggle_cam(null, 0)
		if(current_camera_state)
			update_camera_location()

/obj/item/circuit_component/compare/remotecam/polaroid/process(seconds_per_tick)
	if(polaroid && shell_camera)
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		//If cell doesn't exist, or we ran out of power
		if(!cell?.use(energy_usage_per_input))
			close_camera()
			return
		//Set the camera state (if state has been changed)
		if(current_camera_state ^ shell_camera.camera_enabled)
			shell_camera.toggle_cam(null, 0)
		if(current_camera_state)
			update_camera_location()

/obj/item/circuit_component/compare/remotecam/bci/process(seconds_per_tick)
	if(bci && shell_camera)
		//If shell is not currently inside a head, or user is currently blind, or user is dead
		if(!bci.owner || bci.owner.is_blind() || bci.owner.stat >= UNCONSCIOUS)
			close_camera()
			return
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		//If cell doesn't exist, or we ran out of power
		if(!cell?.use(current_camera_range > 0 ? energy_usage_per_input_far_range : energy_usage_per_input))
			close_camera()
			return
		//If owner is nearsighted, set camera range to short (if it wasn't already)
		if(bci.owner.is_nearsighted_currently())
			if(current_camera_range)
				current_camera_range = 0
				update_camera_range()
		//Else if the camera range has changed, update camera range
		else if(!camera_range.value != !current_camera_range)
			current_camera_range = camera_range.value
			update_camera_range()
		//Set the camera state (if state has been changed)
		if(current_camera_state ^ shell_camera.camera_enabled)
			shell_camera.toggle_cam(null, 0)
		if(current_camera_state)
			update_camera_location()

#undef REMOTECAM_RANGE_FAR
#undef REMOTECAM_RANGE_NEAR
