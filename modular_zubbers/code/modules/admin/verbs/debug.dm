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

ADMIN_VERB(simulate_maintenance_loot, R_DEBUG, "Simulate Maintenance Loot", "Simulate 100 maintenance loot spawns. Special trait modifiers NOT applied.", ADMIN_CATEGORY_DEBUG)

	var/confirm = input(user,"Are you sure you wish to simulate maintenance loot? This process takes up a lot of the server's resources.","Simulate Maintenance Loot","Cancel") as null|anything in list("Yes","No","Cancel")
	if(confirm != "Yes")
		return

	var/list/current_loot_counts = list() //Assoc list. path = count

	var/missing_count = 0
	for(var/i=1,i<=500,i++)
		var/atom/movable/M = pick_weight_recursive(GLOB.maintenance_loot)
		if(!M) //wat
			missing_count++
			continue
		if(!current_loot_counts[M])
			current_loot_counts[M] = 1
		else
			current_loot_counts[M] += 1

	sortTim(current_loot_counts, cmp=/proc/cmp_numeric_dsc, associative = TRUE)

	var/returning_data = "<h1>List of 500 simulated maintenance spawns:</h1><br>"
	var/confirmation_count = 0
	var/different_path_count = 0
	for(var/atom_path in current_loot_counts)
		returning_data = "[returning_data]<br>[atom_path]: [current_loot_counts[atom_path]] ([round(current_loot_counts[atom_path]/5,0.01)]%)"
		confirmation_count += current_loot_counts[atom_path]
		different_path_count += 1

	returning_data = "[returning_data]<br>Listed [different_path_count] different types of objects, with [confirmation_count] total objects and [missing_count] missing objects."

	user << browse(returning_data, "window=maintenace_report")
