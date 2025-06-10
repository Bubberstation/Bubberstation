///Adds/removes entries in to_append for the compatible_types list of all blood types the filter is already in; set filter as null to edit all blood types... for some reason.
/proc/mass_edit_blood_compatability(list/to_append, filter, mode_remove = FALSE)
	testing("mass_edit_blood_compatability initialized")
	var/readout = ""
	filter = GLOB.blood_types[filter]
	for(var/datum/blood_type/target as anything in subtypesof(/datum/blood_type))
		readout = ""
		if(target::root_abstract_type == target) // Let's not modify placeholders
			testing("[target] skipped, abstract")
			continue
		testing("mass_edit_blood_compatability target is [target]")
		var/amicrazy = isnull(target.compatible_types)
		testing("target.compatible_types is [amicrazy ? "not " : ""]null")
		for(var/i as anything in target.compatible_types)
			readout=i
			testing("[target].compatible_types contains [readout]")
		readout = ""
		if(!filter || filter in target.compatible_types)
			switch(mode_remove)
				if(FALSE)
					target.compatible_types += to_append
				if(TRUE)
					target.compatible_types -= to_append
			for(var/i in target.compatible_types)
				readout+=i
			testing("[target] succesfully modified; new compatabilities are: [readout]")
		else
			testing("[target] skipped, filtered")
	readout = ""
	for(var/i as anything in to_append)
		readout+="[i]"
	NOTICE("mass_edit_blood_compatability successfully invoked: ([readout]) is/are compatible [mode_remove ? "no longer" : "now"] with all blood types compatible containing ([filter]) or if null, all of them.")
