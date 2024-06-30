// Define for in hand sprite
/mob/living/silicon/robot
	//TODO: real holding sprites these are just place holders for the time
	held_lh = 'icons/mob/inhands/pai_item_lh.dmi'
	held_rh = 'icons/mob/inhands/pai_item_rh.dmi'
	held_state = "cat"


	/// Components! These are basically robot organs
	var/list/components = list()
	var/obj/machinery/camera/camera = null

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	initialize_components()
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		C.install_component()
		C.wrapped = new C.external_type

//Component toggling - mostly used for debugging

/mob/living/silicon/robot/verb/toggle_component()
	set category = "AI Commands"
	set name = "Toggle Component"
	set desc = "Toggle a component, conserving power."

	var/list/installed_components = list()
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		if(C.installed)
			installed_components += V

	var/toggle = input(src, "Which component do you want to toggle?", "Toggle Component") as null|anything in installed_components
	if(!toggle)
		return

	var/datum/robot_component/C = components[toggle]
	if(C.toggled)
		C.toggled = 0
		to_chat(src, span_warning("You disable [C.name]!"))
	else
		C.toggled = 1
		to_chat(src, span_warning("You enable [C.name]!"))


//Cyborgs that are being held should act almost as how the AI behaves when carded.
/mob/living/silicon/robot/mob_pickup(mob/living/user)
	drop_all_held_items()
	toggle_headlamp(TRUE)
	return ..()

/mob/living/silicon/robot/mob_try_pickup(mob/living/user, instant=FALSE)
	if(stat == DEAD || status_flags & GODMODE)
		return
	return ..()
