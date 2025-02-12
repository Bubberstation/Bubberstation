//Alt method of removing the cell
/mob/living/silicon/robot/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	if(!opened)
		return ..()
	if(!wiresexposed)
		if(!cell)
			balloon_alert(user, "no cell!")
			return TRUE
		balloon_alert(user, "removing cell...")
		tool.play_tool_sound(src, 100)
		if(!tool.use_tool(src, user, 3 SECONDS) || !opened)
			balloon_alert(user, "interrupted!")
			return TRUE
		tool.play_tool_sound(src, 100)
		balloon_alert(user, "cell removed")
		cell.forceMove(drop_location())
		diag_hud_set_borgcell()
	return TRUE

/**********************************************************************
						Components oh god oh fuck
***********************************************************************/

//Component removal
/mob/living/silicon/robot/crowbar_act_secondary(mob/living/user, obj/item/tool)
	if(opened)
		if(!cell)
			var/list/removable_components = list()
			for(var/V in components)
				var/datum/robot_component/C = components[V]
				if(C.installed == 1 || C.installed == -1)
					removable_components += V

			var/remove = tgui_input_list(user, "Which component do you want to pry out?", "Remove Component", removable_components)
			if(!remove)
				return TRUE
			if(!tool.use_tool(src, user, 1 SECONDS) || !opened)
				balloon_alert(user, "interrupted!")
				return TRUE
			var/obj/item/removed_item
			if(istype(components[remove], /datum/robot_component))
				var/datum/robot_component/C = components[remove]
				var/obj/item/robot_parts/robot_component/I = C.wrapped
				balloon_alert(user, "component removed")
				/*
				if(istype(I))
					I.brute = C.brute_damage
					I.burn = C.electronics_damage
				*/

				removed_item = I

				if(C.installed == 1)
					C.uninstall()
				C.installed = 0

				if(I)
					removed_item.forceMove(drop_location())
					tool.play_tool_sound(src, 100)
					C.wrapped = null
				return TRUE
	return TRUE

/// Component damage below

/mob/living/silicon/robot/getMaxHealth()
	. = ..()
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		. += C.max_damage - initial(C.max_damage)

/mob/living/silicon/robot/getBruteLoss()
	var/amount = 0
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		if(C.installed != 0) amount += C.brute_damage
	return amount

/mob/living/silicon/robot/getFireLoss()
	var/amount = 0
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		if(C.installed != 0) amount += C.electronics_damage
	return amount

/mob/living/silicon/robot/proc/get_damaged_components(var/brute, var/burn, var/destroyed = 0)
	var/list/datum/robot_component/parts = list()
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		if(C.installed == 1 || (C.installed == -1 && destroyed))
			if((brute && C.brute_damage) || (burn && C.electronics_damage) || (!C.toggled) || (!C.powered && C.toggled))
				parts += C
	return parts

//Checks if armor is present and not broken
/mob/living/silicon/robot/proc/get_armour()

	if(!components.len) return 0
	var/datum/robot_component/C = components["armour"]
	if(C && C.installed == 1)
		return C
	return FALSE


/mob/living/silicon/robot/proc/get_damageable_components()
	var/list/rval = new
	for(var/V in components)
		var/datum/robot_component/C = components[V]
		if(C.installed == 1) rval += C
	return rval


/mob/living/silicon/robot/proc/heal_organ_damage(var/brute, var/burn, var/affect_robo = FALSE, var/update_health = TRUE)
	var/list/datum/robot_component/parts = get_damaged_components(brute, burn)
	if(!parts.len)	return
	var/datum/robot_component/picked = pick(parts)
	picked.heal_damage(brute,burn)

/mob/living/silicon/robot/proc/take_organ_damage(var/brute = 0, var/burn = 0, var/bypass_armour = FALSE)
	var/list/components = get_damageable_components()
	if(!components.len)
		return

	if(!bypass_armour)
		var/datum/robot_component/armour/A = get_armour()
		if(A)
			A.take_damage(brute, burn)
			return

	var/datum/robot_component/C = pick(components)
	C.take_damage(brute, burn)


/mob/living/silicon/robot/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			src.take_organ_damage(0,20,bypass_armour=1)
			emp_knockout(5 SECONDS) // Maybe not charge at the person with ions
			drop_all_held_items()
		if(2)
			src.take_organ_damage(0,15,bypass_armour=1)
			Paralyze(3 SECONDS)
			drop_all_held_items()
		if(3)
			src.take_organ_damage(0,10,bypass_armour=1)
			//Confuse(3)
			drop_all_held_items()
		if(4)
			src.take_organ_damage(0,5,bypass_armour=1)
			//Confuse(2)
			drop_all_held_items()
	..()
