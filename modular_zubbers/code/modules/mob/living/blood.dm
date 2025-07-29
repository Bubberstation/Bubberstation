///Attempts to add/remove the origin blood type to the compatible_types list of all blood types (with the filter)
/datum/blood_type/proc/init_mass_edit_blood_compatibility(datum/blood_type/filter, mode_remove = FALSE)
	var/to_insert = type
	testing("mass_edit_blood_compatibility initialized with filter as [filter], and injection as [to_insert]")
	for(var/datum/blood_type/target as anything in subtypesof(/datum/blood_type))
		testing("mass_edit_blood_compatibility target is [target.type]") //this reads as the datum typepath...
		if(target?.root_abstract_type == target) // Let's not modify placeholders
			testing("[target] skipped, abstract")
			testing("printing [target::root_abstract_type]")
			continue
		testing("[target] isn't abstract. If it stops here... idk?")
		exec_MEBC(target, filter, to_insert, mode_remove)
	return

/datum/blood_type/proc/exec_MEBC(datum/blood_type/target, datum/blood_type/filter, datum/blood_type/to_insert, mode_remove)
	testing("exec_MEBC initialized. If it stops here... idk?")
	var/list/compat_list = list()
	var/readout
	compat_list = target?.get_compatibility() //can not execute?
	if(isnull(compat_list))
		testing("[target] skipped, could not retrieve compatible_types OR compatible_types empty... for some reason")
		return
	testing("compat_list generated")
	if(isnull(filter))
		testing("filter null")
	if(filter in compat_list)
		testing("filter found in target.compatible_types")
	else
		testing("filter not found in target.compatible_types, AND not null")
		return
	switch(mode_remove)
		if(TRUE)
			compat_list -= to_insert
		else
			compat_list += to_insert
	target.compatible_types = compat_list
	for(var/i as anything in target.compatible_types)
		readout += "[i], "
		testing("[target] succesfully modified; new compatabilities are: [readout]")
	return

