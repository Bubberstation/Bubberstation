/datum/preference_middleware/loadout/proc/action_select_item(list/params, mob/user)
	PRIVATE_PROC(TRUE)
	var/path_to_use = text2path(params["path"])

	var/obj/item/interacted_item = GLOB.loadout_item_path_to_datum[path_to_use]

	if(!istype(interacted_item))
		stack_trace("Failed to locate desired loadout item (path: [params["path"]]) in the global list of loadout to item datums!")
		return TRUE // update

	if(params["deselect"])
		deselect_item(interacted_item)
	else
		select_item(interacted_item)

	return TRUE