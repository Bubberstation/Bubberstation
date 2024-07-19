/atom/movable/screen/human/toggle/extra
	name = "toggle extra"
	icon_state = "toggle_extra"

/atom/movable/screen/human/toggle/extra/Click()
	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.extra_shown && targetmob.hud_used)
		usr.hud_used.extra_shown = FALSE
		usr.client.screen -= targetmob.hud_used.extra_inventory
	else
		usr.hud_used.extra_shown = TRUE
		usr.client.screen += targetmob.hud_used.extra_inventory

	targetmob.hud_used.extra_inventory_update(usr)

/datum/hud/human/extra_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.extra_shown && screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.ears_extra)
			H.ears_extra.screen_loc = ui_ears_extra
			screenmob.client.screen += H.ears_extra
		if(H.w_underwear)
			H.w_underwear.screen_loc = ui_boxers
			screenmob.client.screen += H.w_underwear
		if(H.w_socks)
			H.w_socks.screen_loc = ui_socks
			screenmob.client.screen += H.w_socks
		if(H.w_shirt)
			H.w_shirt.screen_loc = ui_shirt
			screenmob.client.screen += H.w_shirt
		if(H.wrists)
			H.wrists.screen_loc = ui_wrists
			screenmob.client.screen += H.wrists
	else
		if(H.ears_extra)
			screenmob.client.screen -= H.ears_extra
		if(H.w_underwear)
			screenmob.client.screen -= H.w_underwear
		if(H.w_socks)
			screenmob.client.screen -= H.w_socks
		if(H.w_shirt)
			screenmob.client.screen -= H.w_shirt
		if(H.wrists)
			screenmob.client.screen -= H.wrists
