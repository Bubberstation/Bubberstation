/obj/machinery/rbmk2_sniffer/screwdriver_act(mob/living/user, obj/item/attack_item)

	if(default_deconstruction_screwdriver(user, icon_state, icon_state, attack_item))
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_FAILURE

/obj/machinery/rbmk2_sniffer/crowbar_act(mob/living/user, obj/item/attack_item)

	if(default_deconstruction_crowbar(attack_item))
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_FAILURE

/obj/machinery/rbmk2_sniffer/multitool_act(mob/living/user, obj/item/multitool/tool)

	if(panel_open)
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_FAILURE

/obj/machinery/rbmk2_sniffer/wirecutter_act(mob/living/user, obj/item/tool)

	if(panel_open)
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_FAILURE
