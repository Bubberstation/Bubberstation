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

// Better Emp solution
/mob/living/silicon/robot/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			Paralyze(6 SECONDS)
			set_confusion(20 SECONDS)
			drop_all_held_items()
		if(2)
			Paralyze(3 SECONDS)
			set_confusion(15 SECONDS)
			drop_all_held_items()
	..()
