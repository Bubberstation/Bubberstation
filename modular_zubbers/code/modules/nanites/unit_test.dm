
/datum/unit_test/nanite_designs/Run()
//Can't use allocate because of bug with certain datums
	var/datum/design/nanites/default_design_nanites = new /datum/design/nanites()

	for(var/path in subtypesof(/datum/design))
		var/datum/design/nanites/current_design = new path //Create an instance of each design
		if (isnull(current_design.program_type) || current_design.program_type == default_design_nanites.program_type) //Check if the Nanite design provides a program
			Fail("Nanite Design [current_design.type] does not have have any program_type set")
