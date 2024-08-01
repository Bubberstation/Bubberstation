/datum/hud/human/New(mob/living/carbon/human/owner)
	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	// SPLURT EDIT - Extra inventory
	using = new /atom/movable/screen/human/toggle/extra(null, src)
	using.icon = extra_inventory_ui_style(ui_style)
	using.screen_loc = ui_inventory_extra
	toggleable_inventory += using

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "underwear"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "underwear"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "underwear"
	inv_box.screen_loc = ui_boxers
	inv_box.slot_id = ITEM_SLOT_UNDERWEAR
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "socks"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "socks"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "socks"
	inv_box.screen_loc = ui_socks
	inv_box.slot_id = ITEM_SLOT_SOCKS
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "shirt"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "shirt"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "shirt"
	inv_box.screen_loc = ui_shirt
	inv_box.slot_id = ITEM_SLOT_SHIRT
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "bra"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "bra"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "bra"
	inv_box.screen_loc = ui_bra
	inv_box.slot_id = ITEM_SLOT_BRA
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right ear"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "ears_extra"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "ears_extra"
	inv_box.screen_loc = ui_ears_extra
	inv_box.slot_id = ITEM_SLOT_EARS_RIGHT
	extra_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "wrists"
	inv_box.icon = extra_inventory_ui_style(ui_style)
	inv_box.icon_state = "wrists"
	inv_box.icon_full = "template"
	inv_box.icon_empty = "wrists"
	inv_box.screen_loc = ui_wrists
	inv_box.slot_id = ITEM_SLOT_WRISTS
	extra_inventory += inv_box
	//

	for(var/atom/movable/screen/inventory/inv in extra_inventory)
		if(inv.slot_id)
			inv_slots[TOBITSHIFT(inv.slot_id & ~ITEM_SLOT_EXTRA) + 21] = inv
			inv.update_appearance()
	. = ..()

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
		if(H.w_bra)
			H.w_bra.screen_loc = ui_bra
			screenmob.client.screen += H.w_bra
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
		if(H.w_bra)
			screenmob.client.screen -= H.w_bra
		if(H.wrists)
			screenmob.client.screen -= H.wrists
