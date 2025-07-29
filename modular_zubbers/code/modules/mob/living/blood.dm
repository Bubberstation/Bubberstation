///Attempts to add/remove the origin blood type to the compatible_types list of all blood types (with the filter)
/datum/blood_type/proc/init_mass_edit_blood_compatibility(datum/blood_type/filter, mode_remove = FALSE)
	testing("mass_edit_blood_compatibility initialized with filter as [filter], and injection as [to_insert]")
	for(var/datum/blood_type/target as anything in subtypesof(/datum/blood_type))
		testing("mass_edit_blood_compatibility target is [target.type]") //this reads as the datum typepath...
		if(target?.root_abstract_type == target) // Let's not modify placeholders
			testing("[target] skipped, abstract")
			testing("printing [target::root_abstract_type]")
			continue
		testing("[target] isn't abstract. If it stops here... idk?")
		exec_MEBC(target, filter, type, mode_remove)
	return

/datum/blood_type/proc/exec_MEBC(datum/blood_type/target, datum/blood_type/filter, datum/blood_type/to_insert, mode_remove)
	testing("exec_MEBC initialized. target is [target], filter is [filter], to_insert is [to_insert], mode is [mode_remove]")
	var/list/compat_list = list()
	var/readout
	if(isnull(target))
		CRASH("target null. breaking")
	if(isnull(filter))
		CRASH("filter null. breaking. Run using init_mass_edit_blood_compatibility")
	compat_list = target.get_compatible() //can not execute?
	if(isnull(compat_list))
		CRASH("[target] skipped, could not retrieve compatible_types OR compatible_types empty... for some reason")
	testing("compat_list generated")
	if(isnull(filter))
		testing("filter null")
	if(filter in compat_list)
		testing("filter found in target.compatible_types")
	else
		CRASH("filter not found in target.compatible_types, AND not null")
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

