/// Energy drawn from the cell per repaint. A stock AA is good for fifty.
#define COLORTRON_REPAINT_COST (0.01 * STANDARD_CELL_CHARGE)

/obj/item/colortron
	name = "\improper Nanotrasen HueBoy"
	desc = "Contains exactly one game about trying to find a rainbow, it isn't particularly challenging. Fortunately you can also use it to recolor select items. Wow! The marketing team is consistently baffled that people are buying it for this instead of the console's distinct lack of games."
	icon = 'modular_zubbers/icons/obj/devices/colortron.dmi'
	icon_state = "colortron"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_CREW * 2
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	/// The cell in the battery hatch. Screwdriver it out.
	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/crap

/obj/item/colortron/Initialize(mapload)
	. = ..()
	if(ispath(cell))
		cell = new cell(src)

/obj/item/colortron/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == cell)
		cell = null

/obj/item/colortron/get_cell()
	return cell

/obj/item/colortron/examine(mob/user)
	. = ..()
	. += span_notice("Click an item to repaint it.")
	if(!cell)
		. += span_warning("The battery hatch is empty.")
		return
	. += span_notice("Battery at [round(cell.percent())]%. Unscrew the hatch to swap it.")

/obj/item/colortron/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return NONE
	if(cell)
		balloon_alert(user, "already has a cell!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	cell = tool
	balloon_alert(user, "cell installed")
	return ITEM_INTERACT_SUCCESS

/obj/item/colortron/screwdriver_act(mob/living/user, obj/item/tool)
	if(!cell)
		balloon_alert(user, "no cell!")
		return ITEM_INTERACT_BLOCKING
	tool.play_tool_sound(src)
	cell.add_fingerprint(user)
	user.put_in_hands(cell)
	balloon_alert(user, "cell removed")
	cell = null
	return ITEM_INTERACT_SUCCESS

/obj/item/colortron/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isitem(interacting_with))
		return NONE
	// any greyscale item, element or not. that is the whole point
	if(!initial(interacting_with.greyscale_config) || !interacting_with.greyscale_colors)
		balloon_alert(user, "nothing to recolor!")
		return ITEM_INTERACT_BLOCKING
	if(!has_power())
		balloon_alert(user, "battery dead!")
		return ITEM_INTERACT_BLOCKING

	INVOKE_ASYNC(src, PROC_REF(open_recolor_menu), user, interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/colortron/proc/has_power()
	return cell && cell.charge() >= COLORTRON_REPAINT_COST

/obj/item/colortron/proc/open_recolor_menu(mob/user, obj/item/target)
	var/list/allowed_configs = list("[initial(target.greyscale_config)]")
	if(initial(target.greyscale_config_worn))
		allowed_configs += "[initial(target.greyscale_config_worn)]"
	if(initial(target.greyscale_config_inhand_left))
		allowed_configs += "[initial(target.greyscale_config_inhand_left)]"
	if(initial(target.greyscale_config_inhand_right))
		allowed_configs += "[initial(target.greyscale_config_inhand_right)]"

	var/datum/greyscale_modify_menu/colortron/menu = new(
		target,
		user,
		allowed_configs,
		CALLBACK(src, PROC_REF(apply_recolor), user, target),
		starting_icon_state = target::post_init_icon_state || target::icon_state,
		starting_config = initial(target.greyscale_config),
		starting_colors = target.greyscale_colors,
		used_device = src,
	)
	menu.ui_interact(user)

/obj/item/colortron/proc/apply_recolor(mob/user, obj/item/target, datum/greyscale_modify_menu/menu)
	if(!user.is_holding(src) || !user.can_perform_action(target, NEED_DEXTERITY|NEED_HANDS))
		menu.ui_close()
		return
	if(!has_power())
		balloon_alert(user, "battery dead!")
		menu.ui_close()
		return

	cell.use(COLORTRON_REPAINT_COST)
	playsound(src, 'sound/items/pshoom/pshoom.ogg', 40, TRUE)
	target.set_greyscale(menu.split_colors)

// leashed to the device instead of a spraycan
/datum/greyscale_modify_menu/colortron
	var/obj/item/colortron/device

/datum/greyscale_modify_menu/colortron/New(atom/target, client/user, list/allowed_configs, datum/callback/apply_callback, starting_icon_state, starting_config, starting_colors, obj/item/colortron/used_device)
	..()
	device = used_device

/datum/greyscale_modify_menu/colortron/Destroy()
	device = null
	return ..()

/datum/greyscale_modify_menu/colortron/ui_status(mob/user, datum/ui_state/state)
	return min(
		ui_status_only_living(user, target),
		ui_status_user_is_abled(user, target),
		ui_status_user_strictly_adjacent(user, target),
		user.is_holding(device) ? UI_INTERACTIVE : UI_CLOSE,
	)

#undef COLORTRON_REPAINT_COST
