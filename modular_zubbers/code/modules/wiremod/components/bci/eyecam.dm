/**
 * # Eye Camera Component
 *
 * Digitizes user's sight for surveillance-on-the-go.
 * Requires a BCI shell.
 *
 * This file is based off of webcam.dm
 * Any changes made to that file should be copied over with discretion
 */
/obj/item/circuit_component/eye_camera
	display_name = "Eye Camera"
	desc = "Digitizes user's sight for surveillance-on-the-go. User must have fully functional eyes for digitizer to work. Full range input is either 0 (off) or 1 (on). Network field is used for camera network."
	category = "BCI"
	circuit_flags = CIRCUIT_NO_DUPLICATES

	power_usage_per_input = 3 //Normal components have 1, this is expensive to livestream footage
	var/power_usage_per_input_full_range = 8 //Full range vision should be expensive, crank this up to 8

	required_shells = list(/obj/item/organ/internal/cyberimp/bci)

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

	var/obj/item/organ/internal/cyberimp/bci/bci

/obj/item/circuit_component/eye_camera/get_ui_notices()
	. = ..()
	. += create_ui_notice("Power Usage For Short Range: [power_usage_per_input] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")
	. += create_ui_notice("Power Usage For Full Range: [power_usage_per_input_full_range] Per [DisplayTimeText(COMP_CLOCK_DELAY)]", "orange", "clock")

/obj/item/circuit_component/eye_camera/populate_ports()
	on = add_input_port("On", PORT_TYPE_NUMBER, default = 0)
	full_range = add_input_port("Full Range", PORT_TYPE_NUMBER, default = 0)
	network = add_input_port("Network", PORT_TYPE_STRING, default = "ss13")

	full_range_current = full_range.value
	c_tag_random = rand(1, 999)

/obj/item/circuit_component/eye_camera/pre_input_received(datum/port/input/port)
	if(bci?.shell_camera)
		if(!on.value)
			stop_process()
			if(bci.shell_camera.status) //Instantly turn off the camera
				bci.shell_camera.toggle_cam(null, 0)
		else if(on.value)
			update_name_network(bci)
			start_process()

/obj/item/circuit_component/eye_camera/Destroy()
	stop_process()
	if(bci?.shell_camera)
		if(bci.shell_camera.status)
			bci.shell_camera.toggle_cam(null, 0)
	return ..()

/obj/item/circuit_component/eye_camera/register_shell(atom/movable/shell)
	stop_process()
	. = ..()
	if(istype(shell, /obj/item/organ/internal/cyberimp/bci))
		bci = shell
		bci.shell_camera = new /obj/machinery/camera/bci (bci)
		bci.shell_camera.toggle_cam(null, 0)
		bci.shell_camera.setViewRange(full_range.value > 0 ? 7 : 2)
		full_range_current = full_range.value
		update_name_network(bci)

/obj/item/circuit_component/eye_camera/unregister_shell(atom/movable/shell)
	stop_process()
	if(bci?.shell_camera)
		if(bci.shell_camera.status)
			bci.shell_camera.toggle_cam(null, 0)
		QDEL_NULL(bci.shell_camera)
	bci = null
	. = ..()

/obj/item/circuit_component/eye_camera/process(seconds_per_tick)
	if(bci?.shell_camera)
		//If shell is not currently inside a head, or user is currently blind, or user is dead
		if(!bci.owner || bci.owner.is_blind() || bci.owner.IsUnconscious() || bci.owner.stat == DEAD)
			if(bci.shell_camera.status) //Turn off camera
				bci.shell_camera.toggle_cam(null, 0)
			return
		var/obj/item/stock_parts/cell/cell = parent.get_cell()
		//If cell doesn't exist, or we ran out of power
		if(!cell || !cell?.use(full_range_current > 0 ? power_usage_per_input_full_range : power_usage_per_input))
			if(bci.shell_camera.status) //Turn off camera
				bci.shell_camera.toggle_cam(null, 0)
			return
		//If owner is nearsighted, set camera range to short (if it wasn't already)
		if(bci.owner.is_nearsighted_currently())
			if(full_range_current)
				bci.shell_camera.setViewRange(2)
				full_range_current = 0
		//Else if the camera range has changed, update camera range
		else if(!full_range.value != !full_range_current)
			bci.shell_camera.setViewRange(full_range.value > 0 ? 7 : 2)
			full_range_current = full_range.value
		//Set the camera state (if needed)
		if(on.value && !bci.shell_camera.status || !on.value && bci.shell_camera.status)
			bci.shell_camera.toggle_cam(null, 0)

/**
 * Updates the camera name and network
 */
/obj/item/circuit_component/eye_camera/proc/update_name_network(atom/movable/shell)
	//Set camera name using parent circuit name
	if(parent.display_name != "")
		bci.shell_camera.c_tag = "BCI: [format_text(parent.display_name)]"
	else
		bci.shell_camera.c_tag = "BCI: [format_text(parent.name)] ([c_tag_random])"
	//Set camera network string
	if(network.value != "")
		bci.shell_camera.network = list("[format_text(network.value)]")
	else
		bci.shell_camera.network = list("ss13", "rd")

/**
 * Adds the component to the SSclock_component process list
 *
 * Starts draining cell per second while camera is active
 */
/obj/item/circuit_component/eye_camera/proc/start_process()
	START_PROCESSING(SSclock_component, src)

/**
 * Removes the component to the SSclock_component process list
 *
 * Stops draining cell per second
 */
/obj/item/circuit_component/eye_camera/proc/stop_process()
	STOP_PROCESSING(SSclock_component, src)
