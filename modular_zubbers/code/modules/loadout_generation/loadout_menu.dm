/datum/preference_middleware/loadout/proc/action_select_item(list/params, mob/user)

	PRIVATE_PROC(TRUE)

	var/obj/item/path_to_use = text2path(params["path"])

	if(!path_to_use)
		stack_trace("Invalid path: [params["path"]]!")
		return TRUE

	var/datum/loadout_item/found_loadout_item = GLOB.all_loadout_datums[path_to_use]

	if(!istype(found_loadout_item))
		stack_trace("Failed to locate desired loadout item (path: [path_to_use]) in the global list of loadout to item datums!")
		return TRUE

	if(params["deselect"])
		deselect_item(found_loadout_item)
	else
		select_item(found_loadout_item)

	return TRUE
