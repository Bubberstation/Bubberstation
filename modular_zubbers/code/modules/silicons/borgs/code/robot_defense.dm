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
