/datum/loadout_item/New(category,desired_name,obj/item/desired_item_path)

	. = ..()

	if(desired_item_path.name) //We use the item's literal name instead of the fancy'd one in desired_name to save some code :)
		GLOB.loadout_blacklist_names[desired_item_path.name] = TRUE

	if(item_path)
		GLOB.all_loadout_datums[item_path] = src
