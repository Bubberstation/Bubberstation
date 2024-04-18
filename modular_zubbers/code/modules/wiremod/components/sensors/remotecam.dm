#define REMOTECAM_RANGE_FAR 7
#define REMOTECAM_RANGE_NEAR 2

/**
 * # BCI/Drone Camera Component
 *
 * Attaches a camera for surveillance-on-the-go.
 * Only works on movable shells/BCI shell.
 *
 */

/obj/item/circuit_component/remotecam
	display_name = "Camera Abstract Type"
	desc = "This is the abstract parent type - do not use this directly!"
	circuit_flags = CIRCUIT_NO_DUPLICATES

	power_usage_per_input = 3 //Normal components have 1, this is expensive to livestream footage
	var/power_usage_per_input_far_range = 8 //Far range vision should be expensive, crank this up to 8

	/// Whether the camera is on or not
	var/datum/port/input/on
	/// Camera range flag (near/far)
	var/datum/port/input/camera_range
	/// The network to use
	var/datum/port/input/network

	/// Camera object
	var/obj/machinery/camera/shell_camera = null
	/// Camera random ID
	var/c_tag_random = 0

	/// Used to store the last string used for the camera name
	var/current_camera_name = ""
	/// Used to store the current camera range setting (near/far)
	var/current_camera_range = 0
	/// Used to store the last string used for the camera network
	var/current_camera_network = ""

/obj/item/circuit_component/remotecam/get_ui_notices()
	. = ..()
	. += create_ui_notice("Power Usage For Near (0) Range: [power_usage_per_input] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")
	. += create_ui_notice("Power Usage For Far (1) Range: [power_usage_per_input_far_range] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")

/obj/item/circuit_component/remotecam/populate_ports()
	on = add_input_port("On", PORT_TYPE_NUMBER, default = 0)
	camera_range = add_input_port("Camera Range", PORT_TYPE_NUMBER, default = 0)
	network = add_input_port("Network", PORT_TYPE_STRING, default = "ss13")

	current_camera_range = camera_range.value
	c_tag_random = rand(1, 999)

/obj/item/circuit_component/remotecam/register_shell(atom/movable/shell)
	stop_process()
	. = ..()

/obj/item/circuit_component/remotecam/unregister_shell(atom/movable/shell)
	stop_process()
	remove_camera()
	. = ..()

/obj/item/circuit_component/remotecam/Destroy()
	stop_process()
	remove_camera()
	return ..()

/**
 * Initializes the camera
 */
/obj/item/circuit_component/remotecam/proc/init_camera(shell_name)
	shell_camera.desc = "This camera belongs in a circuit. If you see this, tell a coder!"
	current_camera_name = ""
	current_camera_range = camera_range.value
	current_camera_network = ""
	close_camera()
	set_camera_range(current_camera_range)
	update_camera_name_network(shell_name)

/**
 * Remove the camera
 */
/obj/item/circuit_component/remotecam/proc/remove_camera()
	if(shell_camera)
		QDEL_NULL(shell_camera)
		shell_camera = null

/**
 * Handle the camera updating logic
 */
/obj/item/circuit_component/remotecam/proc/update_camera(shell_name)
	if(!on.value)
		stop_process()
		close_camera() //Instantly turn off the camera
	else if(on.value)
		update_camera_name_network(shell_name)
		start_process()

/**
 * Close the camera state (only if it's already active)
 */
/obj/item/circuit_component/remotecam/proc/close_camera()
	if(shell_camera?.status)
		shell_camera.toggle_cam(null, 0)

/**
 * Set the camera range
 */
/obj/item/circuit_component/remotecam/proc/set_camera_range(camera_range)
	shell_camera.setViewRange(camera_range > 0 ? REMOTECAM_RANGE_FAR : REMOTECAM_RANGE_NEAR)

/**
 * Updates the camera name and network
 */
/obj/item/circuit_component/remotecam/proc/update_camera_name_network(shell_name)
	if(!parent.display_name || parent.display_name == "")
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

/**
 * Adds the component to the SSclock_component process list
 *
 * Starts draining cell per second while camera is active
 */
/obj/item/circuit_component/remotecam/proc/start_process()
	START_PROCESSING(SSclock_component, src)

/**
 * Removes the component to the SSclock_component process list
 *
 * Stops draining cell per second
 */
/obj/item/circuit_component/remotecam/proc/stop_process()
	STOP_PROCESSING(SSclock_component, src)

/obj/item/circuit_component/remotecam/drone
	display_name = "Drone Camera"
	desc = "Capture's surrounding sight for surveillance-on-the-go. Camera range input is either 0 (near) or 1 (far). Network field is used for camera network."
	category = "Sensor"

	required_shells = list(/mob/living/circuit_drone)

	var/mob/living/circuit_drone/drone = null

/obj/item/circuit_component/remotecam/bci
	display_name = "Eye Camera"
	desc = "Digitizes user's sight for surveillance-on-the-go. User must have fully functional eyes for digitizer to work. Camera range input is either 0 (near) or 1 (far). Network field is used for camera network."
	category = "BCI"

	required_shells = list(/obj/item/organ/internal/cyberimp/bci)

	var/obj/item/organ/internal/cyberimp/bci/bci = null

/obj/item/circuit_component/remotecam/drone/pre_input_received(datum/port/input/port)
	if(drone && shell_camera)
		update_camera("Drone")

/obj/item/circuit_component/remotecam/bci/pre_input_received(datum/port/input/port)
	if(bci && shell_camera)
		update_camera("BCI")

/obj/item/circuit_component/remotecam/drone/Destroy()
	drone = null
	return ..()

/obj/item/circuit_component/remotecam/bci/Destroy()
	bci = null
	return ..()

/obj/item/circuit_component/remotecam/drone/register_shell(atom/movable/shell)
	. = ..()
	drone = null
	shell_camera = null
	if(istype(shell, /mob/living/circuit_drone))
		drone = shell
		shell_camera = new /obj/machinery/camera (drone)
		init_camera("Drone")

/obj/item/circuit_component/remotecam/bci/register_shell(atom/movable/shell)
	. = ..()
	bci = null
	shell_camera = null
	if(istype(shell, /obj/item/organ/internal/cyberimp/bci))
		bci = shell
		shell_camera = new /obj/machinery/camera (bci)
		init_camera("BCI")

/obj/item/circuit_component/remotecam/drone/unregister_shell(atom/movable/shell)
	drone = null
	. = ..()

/obj/item/circuit_component/remotecam/bci/unregister_shell(atom/movable/shell)
	bci = null
	. = ..()

/obj/item/circuit_component/remotecam/drone/process(seconds_per_tick)
	if(drone && shell_camera)
		//If shell is destroyed
		if(drone.health < 0)
			close_camera()
			return
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		//If cell doesn't exist, or we ran out of power
		if(!cell?.use(camera_range.value > 0 ? power_usage_per_input_far_range : power_usage_per_input))
			close_camera()
			return
		//If the camera range has changed, update camera range
		if(!camera_range.value != !current_camera_range)
			current_camera_range = camera_range.value
			set_camera_range(current_camera_range)
		//Set the camera state (if state has been changed)
		if((!!on.value) ^ shell_camera.status)
			shell_camera.toggle_cam(null, 0)

/obj/item/circuit_component/remotecam/bci/process(seconds_per_tick)
	if(bci && shell_camera)
		//If shell is not currently inside a head, or user is currently blind, or user is dead
		if(!bci.owner || bci.owner.is_blind() || bci.owner.stat >= UNCONSCIOUS)
			close_camera()
			return
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		//If cell doesn't exist, or we ran out of power
		if(!cell?.use(current_camera_range > 0 ? power_usage_per_input_far_range : power_usage_per_input))
			close_camera()
			return
		//If owner is nearsighted, set camera range to short (if it wasn't already)
		if(bci.owner.is_nearsighted_currently())
			if(current_camera_range)
				current_camera_range = 0
				set_camera_range(0)
		//Else if the camera range has changed, update camera range
		else if(!camera_range.value != !current_camera_range)
			current_camera_range = camera_range.value
			set_camera_range(current_camera_range)
		//Set the camera state (if state has been changed)
		if((!!on.value) ^ shell_camera.status)
			shell_camera.toggle_cam(null, 0)

#undef REMOTECAM_RANGE_FAR
#undef REMOTECAM_RANGE_NEAR
