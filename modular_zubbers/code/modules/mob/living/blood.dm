///Adds/removes entries in to_append for the compatible_types list of all blood types the filter is already in; set filter as null to edit all blood types... for some reason.
/proc/mass_edit_blood_compatability(list/to_append, datum/blood_type/filter, mode_remove = FALSE)
	testing("mass_edit_blood_compatability initialized with filter as [filter]")
	var/readout = ""
	var/list/compat_list = list()
	for(var/datum/blood_type/target as anything in subtypesof(/datum/blood_type))
		testing("mass_edit_blood_compatability target is [target]") //this reads as the datum typepath...
		if(target::root_abstract_type == target) // Let's not modify placeholders
			testing("[target] skipped, abstract")
			testing("printing [target.root_abstract_type]")
			continue
		compat_list = LAZYCOPY(target.compatible_types)
		readout = isnull(target.compatible_types)
		testing("is target.compatible_types null? [readout]")
		readout = ""
		readout = isnull(compat_list)
		testing("is compat_list null? [readout]")
		readout = ""
		testing("filter is [filter]")
		switch(filter)
			if(isnull(filter))
				testing("filter null")
				actually_MEBC(to_append, target, mode_remove)
			if(filter in compat_list) //cascading error from above....
				testing("filter found")
				actually_MEBC(to_append, target, mode_remove)
			else
				testing("[target] skipped, filtered") //this works at least

	readout = ""
	for(var/i as anything in to_append)
		readout+="[i], "
	NOTICE("mass_edit_blood_compatability successfully invoked: [readout]is/are  [mode_remove ? "no longer" : "now"] compatible with all blood types compatible containing ([filter]) or if null, all of them.")

///don't call this. also this entire section hasnt been tested because it hasn't gotten to run yet.
/proc/actually_MEBC(list/to_append, datum/blood_type/target, mode_remove)
	var/readout = ""
	var/list/compat_list = LAZYCOPY(target.compatible_types)
	switch(mode_remove)
		if(TRUE)
			compat_list -= to_append
		else
			compat_list += to_append
	target.compatible_types = compat_list
	for(var/i as anything in target.compatible_types)
		readout += "[i], "
	testing("[target] succesfully modified; new compatabilities are: [readout]")
