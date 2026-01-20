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


/init_loadout_categories()

	//Step 0: Create the loadout categories
	var/list/loadout_categories = list()
	for(var/category_type in subtypesof(/datum/loadout_category))
		loadout_categories += new category_type()
		loadout_categories.associated_items = list()

	//Step 1: Create loadout items based on vendors
	for(var/obj/machinery/vending/vendor as anything in GLOB.vendor_to_loadout)
		generate_loadout_list_from_vendor(vendor,GLOB.vendor_to_loadout[vendor])

	//Step 2: Create loadout items based config.
	for(var/datum/loadout_category/found_category as anything in loadout_categories)
		found_category.generate_from_config()

	//Step 3: Create loadout items based on world.
	for(var/datum/loadout_category/found_category as anything in loadout_categories)
		found_category.generate_from_world()

	sortTim(loadout_categories, /proc/cmp_loadout_categories)

	return loadout_categories