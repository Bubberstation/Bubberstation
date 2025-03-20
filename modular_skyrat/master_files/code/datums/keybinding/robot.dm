/datum/keybinding/robot/chesttoggle
	hotkey_keys = list("I")
	name = "Breastplate"
	full_name = "Toggle breast plate"
	description = "Toggles dullahan breast plate"
	keybind_signal = COMSIG_KB_ROBOT_BREASTPLATE_DOWN

/datum/keybinding/robot/chesttoggle/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/silicon/robot/borg = user.mob
	borg.is_breastplate_active = !borg.is_breastplate_active
	if(borg.is_breastplate_active)
		if(borg.robot_resting)
			borg.add_overlay("[borg.model.cyborg_base_icon]-chestrest")
		else
			borg.add_overlay("[borg.model.cyborg_base_icon]-chest")
	else
		if(borg.robot_resting)
			borg.cut_overlay("[borg.model.cyborg_base_icon]-chestrest")
		else
			borg.cut_overlay("[borg.model.cyborg_base_icon]-chest")
