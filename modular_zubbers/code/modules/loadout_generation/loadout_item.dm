/datum/loadout_item
	var/generated = FALSE

/datum/loadout_item/New(category,desired_name,obj/item/desired_item_path)

	if(desired_name)
		name = desired_name

	if(desired_item_path)
		item_path = desired_item_path

	. = ..()

	if(item_path)
		if(item_path.name) //We use the item's literal name instead of the fancy'd one in desired_name to save some code :)
			GLOB.loadout_blacklist_names[item_path.name] = TRUE
		GLOB.all_loadout_datums[item_path] = src
