/**********************************************************************
						Components oh god oh fuck
***********************************************************************/

// TODO: remove the robot.mmi and robot.cell variables and completely rely on the robot component system
/datum/robot_component
	var/name
	var/installed = 0
	var/powered = 1
	var/toggled = 1
	var/brute_damage = 0
	var/burn_damage = 0
	var/required_power = 0   // Amount of power needed to function
	var/max_damage = 30  // HP of this component.
	var/mob/living/silicon/robot/owner

// The actual device object that has to be installed for this.
	var/external_type = null

// The wrapped device(e.g. radio), only set if external_type isn't null
	var/obj/item/wrapped = null

/datum/robot_component/New(mob/living/silicon/robot/R)
	src.owner = R

/datum/robot_component/proc/accepts_component(var/obj/item/thing)
	. = istype(thing, external_type)

//Proc defines
/datum/robot_component/proc/install()
	if(istype(wrapped, /obj/item/robot_parts/robot_component))
		var/obj/item/robot_parts/robot_component/comp = wrapped
		if(!(comp.broken))//Don't apply when broken only when working
			brute_damage = comp.brute
			burn_damage = comp.burn
		max_damage = comp.max_damage
		required_power = comp.required_power
		comp.brute = initial(brute_damage)
		comp.burn = initial(brute_damage)
		owner.updatehealth()
		return
	return

/datum/robot_component/proc/uninstall()
	if(istype(wrapped, /obj/item/robot_parts/robot_component))
		var/obj/item/robot_parts/robot_component/comp = wrapped
		comp.brute = brute_damage
		comp.burn = burn_damage
	max_damage = initial(max_damage)
	required_power = initial(required_power)

/datum/robot_component/proc/destroy()
	var/brokenstate = "broken" // Generic icon
	if(istype(wrapped, /obj/item/robot_parts/robot_component))
		var/obj/item/robot_parts/robot_component/comp = wrapped
		brokenstate = comp.icon_state_broken
		comp.broken = TRUE

	wrapped.icon_state = brokenstate // Module-specific broken icons! Yay!

	// The thing itself isn't there anymore, but some fried remains are.
	installed = -1
	uninstall()

/datum/robot_component/proc/repair()
	install()
	installed = 1
	//This is after to prevent installing from applying the previous damage when last broken
	if(istype(wrapped, /obj/item/robot_parts/robot_component))
		var/obj/item/robot_parts/robot_component/comp = wrapped
		comp.broken = FALSE
	wrapped.icon_state = initial(wrapped.icon_state)

/datum/robot_component/proc/take_damage(brute, burn)
	if(installed != 1)
		return

	brute_damage += brute
	burn_damage += burn

	if(brute_damage + burn_damage >= max_damage)
		destroy()

/datum/robot_component/proc/heal_damage(brute, burn)
	if(!(installed == 1 || installed == -1))
		// If it's not installed, can't repair it.
		return FALSE

	brute_damage = max(0, brute_damage - brute)
	burn_damage = max(0, burn_damage - burn)

	if(brute_damage + burn_damage <= max_damage)
		if(installed == 1)
			return FALSE
		repair()

/datum/robot_component/proc/is_powered()
	return (installed == 1) && (brute_damage + burn_damage < max_damage) && (powered)

/datum/robot_component/proc/update_power_state()
	if(toggled == 0)
		powered = 0
		return
	if(owner.cell && owner.cell.charge >= required_power) //replaces idle usage
		powered = 1
	else
		powered = 0


// ARMOUR
// Protects the cyborg from damage. Usually first module to be hit
// No power usage
/datum/robot_component/armour
	name = "armour plating"
	external_type = /obj/item/robot_parts/robot_component/armour
	max_damage = 90


// ACTUATOR
// Enables movement.
// Uses no power when idle. Uses 200J for each tile the cyborg moves.
/datum/robot_component/actuator
	name = "actuator"
	required_power = 0
	external_type = /obj/item/robot_parts/robot_component/actuator
	max_damage = 50


/datum/robot_component/actuator/update_power_state()
	..()
	if(!(TRAIT_IMMOBILIZED in owner._status_traits))// So we don't just suddenly unlock wile locked down
		if(!(owner.mobility_flags & MOBILITY_MOVE))
			if(owner.is_component_functioning("actuator"))
				owner.mobility_flags = MOBILITY_FLAGS_DEFAULT

/*
//A fixed and much cleaner implementation of /tg/'s special snowflake code.
/datum/robot_component/actuator/is_powered()
	return (installed == 1) && (brute_damage + burn_damage < max_damage)
*/
//Disabled because we already lose power when emped
/*
// POWER CELL
// Stores power (how unexpected..)
// No power usage
/datum/robot_component/cell
	name = "power cell"
	max_damage = 50
	var/obj/item/stock_parts/cell/stored_cell = null

/datum/robot_component/cell/destroy()
	..()
	stored_cell = owner.cell
	owner.cell = null

/datum/robot_component/cell/Destroy()
	QDEL_NULL(stored_cell)
	return ..()

/datum/robot_component/cell/repair()
	owner.cell = stored_cell
	stored_cell = null
*/

// RADIO
// Enables radio communications
// Uses no power when idle. Uses 10J for each received radio message, 50 for each transmitted message.
/datum/robot_component/radio
	name = "radio"
	external_type = /obj/item/robot_parts/robot_component/radio
	max_damage = 40


// BINARY RADIO
// Enables binary communications with other cyborgs/AIs
// Uses no power when idle. Uses 10J for each received radio message, 50 for each transmitted message
/datum/robot_component/binary_communication
	name = "binary communication device"
	external_type = /obj/item/robot_parts/robot_component/binary_communication_device
	max_damage = 30


// CAMERA
// Enables cyborg vision. Can also be remotely accessed via consoles.
// Uses 10J constantly
/datum/robot_component/camera
	name = "camera"
	external_type = /obj/item/robot_parts/robot_component/camera
	required_power = 10
	max_damage = 40
	var/obj/machinery/camera/camera

/datum/robot_component/camera/New(mob/living/silicon/robot/R)
	..()
	camera = R.camera

/datum/robot_component/camera/update_power_state()
	..()
	if (camera)
		camera.camera_enabled = powered

/datum/robot_component/camera/install()
	..()
	if (camera)
		camera.camera_enabled = TRUE

/datum/robot_component/camera/uninstall()
	..()
	if (camera)
		camera.camera_enabled = FALSE

/datum/robot_component/camera/destroy()
	..()
	if (camera)
		camera.camera_enabled = FALSE

// SELF DIAGNOSIS MODULE
// Analyses cyborg's modules, providing damage readouts and basic information
// Uses 1kJ burst when analysis is done - UH NUH UH
/datum/robot_component/diagnosis_unit
	name = "self-diagnosis unit"
	external_type = /obj/item/robot_parts/robot_component/diagnosis_unit
	max_damage = 30




// HELPER STUFF


// Initializes cyborg's components. Technically, adds default set of components to new borgs
/mob/living/silicon/robot/proc/initialize_components()
	components["actuator"] = new/datum/robot_component/actuator(src)
	components["radio"] = new/datum/robot_component/radio(src)
	//components["power cell"] = new/datum/robot_component/cell(src) // this part is CBT i ain't adding it
	components["diagnosis unit"] = new/datum/robot_component/diagnosis_unit(src)
	components["camera"] = new/datum/robot_component/camera(src)
	components["comms"] = new/datum/robot_component/binary_communication(src)
	components["armour"] = new/datum/robot_component/armour(src)

// Checks if component is functioning
/mob/living/silicon/robot/proc/is_component_functioning(module_name)
	var/datum/robot_component/C = components[module_name]
	return C && C.installed == 1 && C.toggled && C.is_powered()

// Returns component by it's string name
/mob/living/silicon/robot/proc/get_component(var/component_name)
	var/datum/robot_component/C = components[component_name]
	return C



// COMPONENT OBJECTS



// Component Objects
// These objects are visual representation of modules

/obj/item/broken_device
	name = "broken component"
	icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/robot_component.dmi'
	icon_state = "broken"

/obj/item/broken_device/random
	var/static/list/possible_icons = list("binradio_broken",
									"motor_broken",
									"armor_broken",
									"camera_broken",
									"analyser_broken",
									"radio_broken")

/obj/item/broken_device/random/Initialize(mapload)
	. = ..()
	icon_state = pick(possible_icons)

/obj/item/robot_parts/robot_component
	icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/robot_component.dmi'
	icon_state = "working"
	var/brute = 0
	var/burn = 0
	var/icon_state_broken = "broken"
	var/required_power = 0
	var/max_damage = 0
	var/broken = FALSE

/obj/item/robot_parts/robot_component/binary_communication_device
	name = "binary communication device"
	icon_state = "binradio"
	icon_state_broken = "binradio_broken"
	required_power = STANDARD_CELL_CHARGE * 0.005
	max_damage = 30

/obj/item/robot_parts/robot_component/actuator
	name = "actuator"
	icon_state = "motor"
	icon_state_broken = "motor_broken"
	required_power = 0
	max_damage = 50

/obj/item/robot_parts/robot_component/armour
	name = "armour plating"
	desc = "A pair of flexible, adaptable armor plates, used to protect the internals of robots."
	icon_state = "armor"
	icon_state_broken = "armor_broken"
	max_damage = 90

/obj/item/robot_parts/robot_component/camera
	name = "camera"
	icon_state = "camera"
	icon_state_broken = "camera_broken"
	required_power = STANDARD_CELL_CHARGE * 0.010
	max_damage = 40

/obj/item/robot_parts/robot_component/diagnosis_unit
	name = "diagnosis unit"
	icon_state = "analyser"
	icon_state_broken = "analyser_broken"
	max_damage = 30

/obj/item/robot_parts/robot_component/radio
	name = "radio"
	icon_state = "radio"
	icon_state_broken = "radio_broken"
	required_power = STANDARD_CELL_CHARGE * 0.015
	max_damage = 40
