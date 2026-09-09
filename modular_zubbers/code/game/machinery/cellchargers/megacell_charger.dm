/obj/machinery/cell_charger/mega
	name = "megacell charger"
	desc = "It charges big power cells."
	icon_state = "ccharger_mega"
	circuit = /obj/item/circuitboard/machine/megacell_charger
	charge_rate = 0.5 * STANDARD_BATTERY_RATE

/obj/machinery/cell_charger/mega/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/battery) || panel_open)
		return NONE

	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src] is broken!"))
		return ITEM_INTERACT_BLOCKING
	if(!anchored)
		to_chat(user, span_warning("[src] isn't attached to the ground!"))
		return ITEM_INTERACT_BLOCKING
	if(charging)
		to_chat(user, span_warning("There is already a cell in the charger!"))
		return ITEM_INTERACT_BLOCKING

	var/area/charge_area = get_area(src)
	if(!isarea(charge_area))
		return ITEM_INTERACT_BLOCKING
	if(!charge_area.power_equip) // There's no APC in this area, don't try to cheat power!
		to_chat(user, span_warning("[src] blinks red as you try to insert the cell!"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	charging = tool
	user.visible_message(
		span_notice("[user] inserts a cell into [src]."),
		span_notice("You insert a cell into [src]."),
	)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/cell_charger/mega/RefreshParts()
	. = ..()
	var/tier_total
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		tier_total += capacitor.tier
	charge_rate = tier_total * (initial(charge_rate) / 3)
