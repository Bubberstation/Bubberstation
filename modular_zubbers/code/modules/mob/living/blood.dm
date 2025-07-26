///Adds/removes entries in to_append for the compatible_types list of all blood types the filter is already in; set filter as null to edit all blood types... for some reason.
/proc/mass_edit_blood_compatibility(list/to_append, datum/blood_type/filter, mode_remove = FALSE)
	testing("mass_edit_blood_compatibility initialized with filter as [filter]")
	var/readout = ""
	var/list/compat_list = list()
	for(var/datum/blood_type/target as anything in subtypesof(/datum/blood_type))
		testing("mass_edit_blood_compatibility target is [target.type]") //this reads as the datum typepath...
		if(target::root_abstract_type == target) // Let's not modify placeholders
			testing("[target] skipped, abstract")
			testing("printing [target::root_abstract_type]")
			continue
		compat_list = target.get_compatibility()
		for(var/datum/blood_type/to_list as anything in compat_list)
			compat_list |= initial(to_list.name)
			testing("[to_list] added to [target].compatible_types")
		if(isnull(compat_list))
			testing("[target] skipped, could not retrieve compatible_types")
			continue
		readout = ""
		if(isnull(filter))  //cascading error from above.... compat_list can't be retrieved
			testing("filter null")
			switch(mode_remove)
				if(TRUE)
					compat_list -= to_append
				else
					compat_list += to_append
			target.compatible_types = compat_list
			for(var/i as anything in target.compatible_types)
				readout += "[i], "
			testing("[target] succesfully modified; new compatabilities are: [readout]")
		else
			testing("[target] skipped, filtered") //this works at least
	readout = ""
	return

