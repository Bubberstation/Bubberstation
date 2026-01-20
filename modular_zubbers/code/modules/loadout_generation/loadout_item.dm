/datum/loadout_item/New(category,desired_name,obj/item/desired_item_path)
	. = ..()
	GLOB.loadout_blacklist_names[name] = TRUE
	GLOB.all_loadout_datums[item_path] = src
