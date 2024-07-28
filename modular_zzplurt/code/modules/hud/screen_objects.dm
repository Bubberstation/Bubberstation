/atom/movable/screen/intent_toggle
	name = "intent"
	icon_state = "help"
	screen_loc = ui_acti

/atom/movable/screen/intent_toggle/update_icon_state()
	. = ..()
	var/mob/living/owner = hud?.mymob
	if(owner)
		icon_state = resolve_intent_name(owner.combat_mode)

/atom/movable/screen/intent_toggle/Click(location, control, params)
	var/list/modifiers = params2list(params)
	var/_x = text2num(modifiers["icon-x"])
	var/_y = text2num(modifiers["icon-y"])
	var/mob/living/target_mob = usr

	if(_x <= 16)
		if(_y <= 16)
			target_mob.set_combat_mode(INTENT_HARM, silent = TRUE)
		else
			target_mob.set_combat_mode(INTENT_HELP, silent = TRUE)
	else if(_y <= 16)
		target_mob.set_combat_mode(INTENT_GRAB, silent = TRUE)
	else
		target_mob.set_combat_mode(INTENT_DISARM, silent = TRUE)
