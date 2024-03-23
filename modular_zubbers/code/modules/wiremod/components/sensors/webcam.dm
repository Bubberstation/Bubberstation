/**
 * # Web Camera Component
 *
 * Attaches a cheap camera for surveillance-on-the-go.
 * Only works on movable shells.
 *
 * This file is based off of eyecam.dm
 * Any changes made to that file should be copied over with discretion
 */
/obj/item/circuit_component/web_camera
	display_name = "Web Camera"
	desc = "Capture's surrounding sight for surveillance-on-the-go. Full range input is either 0 (off) or 1 (on). Network field is used for camera network."
	category = "Sensor"
	circuit_flags = CIRCUIT_NO_DUPLICATES

	power_usage_per_input = 3 //Normal components have 1, this is expensive to livestream footage
	var/power_usage_per_input_full_range = 8 //Full range vision should be expensive, crank this up to 8

	required_shells = list(/mob/living/circuit_drone)

	/// Whether the camera is on or not
	var/datum/port/input/on
	/// Camera range flag (short/full)
	var/datum/port/input/full_range
	/// The network to use
	var/datum/port/input/network

	/// Camera range internal flag
	var/full_range_current
	/// Camera random ID
	var/c_tag_random

	var/mob/living/circuit_drone/drone

/obj/item/circuit_component/web_camera/get_ui_notices()
	. = ..()
	. += create_ui_notice("Power Usage For Short Range: [power_usage_per_input] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")
	. += create_ui_notice("Power Usage For Full Range: [power_usage_per_input_full_range] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")

/obj/item/circuit_component/web_camera/populate_ports()
	on = add_input_port("On", PORT_TYPE_NUMBER, default = 0)
	full_range = add_input_port("Full Range", PORT_TYPE_NUMBER, default = 0)
	network = add_input_port("Network", PORT_TYPE_STRING, default = "ss13")

	full_range_current = full_range.value
	c_tag_random = rand(1, 999)

/obj/item/circuit_component/web_camera/pre_input_received(datum/port/input/port)
	if(drone?.shell_camera)
		if(!on.value)
			stop_process()
			if(drone.shell_camera.status) //Instantly turn off the camera
				drone.shell_camera.toggle_cam(null, 0)
		else if(on.value)
			update_name_network(drone)
			start_process()

/obj/item/circuit_component/web_camera/Destroy()
	stop_process()
	if(drone?.shell_camera)
		if(drone.shell_camera.status)
			drone.shell_camera.toggle_cam(null, 0)
	return ..()

/obj/item/circuit_component/web_camera/register_shell(atom/movable/shell)
	stop_process()
	. = ..()
	if(istype(shell, /mob/living/circuit_drone))
		drone = shell
		drone.shell_camera = new /obj/machinery/camera/drone (drone)
		drone.shell_camera.toggle_cam(null, 0)
		drone.shell_camera.setViewRange(full_range.value > 0 ? 7 : 2)
		full_range_current = full_range.value
		update_name_network(drone)

/obj/item/circuit_component/web_camera/unregister_shell(atom/movable/shell)
	stop_process()
	if(drone?.shell_camera)
		if(drone.shell_camera.status)
			drone.shell_camera.toggle_cam(null, 0)
		QDEL_NULL(drone.shell_camera)
	drone = null
	. = ..()

/obj/item/circuit_component/web_camera/process(seconds_per_tick)
	if(drone?.shell_camera)
		if(drone.health < 0) //If shell is destroyed
			if(drone.shell_camera.status) //Turn off camera
				drone.shell_camera.toggle_cam(null, 0)
			return
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		if(!cell || !cell?.use(full_range.value > 0 ? power_usage_per_input_full_range : power_usage_per_input)) //If cell doesn't exist, or we ran out of power
			if(drone.shell_camera.status) //Turn off camera
				drone.shell_camera.toggle_cam(null, 0)
			return
		if(!full_range.value != !full_range_current) //If the camera range has changed, update camera range
			drone.shell_camera.setViewRange(full_range.value > 0 ? 7 : 2)
			full_range_current = full_range.value
		if(on.value && !drone.shell_camera.status || !on.value && drone.shell_camera.status) //Set the camera state (if needed)
			drone.shell_camera.toggle_cam(null, 0)

/**
 * Updates the camera name and network
 */
/obj/item/circuit_component/web_camera/proc/update_name_network(atom/movable/shell)
	if(parent.display_name != "") //Set camera name using parent circuit name
		drone.shell_camera.c_tag = "Drone: [format_text(parent.display_name)]"
	else
		drone.shell_camera.c_tag = "Drone: [format_text(parent.name)] ([c_tag_random])"
	if(network.value != "") //Set camera network string
		drone.shell_camera.network = list("[format_text(network.value)]")
	else
		drone.shell_camera.network = list("ss13", "rd")

/**
 * Adds the component to the SSclock_component process list
 *
 * Starts draining cell per second while camera is active
 */
/obj/item/circuit_component/web_camera/proc/start_process()
	START_PROCESSING(SSclock_component, src)

/**
 * Removes the component to the SSclock_component process list
 *
 * Stops draining cell per second
 */
/obj/item/circuit_component/web_camera/proc/stop_process()
	STOP_PROCESSING(SSclock_component, src)
