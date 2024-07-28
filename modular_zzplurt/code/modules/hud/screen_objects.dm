
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


/atom/movable/screen/focus_toggle
	name = "toggle combat mode"
	icon = 'icons/hud/screen_midnight.dmi'
	icon_state = "combat_off"
	screen_loc = "EAST-3:24,SOUTH:5"

/atom/movable/screen/focus_toggle/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	update_appearance()

/atom/movable/screen/focus_toggle/Click()
	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/owner = usr
	owner.set_combat_focus(!owner.focus_mode, FALSE)
	update_appearance()

/atom/movable/screen/focus_toggle/update_icon_state()
	var/mob/living/carbon/human/user = hud?.mymob
	if(!istype(user) || !user.client)
		return ..()

	icon_state = user.focus_mode ? "combat" : "combat_off"
	return ..()
