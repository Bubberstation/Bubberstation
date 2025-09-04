proc/loadout_list_to_datums(list/loadout_list) as /list

	var/list/datums = list()

	for(var/path in loadout_list)

		var/obj/item/found_item_path

		if(ispath(path,/datum/loadout_item/))
			var/datum/loadout_item/old_method_datum = path
			found_item_path = initial(old_method_datum.item_path)

		else if(ispath(path,/obj/item))
			found_item_path = path

		if(!found_item_path)
			continue

		var/datum/loadout_item/actual_loadout_item = GLOB.all_loadout_datums[found_item_path]
		if(!actual_loadout_item)
			continue

		datums += actual_loadout_item

	return datums
