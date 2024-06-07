ADMIN_VERB(debug_maintenance_loot, R_DEBUG, "Debug Maintenance Loot", "List all items in the game that are not in maintenance loot", ADMIN_CATEGORY_DEBUG)

	var/confirm = input(user,"Are you sure you wish to debug maintenance loot? This process takes up a lot of the server's resources.","Debug Maintenance Loot","Cancel") as null|anything in list("Yes","No","Cancel")
	if(confirm != "Yes")
		return

	log_admin("[key_name(user)] has started debugging maintenance loot.")

	var/list/every_single_maintenance_item = list()
	for(var/loot_list in GLOB.maintenance_loot)
		for(var/loot_object in loot_list)
			if(islist(loot_object))
				for(var/k in loot_object)
					every_single_maintenance_item[k] = TRUE
			else
				every_single_maintenance_item[loot_object] = TRUE

	var/returning_data = "<h1>List of items not present in maintenance loot tables:</h1><br>"
	for(var/k in subtypesof(/obj/item/))
		if(!every_single_maintenance_item[k])
			returning_data = "[returning_data]<br>[k]"

	user << browse(returning_data, "window=maintenace_report")
