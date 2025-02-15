// Define for in hand sprite
/mob/living/silicon/robot
	//TODO: real holding sprites these are just place holders for the time
	held_lh = 'icons/mob/inhands/pai_item_lh.dmi'
	held_rh = 'icons/mob/inhands/pai_item_rh.dmi'
	held_state = "cat"

	// Components
	var/list/components = list()
	var/obj/machinery/camera/camera = null

//Cyborgs that are being held should act almost as how the AI behaves when carded.
/mob/living/silicon/robot/mob_pickup(mob/living/user)
	drop_all_held_items()
	toggle_headlamp(TRUE)
	return ..()

/mob/living/silicon/robot/mob_try_pickup(mob/living/user, instant=FALSE)
	if(stat == DEAD || HAS_TRAIT(src, TRAIT_GODMODE))
		return
	return ..()

/// Components! These are basically robot organs

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	initialize_components()
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		C.installed = 1
		C.install()
		C.wrapped = new C.external_type

/// To restore any missing or broken components
/mob/living/silicon/robot/proc/restore_components()
	for (var/V in components)
		var/datum/robot_component/C = components[V]
		if(istype(C.wrapped, /obj/item/robot_parts/robot_component))
			C.brute_damage = 0
			C.burn_damage = 0
			C.repair()

		if(!C.wrapped)// Do we have a component?
			switch(V)
				if("actuator")
					C.wrapped = new /obj/item/robot_parts/robot_component/actuator(src)
				if("radio")
					C.wrapped = new /obj/item/robot_parts/robot_component/radio(src)
				if("diagnosis unit")
					C.wrapped = new /obj/item/robot_parts/robot_component/diagnosis_unit(src)
				if("camera")
					C.wrapped = new /obj/item/robot_parts/robot_component/camera(src)
				if("comms")
					C.wrapped = new /obj/item/robot_parts/robot_component/binary_communication_device(src)
				if("armour")
					C.wrapped = new /obj/item/robot_parts/robot_component/armour(src)
			C.install()
			C.installed = 1
	return

/// Checks if a cyborg has a cell and replaces or sets it to max charge
/mob/living/silicon/robot/proc/restore_cell()
	if(!opened)
		if(cell)
			cell.charge = cell.maxcharge //Needed since borgs now require to have power
		else if(!cell)
			cell = new /obj/item/stock_parts/power_store/cell/high(src)
	return

//Component toggling - mostly used for debugging

/mob/living/silicon/robot/verb/toggle_component()
	set category = "AI Commands"
	set name = "Toggle Component"
	set desc = "Toggle a component on of off."

	var/list/installed_components = list()
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		if(C.installed)
			installed_components += V

	var/toggle = tgui_input_list(src, "Which component do you want to toggle?", "Toggle Component", installed_components)
	if(!toggle)
		return

	var/datum/robot_component/C = components[toggle]
	if(C.toggled)
		C.toggled = 0
		to_chat(src, span_warning("You disable [C.name]!"))
	else
		C.toggled = 1
		to_chat(src, span_warning("You enable [C.name]!"))
